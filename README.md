# Proxy
 Roblox library to detect changes in vanilla tables

```lua
local Proxy = Proxy.new({ Test = 10 })

Proxy.Changed:Connect(function(Key: string, Value: any)
    print(Key, Value)
end)

Proxy.Test -= 1 -- This will print out: Test 9
```
