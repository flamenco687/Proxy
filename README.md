![proxy-banner-no_background](https://user-images.githubusercontent.com/36084202/148576482-a52bd673-dea5-414a-ac80-4108d55e4c4d.png)

---

### ⚠️ WARNING! ⚠️
This is a quick note on the fact that Proxy is no longer being mantained. It has shown to not be really useful. However, you may still use the source code at your will and with learning purposes.

---

Ever heard of [proxies](https://en.wikipedia.org/wiki/Proxy_server)? Well, this one is a little bit different. Proxy's purpose is not working as a layer of communication between two machines but instead, working as an intermediary between the Server/Client and a table.

Ever tried to detect changes in a roblox vanilla table? Well, I tried and found out that it wasn't possible by default because there are no functions nor metamethods to do so. After a while searching I finally found out that the only way to detect direct changes and indexes of a table was by using a proxy table. 

This is done by detecting indexes or newindexes inside the main table and passing or returning the values from the proxy table so the main one always remains empty and always notices changes. 

So that's it, one metatable, two metamethods and a normal table to detect changes in vanilla tables, but if you want some extra functionality here it is, Proxy.

```lua
local ProxyClass = require(Source.Proxy)
local Proxy = ProxyClass.new()

Proxy:OnIndex(function(Key: string, Value: any)) -- Will not fire when the key changes but when it is indexed (ex.: print)
    print("Indexed ->", Key, Value)
end)

local Disconnect = Proxy:OnChange(function(Key: string, Value: any, OldValue: any)
    print("Changed ->", Key, Value, OldValue)
end)

Proxy.Test = 10 -- Output: Changed -> Test 10 nil

print(Proxy.Test) -- 1st Output: 10
                  -- 2nd Output: Indexed -> Test 10
                  
print(ProxyClass.IsProxy(Proxy)) -- Output: true

Disconnect() -- The connection gets disconnected by just calling it, magic! Inspired by Fusion by Elttob

Proxy.Test = 50 -- Nothing prints out
```
# Installation
<div align="center">

[![wally-badge|240x80, 75%](https://user-images.githubusercontent.com/36084202/222930045-a4716c2d-0ac4-4010-8bd7-c184b31bd539.svg)](https://wally.run/package/flamenco687/roblox-proxy) [![github-badge|240x80, 75%](https://user-images.githubusercontent.com/36084202/222930062-baf235c6-a1a2-455c-b59f-bb3ef31cf7e7.svg)](https://github.com/flamenco687/Proxy/releases/tag/v3.1.1)

</div>
