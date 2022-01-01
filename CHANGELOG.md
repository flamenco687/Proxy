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