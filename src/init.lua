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
--- @prop _IndexedListeners Listeners
--- @within Proxy
--- @readonly

--- Table of functions that fire when a key is added to the proxy or changed
--- @prop _ChangedListeners Listeners
--- @within Proxy
--- @readonly


--[=[
    Returns a callback function that must be called to disconnect a listeners

    @private
    @since v3.0.0

    @function ListenToDisconnection
    @within Proxy

    @param Callback (...any?) -> ()
    @param Source table -- Where to store active callbacks
    @return (CheckConnectionStatus: boolean) -> ()
]=]
local function ListenToDisconnection(Callback: (...any?) -> (), Source: Listeners): Connection
    Source[Callback] = true

    return function(CheckConnectionStatus: boolean?): boolean
        if CheckConnectionStatus then
            return Source[Callback]
        end

        if not Source[Callback] then
            return false
        end

        Source[Callback] = nil

        return true
    end
end

--[=[
    Connects passed callback to a signal that fires when a key is indexed

    @since v3.0.0

    @method OnIndex
    @within Proxy

    @param Callback (Key: string?, Value: any?, Proxy: Proxy?) -> ()
    @return Connection
]=]
function OnIndex(self: Proxy, Callback: (Key: string?, Value: any?, Proxy: Proxy?) -> ()): Connection
    return ListenToDisconnection(Callback, self._IndexedListeners)
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
    return ListenToDisconnection(Callback, self._ChangedListeners)
end

--[=[
    Destroys the proxy and disconnects all listeners

    @method Destroy
    @within Proxy

    @return nil
]=]
function Destroy(self: Proxy): nil
    setmetatable(self, nil)
    self = nil

    return nil
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

    @param Key string
    @return any
]=]
function Get(self: Proxy, Key: string): any
    return self._Proxy[Key]
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

    @param Key string
    @param Value any
    @return any -- Returns the value that was initially passed
]=]
function Set(self: Proxy, Key: string, Value: any): any
    self._Proxy[Key] = Value
    return Value
end

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

    @param Table table
    @return boolean
]=]
function Proxy.IsProxy(Table: table): boolean
    return getmetatable(Table) == Proxy
end

--[=[
    Creates a new proxy object

    @tag Constructor

    @within Proxy

    @param Origin table? -- Optional table to use as template for the proxy table
    @param CustomProperties {[string]: any}? -- Custom properties can be added to the proxy before constructing it
    @return Proxy
]=]
function Proxy.new(Origin: table?, CustomProperties: {[string]: any}?): Proxy
	local self = {
        _Proxy = if Origin then Origin else {},
        _IndexedListeners = {},
        _ChangedListeners = {},
    }

    if CustomProperties then
        for Property, Value in pairs(CustomProperties) do
            if self[Property] ~= nil then
                warn("Tried to override default proxy property with custom property: "..Property..". Action was rejected")
            else
                self[Property] = Value
            end
        end
    end

    self._Methods = {
        Destroy = Destroy,
        OnIndex = OnIndex,
        OnChange = OnChange,
        Get = Get,
        Set = Set
    }

	return setmetatable(self, Proxy)
end

--[=[
    Fires all the listeners from the specified source along with the passed arguments

    @private
    @since v3.0.0

    @function FireListeners
    @within Proxy

    @param Source Listeners
    @param ... any -- These are the arguments passed to the callback
    @return nil
]=]
local function FireListeners(Source: Listeners, ...: any)
    for Callback: (...any) -> (...any) in pairs(Source) do
        task.spawn(Callback, ...)
    end
end

--[=[
    Fires index listeners and returns the key's value

    :::note Class members can also be indexed
    Proxy's properties or methods can be returned when indexing them. To only get
    or set actual values from the proxy table, use the [Proxy:Set] and [Proxy:Get] methods

    @private
    @tag Metamethod

    @param Key string
    @return any
]=]
function Proxy:__index(Key: string): any
    if Key == "OnIndex" or Key == "OnChange" or Key == "Destroy" or Key == "Get" or Key == "Set" then
        return self._Methods[Key] -- Methods are found inside a table and must be returned like this when indexed
    end

    local Value: any = self._Proxy[Key]

    FireListeners(self._IndexedListeners, Key, Value, self)

	return Value
end

--[=[
    Fires change listeners. Change listeners will only fire if the updated value
    differs from its last version

    :::tip Child proxies are automatically cleaned up
    When a key's value is changed, if the old value is a proxy object, it will automatically
    be destroyed using the `Destroy` method

    @private
    @tag Metamethod

    @param Key string
    @param Value any
    @return nil
]=]
function Proxy:__newindex(Key: string, Value: any)
	local CurrentValue: any = self._Proxy[Key]

	if CurrentValue ~= Value then
        if type(CurrentValue) == "table" and getmetatable(CurrentValue) == Proxy then
            CurrentValue:Destroy()
        end

        self._Proxy[Key] = Value

        FireListeners(self._ChangedListeners, Key, Value, CurrentValue, self)
	end
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

type Proxy = typeof(Proxy.new())

return Proxy