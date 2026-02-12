# Changelog

## 1.2.1 - Jun 10, 2023 - Bugfixes
- Fixed a bug causing mods to load in an incorrect order.
- Fixed a bug causing callbacks not to be registered correctly.
- Implemented the abilitiy to add metadata to callback registration.

## 1.2 - Feb 25, 2023 - Switch to modpack
- Made the mod into a modpack. Added `nslib` to the modpack.

## 1.1 - Oct 25, 2022 - Farming mod compatibility
- Improved API documentation and corrected spelling mistakes.
- Added compatibility with farming mod.
- Added working hoes and scythes.
- Added the ability to choose the `texture_brightness` while using custom textures for the tools that do not have custom textures.
- Changed `is_metal` from `crafting.lua` to `mineral.mineral_type == "metal"`. It was a legacy variable name from back in 2020, when this API was part of nsam mod. The incorrect name caused metal type minerals to not register recipes.

## 1.0 - 2020 - Separation from nsam mod
- Initial release: Automatic registration of tools, nodes, ores, craftitems and crafting recipes.
- Automatic generation of colorized textures for ALL the items from premade grayscale textures shipped with the API.
