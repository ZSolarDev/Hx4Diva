# Changelog

## v1.0.0-alpha.6

The main change was that the real main class is generated at compile time via macro as `DivaMain`, so that there's a custom entrypoint called by the runtime rather than trusting `hxRunLibrary`, as that stops working to call main in some contexts.

### Build system changes

- `BuildMod` now redirects to `DivaMain` and calls `MainMacro` (see below).
- `RunHxp` now uses `commandArgs` instead of `args`, which used to cause some issues when specific flags were added.
- Common warnings are now silenced.

### Macro changes

- Added `diva.macros`.
  - Added `MainMacro`.
    - Generates `DivaMain`.

### Runtime changes

- The runtime now calls the custom `Main` export after `hxRunLibrary`.

### Hx4Diva changes

- Export `Main`, which calls `DivaMain_obj::entrypoint()`.

### `linc_diva` changes

- Expose `kiseki`, `prev`, and `next` in `PVGameTarget`.
- Move `AetResMode` out of `aet` and rename it to `ResolutionMode`.
- Change `res` in `Spr.drawSimpleText` to `ResolutionMode` instead of `Int32`.
- Added `getPvGameData` to `DivaGlobal`.
- Added `diva.types.dsc`.
  - Added `Dsc`.
  - Added `OpcodeInfo`.
  - Moved DSC-relating files under `diva.types.dsc`.
