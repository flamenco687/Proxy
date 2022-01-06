## [3.1.0] - 2022-06-01

### Added
- `IsProxy()` can now be called to check if given table is a proxy or not (function must be called by indexing it from the Proxy
module instead of the proxy object)
```lua
local Proxy = require(Source.Proxy)

local NewProxy = Proxy.new()

print(Proxy.IsProxy(NewProxy))    -- Output: true
print(NewProxy.IsProxy(NewProxy)) -- Errors: attempt to call a nil value

print(Proxy.IsProxy({})) -- Output: false
```
- Missing moonwave documentation for `ListenToDisconnection()`
- Missing type annotation

## [3.0.0] - 2022-05-01

### Added
- `:OnChange()` in replacement of `.Changed`, directly connects the passed functions and can be disconnected by calling the returned function
- `:OnIndex()` in replacement of `.Indexed`, directly connects the passed functions and can be disconnected by calling the returned function
- `:Set()` and `:Get()` to interact with values inside the proxy table that are proxy properties or methods
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

## [2.1.4] - 2022-04-01

### Added
- `Indexed` & `Changed` now pass the proxy as a third argument

## [2.1.3] - 2022-03-01

### Fixed
- Proxies didn't inherit parent's custom properties
- `build` folder ([Moonwave](https://upliftgames.github.io/moonwave/) page) was being included inside the package installation, updated wally.toml exclude

## [2.1.2] - 2022-03-01

### Fixed
- Constructor attempted to check the lenght of a nil value when checking if children proxies should inherit properties

## [2.1.1] - 2022-03-01

### Fixed
- Fixed `.new` trying to iterate through CustomProperties even if it is nil
- Fixed passing default proxy properties as custom properties when constructing a new proxy from `__newindex` 

## [2.1.0] - 2022-03-01

*Since this version, the Proxy project uses the default tree structure of `src/init.lua` so moonwave documentation can be generated with ease.*

### Updated
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

## [2.0.2] - 2022-01-01

*Happy new year!*
### Updated
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

## [2.0.1] - 2021-11-25

### Changed
- Renamed `:Kill()` to `:Destroy()` for better consistency