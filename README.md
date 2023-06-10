# Noriel_Sylvire's Minerals Core Modpack [![Made With Love](https://img.shields.io/badge/Made%20With-Love-orange.svg)](https://github.com/chetanraj/awesome-github-badges)
Version: 1.2.1

Copyright (c) 2020 Noriel_Sylvire (Flaviu E. Hongu)

License: LGPL 2.1

Read license.txt for more information.

---

This is the NS Minerals Core modpack.
The entire modpack depends on the `nslib` mod. `nslib` mod normally comes bundled with the modpack.

This modpack contains mods to automatically register items, recipes, oregen, and textures for different Minetest mods.
Each mod in this modpack depends on a different Minetest mod. If a mod in this modpack depends on another mod, it means it either registers or generates items for said mod, or it uses functionality from that mod.

Each mod in this modpack has a `README.md` file with documentation on how to use it. I am still debating myself on whether I should make this file contain documentation for all mods in the modpack or not.
On one hand it would make it easier to get all the information at the same time. On the other it would be more confusing since you'd have information on all the mods at the same time, even if the mod isn't present on your current installation.

The entire modpack, as well as each mod (submodule) contained has been initialized for git flow to ensure better quality control for future releases and make it easier for new contributors to work on their own features.
In order to use git flow functionality, new contributors, and current contributors who want to develop a new feature should clone the `develop` branch of whichever module they want to work on, and then create a new branch from their cloned `develop` called `feature/your_feature_name`.
Then you should work and commit on the `feature/your_feature_name` branch until your feature is ready. When the feature is ready, push your changes to `feature/your_feature_name` origin, then pull request that change into the `develop` origin.
The pull request will need to be reviewed by at least one other contributor and then approved. Then it can be successfully merged into the development branch. When enough new features are made, a new complete release of the module can be made into the `master` branch.


I am sure more experienced developers can help me out if I made a mistake describing the git flow mechanic.

---
## Nomenclature and definitions

All of the mods I make from scratch wil have an `ns` at the beginning of their names because my modnames are usually not very original and that could cause comaptibility issues.
When I fork another mod, I will usually add an `-ns` to the end of the version name to make it clear that this is not the main version of the mod. Example: `2.4-ns`, the name the `multidimensions` mod version that I updated had before it was pulled to origin.
These `ns` stand for Noriel_Sylvire, or Noriel_Sylvire's, which is the name I go by on the internet and in many games.

`nsmc`: these are the initials of the modpack. This new version of the modpack should be compatible with all the previous versions. The only names that changed are the ones thet were wrong, or confusing. Also, the modpack is called minerals core because the modpack itself is the core of the mods that use them.

IMPORTANT NOTE: when you want your mod to depend on the nsmc modpack/mod, you must add the complete name of the modpack/mod, which is `ns_minerals_something`, not just nsmc. Nsmc is simply an acronym.
This acronym is used in the code; the callback list is part of a table called nsmc. You access it by typing `nsmc.registered_callbacks`. All functions added to the modpack are added to the `nsmc` table. Example: `nsmc.register_minerals()`, `nsmc.register_callback()`, `nsmc.register_farming()`, etcetera.
This table is used so that there are no conflicts with other mods that might also add a `register_callback()` or `register_minerals()` function.
This table is called `nsmc` for convenience, but please, do not confuse this table with the mod's name. The mod's name is `ns_minerals_whatever`, and that is the name you must use when adding any mod as a dependency. I just want to make it absolutely clear. Sorry for being so pedantic.


---
## Changelog

* 1.2 - Made the mod into a modpack. Added `nslib` to the modpack.
* 1.1 - Improved API documentation and corrected spelling mistakes. Added compatibility with farming mod. Added working hoes and scythes. Added the ability to choose the `texture_brightness` while using custom textures for the tools that do not have custom textures. Changed `is_metal` from `crafting.lua` to `mineral.mineral_type == "metal"`. It was a legacy variable name from back in 2020, when this API was part of nsam mod. The incorrect name caused metal type minerals to not register recipes.
* 1.0 - Initial release: Automatic registration of tools, nodes, ores, craftitems and crafting recipes. Automatic generation of colorized textures for ALL the items from premade grayscale textures shipped with the API.

---
## API Documentation

In order to use the API, you must create a mod that depends on `ns_minerals_core`. Then you must write the an array of `mineral` definitions, and call the `nsmc.register_minerals()` method.
Each mod (submodule) in this modpack has its own documentation, so make sure to read it in order to get a better idea on how to use them!
