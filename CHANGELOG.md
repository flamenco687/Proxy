## v3.1.3 - 2022-27-03

### Removed
- Removed the ability to specify custom properties on proxy creation. `rawset()` should be used instead after its creation

### Improvements
- Moved proxy methods and listeners to a separate table that doesn't collide with possible proxy keys
- Improved documentation

### Changes
- `.IsProxy()` is now used to check if a removed table from a proxy is also a proxy that should be automatically destroyed

### Fixed
- Fix listeners not being triggered by `:Get()` and `:Set()` methods
- Fix `:Destroy()` not cleaning up connections on removal
- Fix Proxy type not showing correctly its methods
- Fix connections not getting disconnected
- Fix connections not getting cleaned up when destroying the proxy object
- Fix connections not representing their current state accordingly when passing the first argument

---

## v3.1.2 - 2022-20-01

### Fixed
- Connection callbacks did not reflect accurately the connection status if the proxy was destroyed before disconnecting the task

---

## v3.1.1 - 2022-07-01

### Upgraded
- Moonwave: [0.2.12] -> [0.3.3] 

### Added
- Type: Connection = `(CheckConnectionStatus: boolean?) -> boolean | nil`
- Type: Listeners = `{[(...any) -> (...any)]: boolean}`
- A first argument can now be passed when firing a connection to check if its still connected instead of disconnecting it

### Changes
- Connections now return a boolean depending on the connection status where false is not connected and true connected

### Improvements
- Improved type annotations
- Improved method documentations
- Type table now reflects what it had to reflect

---

## v3.1.0 - 2022-06-01

### Added
- `Proxy.IsProxy()` can now be called to check if given table is a proxy or not (function must be called by indexing it from the Proxy module instead of the proxy object)

    ```lua
    local Proxy = require(Source.Proxy)

    local NewProxy = Proxy.new()

    print(Proxy.IsProxy(NewProxy))    -- Output: true
    print(NewProxy.IsProxy(NewProxy)) -- Errors: attempt to call a nil value

    print(Proxy.IsProxy({})) -- Output: false
    ```
- Missing moonwave documentation for `ListenToDisconnection()`
- Missing type annotation

---

## v3.0.0 - 2022-05-01

### Added
- `Proxy:OnChange()` in replacement of `.Changed`, directly connects the passed functions and can be disconnected by calling the returned function
- `Proxy:OnIndex()` in replacement of `.Indexed`, directly connects the passed functions and can be disconnected by calling the returned function
- `Proxy:Set()` and `Proxy:Get()` to interact with values inside the proxy table that are proxy properties or methods
- Better documentation and extra functions regarding the new connections system

### Removed
- Signal dependency
- Proxies cannot longer inherit or convert other tables in proxies by default, that implementation must be done externally now to keep it simpler

### Changes
- Overhauled most documentation
- Changed the way change or index listeners are handled as part of the Signal removal
- Proxy methods are stored inside a table to prevent conflicts with indexing

### Improvements
- When adding custom properties to a proxy, default proxy properties are protected and cannot be overriden. Trying to do so will throw a warning
- Simplified the code

### Fixed
- A lot of issues, in general. The module should have near to 0 bugs

---

## v2.1.4 - 2022-04-01

### Added
- `Indexed` & `Changed` now pass the proxy as a third argument

---

## v2.1.3 - 2022-03-01

### Fixed
- Proxies didn't inherit parent's custom properties
- `build` folder ([Moonwave](https://upliftgames.github.io/moonwave/) page) was being included inside the package installation, updated wally.toml exclude

---

## v2.1.2 - 2022-03-01

### Fixed
- Constructor attempted to check the lenght of a nil value when checking if children proxies should inherit properties

---

## v2.1.1 - 2022-03-01

### Fixed
- Fixed `.new()` trying to iterate through CustomProperties even if it is nil
- Fixed passing default proxy properties as custom properties when constructing a new proxy from `__newindex` 

---

## v2.1.0 - 2022-03-01

*Since this version, the Proxy project uses the default tree structure of `src/init.lua` so moonwave documentation can be generated with ease.*

### Upgraded
- StyLua: [0.11.2] -> [0.11.3]

### Added
- `CustomProperties: table` can now be passed as an argument when constructing proxies. It is the equivalent of manually adding custom properties to
the proxy by using `rawset`, but passing the argument will ensure those properties are replicated to inherited proxies that are directly found in the
proxy origin
- Missing type annotations

### Improvements
- Completed moonwave documentation
- Fixed some variables not using the new [if-then-else expression](https://devforum.roblox.com/t/luau-recap-october-2021/1531825)

### Fixed
- Fixed optional types being required types when constructing a proxy
- Proxies only inherited properties when being newly added, but tables found inside the proxy origin were not converted to proxies, fixed that

---

## v2.0.2 - 2022-01-01

*Happy new year!*
### Upgraded
- Selene: [0.14.0] -> [0.15.0]

### Changed
- `Proxy:Destroy()` will now specifically return nil to comply with the type annotations
- `Proxy:Destroy()` will now set to nil the proxy's metatable
- Variable naming was updated to be all in PascalCase and stay accordingly with my personal style guide

### Added
- When creating a new proxy, you can optionally specify if child tables should automatically be converted to proxies (Inheritance). Additionally,
if a proxy's key is set to nil and its value is a proxy table, it will automatically be destroyed with `Proxy:Destroy()`
- New type added to represent itself the Proxy class

### Fixed
- Changed signal could fire even if the value was not actually changed to a new or different value

---

## v2.0.1 - 2021-11-25

### Changed
- Renamed `:Kill()` to `:Destroy()` for better consistency

---

*Late versions were never documented nor uploaded to github because they were developed without rojo. Since v2.0.0, proxy's development moved to rojo and the documentation process started*