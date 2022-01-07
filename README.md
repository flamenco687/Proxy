<p align="center">
  <img src="https://user-images.githubusercontent.com/36084202/148556718-46033e98-6be6-43b1-85a6-cd0f6097a43e.png">
</p>

---
Ever heard of proxies? Well, this one is a little bit different. Proxy's purpose is not working as a layer of communication between two machines but instead, working as an intermediary between the Server/Client and a table.

Ever tried to detect changes in a roblox vanilla table? Well, I tried and found out that it wasn't possible by default because there are no functions nor metamethods to do so. After a while searching I finally found out that the only way to detect direct changes and indexes of a table was by using a proxy table. 

This is done by detecting indexes or newindexes inside the main table and passing or returning the values from the proxy table so the main one always remains empty and always transmits changes. 

So that's it, one metatable, two metamethods and a normal table to detect changes in vanilla tables, but if you want some extra functionality here it is, Proxy. *We've got moonwave documentation, wohoo!*

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
# Installing Proxy
### Wally
Proxy is avaible as a [wally package](https://wally.run/package/flamenco687/roblox-proxy)! Just go ahead and add it to your *wally.toml* as a dependency
```toml
[dependencies]
Proxy = "flamenco687/roblox-proxy@3.1.1"
```
### Github releases
[Download the latest release](https://github.com/flamenco687/Proxy/releases/tag/v3.1.1)
### Roblox
By the time being, Proxy still has no roblox model to get from the library but it'll soon be avaible.
# Contributing
Proxy was made for personal use and may not adequate for all use-cases, if you want to add your own point of view and ideas to proxy feel free to contribute by forking it, commiting changes and opening pull requests. 

If you find issues don't even ask yourself and report it! Proxy is a really simple library so if I see any open issue I'll... I'll be surprised, for sure.
