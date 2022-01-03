local Signal = require(script.Parent.Signal)

--[=[
    @class Proxy

    Class designed to work as a proxy for tables. If a key is indexed, the proxy
    will fire an indexed signal. If a key's value is changed, the proxy will
    fire a changed signal
    ```lua
    local Proxy = Proxy.new()

    Proxy.Changed:Connect(function(Key: string, Value: any)
        print(Key, Value)
    end)

    Proxy.Test = 10 -- This will print out: Test 10
    ```
]=]
local Proxy = {}
Proxy.__index = Proxy

--- Table as a proxy. All keys added to the Proxy object are added to this table
--- @prop Proxy table
--- @within Proxy

--- Signal fired when a proxy's key is indexed
--- ```lua
--- local Value = if Proxy.Something then true else nil -- Indexed is fired, we got Something value
--- ```
--- @prop Indexed Signal
--- @within Proxy

--- Signal fired when a new key is added to the proxy or when a key's value changes
--- @prop Changed Signal
--- @within Proxy

--- Defines if tables added to the proxy should be converted to a proxy that inherits its parent proxy properties
--- @prop InheritProxies boolean
--- @within Proxy

--[=[
    Creates a new Proxy class.

    @within Proxy
    @param Origin? table -- Optional table to convert and use as the proxy
    @param InheritProxies? boolean -- Should other tables added to the proxy become a proxy with same properties?
    @param CustomProperties? table -- Custom properties that can be added on creation of the proxy and its children (equivalent of using rawset)
    @return Proxy
]=]
function Proxy.new(Origin: table?, InheritProxies: boolean?, CustomProperties: table?): Proxy
	local self = {
        Proxy = if Origin then Origin else {},
        Indexed = Signal.new(),
        Changed = Signal.new(),
        InheritProxies = if InheritProxies then InheritProxies else false
    }

    for Property, Value in pairs(CustomProperties) do
        self[Property] = Value
    end

    if InheritProxies and Origin ~= {} then
        for Key, Value in pairs(self.Proxy) do
            if type(Value) == "table" then
                self.Proxy[Key] = Proxy.new(Value, true, CustomProperties)
            end
        end
    end

	return setmetatable(self, Proxy)
end

--[=[
    Destroys the proxy and disconnects all of its connections.

    @return nil
]=]
function Proxy:Destroy(): nil
    self.Indexed:Destroy()
    self.Changed:Destroy()

    setmetatable(self, nil)
    self = nil

    return nil
end

--[=[
    Fires `Indexed` signal when a key is indexed and returns
    the key's value

    @private
    @param Key string
    @return any
]=]
function Proxy:__index(Key: string): any
    local Value: any = self.Proxy[Key]

    self.Indexed:Fire(Key, Value)

	return Value
end

--[=[
    Fires `Changed` signal when a key gets modified
    or added to the proxy. `Changed` will only fire
    if the value differs from its last version, even
    though `__newindex` fires in every change or key
    addition

    @private
    @param Key string
    @param Value any
    @return nil
]=]
function Proxy:__newindex(Key: string, Value: any): nil
	local CurrentValue: any = self.Proxy[Key]

	if CurrentValue ~= Value then
        if type(CurrentValue) == "table" and getmetatable(CurrentValue) == Proxy then
            CurrentValue:Destroy()
        end

        if type(Value) == "table" and self.InheritProxies then

            local CustomProperties: table?

            if #self > 4 then -- If more than 4 properties are found inside the proxy, they are considered custom properties to inherit
                CustomProperties = {}

                for PropertyName, PropertyValue in pairs(self) do
                    CustomProperties[PropertyName] = PropertyValue
                end
            end

            self.Proxy[Key] = Proxy.new(Value, true, if CustomProperties then CustomProperties else nil)
        else
            self.Proxy[Key] = Value
        end

        self.Changed:Fire(Key, Value)
	end
end

--- Used to represent a table instead of typing {} since its more visual and I'm used to it
--- @type table {}
--- @within Proxy
type table = {}

export type Proxy = typeof(Proxy.new())

return Proxy