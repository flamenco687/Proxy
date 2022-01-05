# Proxy
 Roblox library to detect changes in vanilla tables

```lua
local Proxy = Proxy.new()

Proxy:OnIndex(function(Key: string, Value: any)) --! Will not fire when the key changes
    print("Indexed ->", Key, Value)
end)

local Disconnect = Proxy:OnChange(function(Key: string, Value: any, OldValue: any)
    print("Changed ->", Key, Value, OldValue)
end)

Proxy.Test = 10 -- Output: Changed -> Test 10 nil

print(Proxy.Test) -- 1st Output: 10
                -- 2nd Output: Indexed -> Test 10

Disconnect() -- The connection gets disconnected by just calling it, magic!

Proxy.Test = 50 -- Nothing prints out
```
