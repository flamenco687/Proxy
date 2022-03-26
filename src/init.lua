local ActiveListeners: ActiveListeners = {}

--[=[
    @class Proxy

    Class designed to work as a proxy table. Functions can be connected to listen for
    key indexing or key changes/additions

    ```lua
    local Proxy = Proxy.new()

    Proxy:OnIndex(function(Key: string, Value: any) --! Will not fire when the key changes
        print("Indexed ->", Key, Value)
    end)

    local Disconnect = Proxy:OnChange(function(Key: string, Value: any, OldValue: any)
        print("Changed ->", Key, Value, OldValue)
    end)

    Proxy.Test = 10 -- Output: Changed -> Test 10 nil

    print(Proxy.Test) -- 1st Output: Indexed -> Test 10
                      -- 2nd Output: 10

    Disconnect() -- The connection gets disconnected by just calling it, magic!

    Proxy.Test = 50 -- Nothing prints out
    ```
]=]
local Proxy = {}
Proxy.__index = Proxy

--- Table that acts as the proxy. All keys will automatically be added or indexed from this table except if `rawset` or `rawget` are used
--- @prop _Proxy table
--- @within Proxy
--- @readonly

--- Table of functions that fire when a proxy's key is indexed
--- @prop IndexListeners Listeners
--- @within Proxy
--- @readonly

--- Table of functions that fire when a key is added to the proxy or changed
--- @prop ChangeListeners Listeners
--- @within Proxy
--- @readonly


--[=[
    Returns a callback function that must be called to disconnect a listeners

    @private
    @since v3.0.0

    @function ListenToDisconnection
    @within Proxy
]=]
local function ListenToDisconnection(self: Proxy, Callback: (...any?) -> (), Source: string): Connection
    ActiveListeners[self][Source][Callback] = true

    local Connection: Connection

    Connection = function(CheckConnectionStatus: boolean?): boolean?
        local SourceStillExists: boolean = ActiveListeners[self] and ActiveListeners[self][Source]

        if SourceStillExists then
            if CheckConnectionStatus then
                return if SourceStillExists and ActiveListeners[self][Source][Callback] then true else nil
            end

            if not ActiveListeners[self][Source][Callback] then
                return nil
            end

            ActiveListeners[self][Source][Callback] = nil
            Connection = nil

            return nil
        else
            return nil
        end
    end

    return Connection
end

--[=[
    Fires all the listeners from the specified source along with the passed arguments

    @since v3.0.0

    @private

    @function FireListeners
    @within Proxy
]=]
local function FireListeners(Source: Listeners, ...: any)
    for Callback: (...any) -> (...any) in pairs(Source) do
        task.spawn(Callback, ...)
    end
end

--[=[
    Connects passed callback to a signal that fires when a key is indexed

    @since v3.0.0

    @method OnIndex
    @within Proxy
]=]
function OnIndex(self: Proxy, Callback: (Key: string?, Value: any?, Proxy: Proxy?) -> ()): Connection
    return ListenToDisconnection(self, Callback, "IndexListeners")
end

--[=[
    Connects passed callback to a signal that fires when a key is added or changed

    @since v3.0.0

    @method OnChange
    @within Proxy

    @param Callback (Key: string?, Value: any?, OldValue: any?, Proxy: Proxy?) -> ()
    @return Connection
]=]
function OnChange(self: Proxy, Callback: (Key: string?, Value: any?, OldValue: any?, Proxy: Proxy?) -> ()): Connection
    return ListenToDisconnection(self, Callback, "ChangeListeners")
end

--[=[
    Destroys the proxy and disconnects all listeners

    @method Destroy
    @within Proxy
]=]
function Destroy(self: Proxy): nil
    if ActiveListeners[self] then
        for _, Listeners: Listeners in pairs(ActiveListeners[self]) do
            for Connection: Connection in pairs(Listeners) do
                Connection()
            end

            Listeners = nil
        end

        ActiveListeners[self] = nil
    end

    setmetatable(self, nil)
    self = nil

    return nil
end

--[=[
    Fires index listeners and returns the key's value

    :::note Class members can also be indexed
    Proxy's properties or methods can be returned when indexing them. To only get
    or set actual values from the proxy table, use the [Proxy:Set] and [Proxy:Get] methods

    @private

    @within Proxy
]=]
local function Index(self: Proxy, Key: string): any
    local Value: any = self._Proxy[Key]

    if Key ~= nil and Value ~= nil then -- Otherwise, index listeners will get fired while destroying the proxy
        FireListeners(ActiveListeners[self].IndexListeners, Key, Value, self)
    end

	return Value
end

