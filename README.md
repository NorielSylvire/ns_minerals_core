# Noriel_Sylvire's Minerals Core Modpack
Version: 1.2

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

`nsmc`: these are the initials of the modpack, and of this mod. The modpack and the mod itself share the names, first in order not to force anyone to change their code. This new version of the modpack should be compatible with all the previous versions. The only names that changed are the ones thet were wrong, or confusing. Also, the modpack is called minerals core because the modpack itself is the core of the mods that use them, and the minerals core mod is the core of the modpack itself. From this point in the manual, I will use nsmc mod to refer to this mod specifically, and nsmc modpack to refer to the entire modpack.

IMPORTANT NOTE: when you want your mod to depend on the nsmc modpack/mod, you must add the complete name of the mod/modpack, which is `ns_minerals_core`, not just nsmc. Nsmc is simply an acronym.
This acronym is used in the code; the callback list is part of a table called nsmc. You access it by typing `nsmc.registered_callbacks`. All functions added to the modpack are added to the `nsmc` table. Example: `nsmc.register_minerals()`, `nsmc.register_callback()`, `nsmc.register_farming()`, etcetera.
This table is used so that there are no conflicts with other mods that might also add a `register_callback()` or `register_minerals()` function.
This table is called `nsmc` for convenience, but please, do not confuse this table with the mod's name. The mod's name is `ns_minerals_core`, and that is the name you must use when adding this mod as a dependency. I just want to make it absolutely clear. Sorry for being so pedantic.


---
## Changelog

* 1.2 - Made the mod into a modpack. Since the code in this mod existed when the modpack was a mod, this mod carries the changelog of when it was a mod and not a modpack. Similarly, despite this version being the first where this is a mod inside a modpack, the version number is 1.2 so that it's clear this is more recent than 1.1.
* 1.1 - Improved API documentation and corrected spelling mistakes. Added compatibility with farming mod. Added working hoes and scythes. Added the ability to choose the `texture_brightness` while using custom textures for the tools that do not have custom textures. Changed `is_metal` from `crafting.lua` to `mineral.mineral_type == "metal"`. It was a legacy variable name from back in 2020, when this API was part of nsam mod. The incorrect name caused metal type minerals to not register recipes.
* 1.0 - Initial release: Automatic registration of tools, nodes, ores, craftitems and crafting recipes. Automatic generation of colorized textures for ALL the items from premade grayscale textures shipped with the API.

---
## API Documentation

In order to use the API, you must create a mod that depends on `ns_minerals_core`. Then you must write the an array of `mineral` definitions, and call the `nsmc.register_minerals()` method.

---
### Methods

All of the methods implemented by this API are contained within a table named `nsmc` so that you don't have to type in the full name of the mod, which is `ns_minerals_core` every time you want to call a method.

Example:
```lua
nsmc.register_minerals("mymod", {{}})
```
The above code is sufficient and works. It will result in one mineral added as part of the `mymod` mod, with everything the modpack adds, like recipes, nodes, oregen, etc.

---
### nsmc.register_minerals(modname, minerals)
Parameters:
* modname: a `string` value. This must be the name of your mod.
For example, if your mod is named `mymod`, then modname should be equal to "mymod".
* minerals: an array of `mineral`. This must be an array `mineral` definitions containing all the minerals of your mod. See ARRAY OF MINERALS for more information.

This method makes sure the `minerals` table is formatted correctly, defaults `nil` values and calls all the functions contained in `nsmc.registered_callbacks` once per mineral defined in the `minerals` table that you passed.
This is really the only method you would normally be calling when using this API as intended.

---
### nsmc.register_callback(func)
Parameters:
* func: a lua function. This function will typically register different types of content for a mineral, automatically.

This method adds your function to the `nsmc.registered_callbacks` list. All functions stored this way will be executed once per `mineral` in the `minerals` array.

---
### Tables and Data Structures

This API currently supports two data structures;

---
### minerals Array

This is just an array of `mineral` tables. Must be passed as a parameter to `nsmc.register_minerals()`.

---
### mineral Table

This table can contain all of the data needed to register everything pertaining to a mineral, such as tools, nodes, ores, crafting recipes, etcetera.

Each mod you install in the nsmc modpack will add diferent members to the table.

All the members can be given a value or left out of the definition. If left out, the default value will be assigned.
Note: leaving a member out of the definition and giving it an empty value are not the same thing.
Example: `name = ""` is not leaving the `name` member out of the definition but giving it the `""` value. Leaving it out means not writing it at all.

The table can be left empty (as in `{}`), in which case it will be filled with the default values of all members.
If this is done, the game will notify you that no name was given, and give it a very ugly name instead, so, please, at least give the minerals a name!

When a member is left out, the API will default that member's value to the value iron takes. For instance, if nsmd (`ns_minerals_default` mod, the one that adds all the content for the `default` mod), the tool uses, strength, level, node levels, dig times, etc will all have the same values as iron. Even the oregen values will be the same as the default iron values. The only members that don't do this are the name and the color. The color will default to white, and the name, as mentioned above, will default to an ugly name.

There are a few members that must always exist, even if no other mod is installed in this modpack. These are values that are likely going to be used by many, possibly all mods in this modpack.
Said members are the `name`, `color`, and `texture_brightness`. This is because, in order to generate content, all mods in this modpack need a mineral name to register the content as. They often also need a texture color and, if the mod supports it, a brightness, to generate the textures with. At the time of writing this, two mods in this modpack, `ns_minerals_default` and `ns_minerals_farming` all use `name`, `color` and `texture_brightness`. Thus these members are given a default value (if the user hasn't given them a value) in the nsmc mod.

---
### mineral Table Members

All the different pairs of keys and values in this table are called "members" in this documentation.

* How do I interpret the documentation?
Each member's section title contains the name of the member and the value type separated by a coma.
Example: `name`, `string`
The above example means the member is called `name`, and it takes on `string` type values.
Then, below the title, you can see the default value of the member.
After that, there is always a detailed explanation of the member.
Often times, there are examples for each member.
If the member has only a small number of possible values, they will be listed and explained.

---
### name, string
Default: `modname` + `i` + `"mineral"` where `i` is the index of the mineral in the array of minerals.

This is just the name of the mineral. It must be given a valid `string` value.

Examples: `"mymod1mineral"`, `"superdupercoolnewores13mineral"`.
As a result of this, if the default value gets used, your items will have amazing names such as `"Superdupercoolnewores13mineral Sword"`, or `"Lump of Mymod1mineral"`.

---
### color, ColorString
Default: `"no_color"`

The color of your mineral. It must be a hexadecimal color string. You can search for "hex color picker" and use an online tool for this.
Correct `ColorString`s look like `#ffffff` or `#` + six numbers or letters. The letters must be between `a` and `f`, both included.
This value will be overlayed on top of your mineral's textures.
This is useful when your textures are grayscale. But even more useful is the fact that `ns_minerals_core` supplies you with premade grayscale textures.
You do not even need to make and use your own textures for your minerals, just specify any `ColorString` and the mod will colorize the grayscale textures that come with it for you.

***Special values***
* `"no_color"`: if you set color as this value, grayscale textures will not be colorized. This is the default value.

---
### texture_brightness, string
Default: `"bright"`

Can be `"bright"`, `"medium"` or `"dark"`.
Changes what set of premade grayscale textures the mineral will use. Just changing the `color` doesn't give you complete control over what the texture looks like, so three sets of premade grayscale were created, each with a different brightness.
