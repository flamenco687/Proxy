local Signal = require(script.Parent.Signal)

--[=[
    @class Proxy

    Class designed to work as a proxy for tables. If a key is indexed, the proxy
    will fire an indexed signal. If a key's value is changed, the proxy will
    fire a changed signal
    ```lua
    local proxy = Proxy.new()

    proxy.Changed:Connect(function(Key, Value)
        print(Key, Value)
    end)

    proxy.Test = 10 -- This will print out: Test 10
    ```
]=]
local Proxy = {}
Proxy.__index = Proxy

--- @prop Proxy table
--- @within Proxy

--- @prop Indexed Signal
--- @within Proxy

--- @prop Changed Signal
--- @within Proxy

--[=[
    Creates a new Proxy class.

    @param Origin table -- The table for which the proxy will be created
    @return Proxy
]=]
function Proxy.new(Origin: table, InheritProxies: boolean?): Proxy
	local self = {
        Proxy = Origin or {},
        Indexed = Signal.new(),
        Changed = Signal.new(),
        InheritProxies = if InheritProxies then InheritProxies else false
    }

	return setmetatable(self, Proxy)
end

--[=[
    Destroy the proxy and disconnect all connections.

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
    Fires an internal signal when a Value is indexed

    @private
    @return any
]=]
function Proxy:__index(Key: string): any
    local Value = self.Proxy[Key]

    self.Indexed:Fire(Key, Value)

	return Value
end

--[=[
    Fires an internal signal when a new Value is indexed

    @private
    @return nil
]=]
function Proxy:__newindex(Key: string, Value: any): nil
	local CurrentValue = self.Proxy[Key]

	if CurrentValue ~= Value then
        if type(CurrentValue) == "table" and getmetatable(CurrentValue) == Proxy then
            CurrentValue:Destroy()
        end

        if type(Value) == "table" and self.InheritProxies then
            self.Proxy[Key] = Proxy.new(Value, true)
        else
            self.Proxy[Key] = Value
        end

        self.Changed:Fire(Key, Value)
	end
end

export type Proxy = typeof(Proxy.new())

return Proxy