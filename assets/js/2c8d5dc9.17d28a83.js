"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[295],{65133:function(e){e.exports=JSON.parse('{"functions":[{"name":"ListenToDisconnection","desc":"Returns a callback function that must be called to disconnect a listeners","params":[{"name":"Callback","desc":"","lua_type":"(...any?) -> ()"},{"name":"Source","desc":"Where to store active callbacks","lua_type":"table"}],"returns":[{"desc":"","lua_type":"(CheckConnectionStatus: boolean) -> ()"}],"function_type":"static","since":"v3.0.0","private":true,"source":{"line":60,"path":"src/init.lua"}},{"name":"OnIndex","desc":"Connects passed callback to a signal that fires when a key is indexed","params":[{"name":"Callback","desc":"","lua_type":"(Key: string?, Value: any?, Proxy: Proxy?) -> ()"}],"returns":[{"desc":"","lua_type":"Connection"}],"function_type":"method","since":"v3.0.0","source":{"line":93,"path":"src/init.lua"}},{"name":"OnChange","desc":"Connects passed callback to a signal that fires when a key is added or changed","params":[{"name":"Callback","desc":"","lua_type":"(Key: string?, Value: any?, OldValue: any?, Proxy: Proxy?) -> ()"}],"returns":[{"desc":"","lua_type":"Connection"}],"function_type":"method","since":"v3.0.0","source":{"line":108,"path":"src/init.lua"}},{"name":"Destroy","desc":"Destroys the proxy and disconnects all listeners","params":[],"returns":[{"desc":"","lua_type":"nil"}],"function_type":"method","source":{"line":120,"path":"src/init.lua"}},{"name":"Get","desc":"Specifically looks for the desired key inside the proxy table.\\n\\n```lua\\nprint(Proxy._Proxy)        -- Outputs: {}\\nprint(Proxy:Get(\\"_Proxy\\")) -- Outputs: nil\\n\\n-- Proxy._Proxy is the proxy table, since it is empty it returns an empty table\\n-- Proxy:Get(\\"_Proxy\\") is actually looking for Proxy._Proxy[\\"_Proxy\\"], which is nil\\n```\\n\\n:::info\\nUse this in case the proxy object has a property that is also a key inside the proxy table","params":[{"name":"Key","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"any"}],"function_type":"method","since":"v3.0.0","source":{"line":149,"path":"src/init.lua"}},{"name":"Set","desc":"Specifically sets the value for the desired key inside the proxy table.\\n\\n```lua\\nProxy:Set(\\"_Proxy\\", 10)\\n\\nprint(Proxy._Proxy)        -- Outputs: { _Proxy = 10 }\\nprint(Proxy:Get(\\"_Proxy\\")) -- Outputs: 10\\n\\n-- :Set() will only modify values inside Proxy._Proxy\\n```\\n\\n:::info\\nUse this in case the proxy object has a property that is also a key inside the proxy table","params":[{"name":"Key","desc":"","lua_type":"string"},{"name":"Value","desc":"","lua_type":"any"}],"returns":[{"desc":"Returns the value that was initially passed","lua_type":"any"}],"function_type":"method","since":"v3.0.0","source":{"line":177,"path":"src/init.lua"}},{"name":"IsProxy","desc":"Checks if a given table is or not a proxy (checks its metatable)\\n```lua\\nlocal Proxy = require(Source.Proxy)\\n\\nlocal NewProxy = Proxy.new()\\n\\nprint(Proxy.IsProxy(NewProxy)) -- Output: true\\nprint(Proxy.IsProxy({}))       -- Output: false\\n```\\n\\n:::caution\\nTo check if a table is a proxy, you should call `.IsProxy()` using the required [ModuleScript] or\\nthe function will throw out an error since the created proxy class does not contain the function","params":[{"name":"Table","desc":"","lua_type":"table"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","since":"v3.1.0","source":{"line":204,"path":"src/init.lua"}},{"name":"new","desc":"Creates a new proxy object","params":[{"name":"Origin","desc":"Optional table to use as template for the proxy table","lua_type":"table?"},{"name":"CustomProperties","desc":"Custom properties can be added to the proxy before constructing it","lua_type":"{[string]: any}?"}],"returns":[{"desc":"","lua_type":"Proxy"}],"function_type":"static","tags":["Constructor"],"source":{"line":219,"path":"src/init.lua"}},{"name":"FireListeners","desc":"Fires all the listeners from the specified source along with the passed arguments","params":[{"name":"Source","desc":"","lua_type":"Listeners"},{"name":"...","desc":"These are the arguments passed to the callback","lua_type":"any"}],"returns":[{"desc":"","lua_type":"nil"}],"function_type":"static","since":"v3.0.0","private":true,"source":{"line":260,"path":"src/init.lua"}},{"name":"__index","desc":"Fires index listeners and returns the key\'s value\\n\\n:::note Class members can also be indexed\\nProxy\'s properties or methods can be returned when indexing them. To only get\\nor set actual values from the proxy table, use the [Proxy:Set] and [Proxy:Get] methods","params":[{"name":"Key","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"any"}],"function_type":"method","tags":["Metamethod"],"private":true,"source":{"line":279,"path":"src/init.lua"}},{"name":"__newindex","desc":"Fires change listeners. Change listeners will only fire if the updated value\\ndiffers from its last version\\n\\n:::tip Child proxies are automatically cleaned up\\nWhen a key\'s value is changed, if the old value is a proxy object, it will automatically\\nbe destroyed using the `Destroy` method","params":[{"name":"Key","desc":"","lua_type":"string"},{"name":"Value","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"nil"}],"function_type":"method","tags":["Metamethod"],"private":true,"source":{"line":306,"path":"src/init.lua"}}],"properties":[{"name":"_Proxy","desc":"Table that acts as the proxy. All keys will automatically be added or indexed from this table except if `rawset` or `rawget` are used","lua_type":"table","readonly":true,"source":{"line":35,"path":"src/init.lua"}},{"name":"_IndexedListeners","desc":"Table of functions that fire when a proxy\'s key is indexed","lua_type":"Listeners","readonly":true,"source":{"line":40,"path":"src/init.lua"}},{"name":"_ChangedListeners","desc":"Table of functions that fire when a key is added to the proxy or changed","lua_type":"Listeners","readonly":true,"source":{"line":45,"path":"src/init.lua"}}],"types":[{"name":"table","desc":"Represents a table that could contain any value indexed by anything","lua_type":"{[any]: any}","source":{"line":324,"path":"src/init.lua"}},{"name":"Connection","desc":"Represents a connection between a callback and a listener. To disconnect it, the function must be called","lua_type":"(CheckConnectionStatus: boolean) -> boolean","source":{"line":329,"path":"src/init.lua"}},{"name":"Listeners","desc":"Represents a list of callbacks that will listen to changes of the desired property, table, etc...","lua_type":"{[(...any) -> (...any)]: boolean}","source":{"line":334,"path":"src/init.lua"}}],"name":"Proxy","desc":"Class designed to work as a proxy table. Functions can be connected to listen for\\nkey indexing or key changes/additions\\n\\n```lua\\nlocal Proxy = Proxy.new()\\n\\nProxy:OnIndex(function(Key: string, Value: any) --! Will not fire when the key changes\\n    print(\\"Indexed ->\\", Key, Value)\\nend)\\n\\nlocal Disconnect = Proxy:OnChange(function(Key: string, Value: any, OldValue: any)\\n    print(\\"Changed ->\\", Key, Value, OldValue)\\nend)\\n\\nProxy.Test = 10 -- Output: Changed -> Test 10 nil\\n\\nprint(Proxy.Test) -- 1st Output: Indexed -> Test 10\\n                  -- 2nd Output: 10\\n\\nDisconnect() -- The connection gets disconnected by just calling it, magic!\\n\\nProxy.Test = 50 -- Nothing prints out\\n```","source":{"line":28,"path":"src/init.lua"}}')}}]);