--[=[
    Fires change listeners. Change listeners will only fire if the updated value
    differs from its last version

    :::tip Child proxies are automatically cleaned up
    When a key's value is changed, if the old value is a proxy object, it will automatically
    get cleaned up using [Proxy:Destroy]

    @private

    @within Proxy
]=]
local function NewIndex(self: Proxy, Key: string, Value: any)
    local CurrentValue: any = self._Proxy[Key]

	if CurrentValue ~= Value then
        if type(CurrentValue) == "table" and Proxy.IsProxy(CurrentValue) then
            CurrentValue:Destroy()
        end

        self._Proxy[Key] = Value

        if Key ~= nil and Value ~= nil then -- Otherwise, index listeners will get fired while destroying the proxy
            FireListeners(ActiveListeners[self].ChangeListeners, Key, Value, CurrentValue, self)
        end
	end
end

--[=[
    Specifically looks for the desired key inside the proxy table.

    ```lua
    print(Proxy._Proxy)        -- Outputs: {}
    print(Proxy:Get("_Proxy")) -- Outputs: nil

    -- Proxy._Proxy is the proxy table, since it is empty it returns an empty table
    -- Proxy:Get("_Proxy") is actually looking for Proxy._Proxy["_Proxy"], which is nil
    ```

    :::info
    Use this in case the proxy object has a property that is also a key inside the proxy table

    @since v3.0.0

    @method Get
    @within Proxy
]=]
function Get(self: Proxy, Key: string): any
    return Index(self, Key)
end

--[=[
    Specifically sets the value for the desired key inside the proxy table.

    ```lua
    Proxy:Set("_Proxy", 10)

    print(Proxy._Proxy)        -- Outputs: { _Proxy = 10 }
    print(Proxy:Get("_Proxy")) -- Outputs: 10

    -- :Set() will only modify values inside Proxy._Proxy
    ```

    :::info
    Use this in case the proxy object has a property that is also a key inside the proxy table

    @since v3.0.0

    @method Set
    @within Proxy
]=]
function Set(self: Proxy, Key: string, Value: any): any
    return NewIndex(self, Key, Value)
end

local Methods = {
    Get = Get,
    Set = Set,
    Destroy = Destroy,
    OnIndex = OnIndex,
    OnChange = OnChange,
}

--[=[
    Checks if a given table is or not a proxy (checks its metatable)
    ```lua
    local Proxy = require(Source.Proxy)

    local NewProxy = Proxy.new()

    print(Proxy.IsProxy(NewProxy)) -- Output: true
    print(Proxy.IsProxy({}))       -- Output: false
    ```

    :::caution
    To check if a table is a proxy, you should call `.IsProxy()` using the required [ModuleScript] or
    the function will throw out an error since the created proxy class does not contain the function

    @since v3.1.0

    @within Proxy
]=]
function Proxy.IsProxy(Table: table): boolean
    return getmetatable(Table) == Proxy
end

--[=[
    Creates a new proxy object

    @tag Constructor

    @within Proxy
]=]
function Proxy.new(Origin: table?): Proxy
	local self = { _Proxy = if Origin then Origin else {} }

    ActiveListeners[self] = {
        IndexListeners = {},
        ChangeListeners = {},
    }

	return setmetatable(self, Proxy)
end

function Proxy:__index(Key: string): any
    if Methods[Key] then
        return Methods[Key] -- Methods are found inside a table and must be returned like this when indexed
    else
        return Index(self, Key)
    end
end

function Proxy:__newindex(Key: string, Value: any)
	return NewIndex(self, Key, Value)
end

type table = {[any]: any}
--- Represents a table that could contain any value indexed by anything
--- @type table {[any]: any}
--- @within Proxy

type Connection = (CheckConnectionStatus: boolean?) -> boolean
--- Represents a connection between a callback and a listener. To disconnect it, the function must be called
--- @type Connection (CheckConnectionStatus: boolean) -> boolean
--- @within Proxy

type Listeners = {[(...any) -> (...any)]: boolean}
--- Represents a list of callbacks that will listen to changes of the desired property, table, etc...
--- @type Listeners {[(...any) -> (...any)]: boolean}
--- @within Proxy

type ActiveListeners = {
    [table]: {
        IndexListeners: Listeners,
        ChangeListeners: Listeners,
    }
}

type Proxy = {
    _Proxy: table,

    IsProxy: (Table: table) -> boolean,

    OnChange: (self: Proxy, Callback: (Key: string?, Value: any?, OldValue: any?, Proxy: Proxy?) -> ()) -> Connection,
    OnIndex: (self: Proxy, Callback: (Key: string?, Value: any?, Proxy: Proxy?) -> ()) -> Connection,
    Set: (self: Proxy, Key: string, Value: any) -> any,
    Get: (self: Proxy, Key: string) -> any,
    Destroy: (self: Proxy) -> nil
}

return Proxy