# Noriel_Sylvire's Minerals Core
Version: 1.1

Copyright (c) 2020 Noriel_Sylvire (Flaviu E. Hongu)
Copyright (c) 2016 TenPlus1 (for the scythe registration code)

Licenses:
Code: LGPL 2.1
Textures: CC-BY-SA, CC-BY

Read license.txt for more information.

---

This mod contains an API for automatically registering everything related to an ore, or mineral.
Noriel_Sylvire's Minerals Core depends on the `nslib` mod. Remember to install it if you are planning on using this mod.
Note: All of my mods that aren't forks of other mods, made specifically for a game, or are intended to add content that makes other mods (more) compatible with each other have an `ns` at the beginning of their names to make sure there are no conflicts between mods I made and other mods that may otherwise share the same name.

From here on, this mod will be refered to as nsmc, which stands for Noriel_Sylvire's Minerals Core.
When `ns_minerals_core` is used in this file, it is the technical name of this mod, the one you must type in the `depends` section of your `mod.conf` file, or whenever you are looking for this mod's folder.
Below is the documentation on how to use the API.

---
## Changelog

* 1.1 - Improved API documentation and corrected spelling mistakes. Added compatibility with farming mod. Added working hoes and scythes. Added the ability to choose the `texture_brightness` while using custom textures for the tools that do not have custom textures. Changed `is_metal` from `crafting.lua` to `mineral.mineral_type == "metal"`. It was a legacy variable name from back in 2020, when this API was part of nsam mod. The incorrect name caused metal type minerals to not register recipes.
* 1.0 - Initial release: Automatic registration of tools, nodes, ores, craftitems and crafting recipes. Automatic generation of colorized textures for ALL the items from premade grayscale textures shipped with the API.

---
## API Documentation

In order to use the API, you must create a mod that depends on `ns_minerals_core`. Then you must write the definition of an array of `mineral`, and call the `nsmc.register_minerals()` method.

---
### Methods

All of the methods implemented by this API are contained within a table named `nsmc` so that you don't have to type in the full name of the mod, which is `ns_minerals_core` every time you want to call a method.

Example of how to call a method:
```lua
nsmc.register_nodes("mymod", mineral3)
```

---
### nsmc.register_minerals(modname, minerals)
Parameters:
* modname: a `string` value. This must be the name of your mod.
For example, if your mod is named `mymod`, then modname should be equal to "mymod".
* minerals: an array of `mineral`. This must be an array `mineral` containing all the minerals of your mod. See ARRAY OF MINERALS for more information.

This method makes sure the `minerals` table is formatted correctly, defaults `nil` values and calls `nsmc.register_crafts()`, `nsmc.register_mineral_craftitems()`, `nsmc.register_tools()`, `nsmc.register_oregen()`, and `nsmc.register_nodes()` once per `mineral` defined in the `minerals` table passed.
This is really the only method you would normally be calling when using this API as intended.

---
### nsmc.register_crafts(modname, mineral)
Parameters:
* modname: a `string` value. This must be the name of your mod.
* mineral: a `mineral` table. This must be a `mineral` table containing everything needed to register your mineral. See MINERAL TABLE for more information.

This method registers all the crafting recipes of a mineral.
Examples: the recipes for the axe, sword, pickaxe, block...

---
### nsmc.register_craftitems(modname, mineral)
Parameters:
* modname: a `string` value. This must be the name of your mod.
* mineral: a `mineral` table. This must be a `mineral` table containing everything needed to register your mineral. See MINERAL TABLE for more information.

This method registers all the items of a mineral.
Examples: lump, ingot...

---
### nsmc.register_tools(modname, mineral)
Parameters:
* modname: a `string` value. This must be the name of your mod.
* mineral: a `mineral` table. This must be a `mineral` table containing everything needed to register your mineral. See MINERAL TABLE for more information.

This method registers all the tools of a mineral.
Examples: the actual axe, pickaxe, sword, shovel...

---
### nsmc.register_oregen(modname, mineral, sobelow_present)
Parameters:
* modname: a `string` value. This must be the name of your mod.
* mineral: a `mineral` table. This must be a `mineral` table containing everything needed to register your mineral. See MINERAL TABLE for more information.
* sobelow_present: a `bool` value. This should be true when the `ns_sobelow` mod is installed, and false otherwise. Currently doesn't affect functionality.

This method registers all the ores of a mineral, with their depths, scarcities, etc.

---
### nsmc.register_nodes(modname, mineral)
Parameters:
* modname: a `string` value. This must be the name of your mod.
* mineral: a `mineral` table. This must be a `mineral` table containing everything needed to register your mineral. See MINERAL TABLE for more information.

This method registers all the nodes of a mineral.
Examples: the actual ore node, the block resulting from combining 9 of the item in a crafting grid...


---
### Tables and Data Structures

This API currently supports two data structures;

---
### minerals Array

This is just an array of `mineral` tables. Must be passed as a parameter to `nsmc.register_minerals()`.

---
### mineral Table

This table can contain all of the data needed to register everything pertaining to a mineral, such as tools, nodes, ores, crafting recipes, etcetera.

All the members can be given a value or left out of the definition. If left out, the default value will be assigned.
Note: leaving a member out of the definition and giving it an empty value are not the same thing.
Example: `name = ""` is not leaving the `name` member out of the definition but giving it the `""` value. Leaving it out means not writing it at all.

The table can be left empty (as in `{}`), in which case it will be filled with the default values of all members.
If this is done, the game will notify you that no name was given, and give it a very ugly name instead, so, please, at least give the minerals a name!

---
### mineral Table Members

All the different pairs of keys and values in this table are called "members" in this documentation.
Each member's section title contains the name of the member and the value type separated by a coma.
Example: `name`, `string`
The above example means the member is called `name`, and it takes on `string` type values.

---
### name, string
Default: `modname` + `i` + `"mineral"` where `i` is the index of the mineral in the array of minerals.

This is just the name of the mineral. It must be given a valid `string` value.

Default value: A string consisting of the name of your mod + the index of this `mineral` table in the `minerals` array + "mineral".
Examples: `"mymod1mineral"`, `"superdupercoolnewores13mineral"`.
As a result of this, if the default value gets used, your items will have amazing names such as `"Superdupercoolnewores13mineral Sword"`, or `"Lump of Mymod1mineral"`.

---
### mineral_type, string
Default: `"metal"`

This can be either `"metal"` or `"gem"`.
If it is a metal, the mineral will be registered with a lump and an ingot. If it is a gem, it won't have an ingot or a lump, instead it will have a gem type `craftitem`.

---
### use_custom_textures, bool
Default: `false`

If this is enabled, you will be able to use your own textures inside your mod's `\textures` folder.
Any custom textures you don't set will default to a colorized premade grayscale texture from nsmc's `\textures` folder.
If this is disabled, all generated textures will be colorized premade grayscale textures.

---
### color, ColorString
Default: `"no_color"`

The color of your mineral. It must be a hexadecimal color string. You can search for "hex color picker" and use an online tool for this.
Correct `ColorString`s look like `#ffffff` or `#` + six numbers or letters.
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

---
### ore_texture, string
Default: `texture_brightness` + `"_ore_overlay"

This is the name of the texture overlayed on top of the node where the ore gets generated, minus the `".png"`.

---
### wherein_texture, string
Default: `"default_stone.png"`

The texture over which the `ore_texture` will be overlayed, WITH the `".png"`. Typically, this should be the same node the ore has generated in.
At the moment, you can only set one of these per mineral.

***Special values***
* `"no_base_texture"`: it makes the final ore texture be only the `ore_texture`, without being overlayed on top of another texture.

---
### block_texture, string
Default: `texture_brightness` + `"_metal_block"`

The texture used for the block you can craft by combining nine of this mineral's item in a crafting grid, WITHOUT the `".png"`.

---
### material_texture, string
Default: `texture_brightness` + `" _ingot_1"`

The texture used for the ingot `craftitem` of metal type minerals, and the gem for gem 
This is called `material_texture` because it cannot be named `ingot_texture` or `gem_texture` as some minerals are metals while other are gems, so it has a name that is correct for both types of minerals.
If `material_texture_index` has no value, `material_texture` will have a `"_1"` at the end.
This is because there are three brightness variants of two different ingot textures, and the default one is the first one.

---
### lump_texture, string
Default: `texture_brightness` + `" _lump_1"`

Same as `material_texture` only this one is for lumps instead of ingots or gems, and is only used by metal type minerals.
Also comes in three brightness variants, and two different styles; `1` and `2`.

---
### material_texture_index, int
Default: `2`

This is the number at the end of `material_texture` when not using custom textures.
In the current version can be either `1` or `2` for metals and `1`, `2`, or `3` for gems.
Each number corresponds to the three brightness variations of the `"...ingot_1"`, `"...ingot_2"`, `"...gem_1"`, `"...gem_2"`, and `"...gem_3"` textures found in the `\textures` folder.

---
### lump_texture_index, int
Default: `1`

Same as the previous, only this one is the number at the end of `lump_texture`, it only gets used by metal type minerals, and can range from `1` to `2`, both included.

---
### tool + _texture_ + head or handle or blade, string
Default: `texture_brightness` + `"_"` + `"head"` or `"handle"` or `"blade"`

`tool` can be one of:
* `axe`
* `pick`
* `sword`
* `shovel`
* `hoe`

Use `blade` instead of `head` for swords, use `head` for everything else.
This is the texture for each tool type. It must be a `string`, and it must not contain the `".png"` at the end.
Each tool type has one handle texture and one head or blade texture. By default, if you do not proide a handle texture, a normal wooden handle provided by the API will be used.
Then the head texture is overlayed on top of the handle texture. If you enabled it or left it out of the definition, the head or blade will be colorized.
If you don't provide a texture for the head, the API will use a default one based on the `texture_brightness` you set (`bright` by default).

Examples:
`"bright_sword_blade"`, `"dark_pick_head"`, `"axe_handle"`

***Special values***
* `"no_texture"`: if any handle is set to this value, the handle will not be rendered.

---
### word + _colorize, bool
Default: `true`

`word` can be one of:
* `ore`
* `block`
* `axe`
* `sword`
* `pick`
* `shovel`
* `hoe`
* `lump`
* `material`

If enabled that type of item or node will be colorized.
It is enabled by default so leave this out if you want everything to be colorized.
This can be useful if you, for example, have a custom sword texture and thus you need to activate `use_custom_textures`, but you want every other item texture to be generated automatically.
In this example you should set `sword_colorize` to false, and leave all other colorizes out of the mineral definition so that they default to true. You should also set `use_custom_textures` to `true`, and change `sword_texture_blade` to your texture's name without the `".png"`. You should probably also set `sword_texture_handle` to `"nothing"` too, or set it to the same value as `sword_texture_blade`.

---
### flammable, bool
Default: `false`

Enable this if you want your mineral to be useable as a fuel in furnaces.

---
### skymineral, bool
Default: `false`

If you enable this, the ore will be able to spawn in the floatlands. WIP. Do not use this feature! It does nothing in the current version!

---
### burntime, int
Default: `1` for flammable minerals, `0` otherwise.

The amount of time, in seconds, that the mineral lasts as a fuel source in furnaces.

---
### block_burntime, int
Default: `9` times the `burntime` + `5`

The amount of time, in seconds, that the block made out of nine ingots or gems lasts as a fuel source in furnaces.
Typically nine times more than the item itself, plus a little bonus to make crafting this worthwhile.

---
### ctime, int
Default: `6`

Time, in seconds, it takes for the metal lump to be cooked into the metal ingot.
Only works on metal type minerals.

---
### node, node table
Default: `{ groups = { cracky = 2 } }`

A `node` table that contains the `groups` of the node mineral's nodes.

---
### groups, groups table
Default: `{ cracky = 2 }`

A table containing pairs of node groups and integer values, separated by comas. See [node groups](https://github.com/minetest/minetest/blob/dafdb3edb4b65db144d72cd2274a657af671bdd1/doc/lua_api.txt#L1945) for more information.

Example: `{ cracky = 1, choppy = 2, snappy = 3 }`

---
### toolname, tool table
Default: Same values as all the default iron tools

`toolname` can be one of:
* `axe`
* `sword`
* `pick`
* `shovel`
* `hoe`

This table can contain a `full_punch_interval`, `times`, `uses`, `maxlevel`, and a `damage` member. If one or more of these is left out, they will take the default values (same values as the iron tools).

---
### full_punch_interval, float
Default: Same as the equivalent iron tool

Time, in seconds, the player has to wait between clicks to deal full damage. If, instead, the player spam-clicks the tool faster than the `full_punch_interval`, the damage dealt will be reduced.

---
### times, times dictionary
Default: Same as the equivalent iron tool

Pairs of key-value, where the key must be in the form of `[some_integer]`, where `some_integer` is an `s16` integer, and value is a `float` number that represents the amount of time, in seconds, it takes for the tool to break the `[key]` tier of nodes.
Example: `{ [5] = 3.00, [6] = 4.00 }`
In this example, the tool can only break tier `5` and tier `6` nodes, taking `3` and `4` seconds respectively.

IMPORTANT: Pay attention, this dictionary has confusing ordering due to how Minetest registered their tiers of items.
Diamonds are Tier `1`, that is, TIER ONE.
While wooden tools are tier `3`, that is, TIER THREE.
Indeed, for some reason, tier `3` means weaker than tier `2` in minetest's code, and tier `2` is also weaker than tier `1` in minetest's code.

However if you want to add a new tier of minerals, stronger than diamond, I suggest that instead of following the illogical downward trend you add that stronger-than-diamond ore as a tier `4` ore, and then stronger minerals will be tier `5`, `6` and so on.


---
### uses, int
Default: Same as the equivalent iron tool

Number of uses the tool has.
Remember that a tool loses exponentially less uses the greater the difference between the tool's `maxlevel` and the node's tier is. See [my Guide on how to understand tool and node parameters and how to add new tiers of ore](https://forum.minetest.net/viewtopic.php?t=27811) for a more detailed explanation.


---
### maxlevel, int
Default: Same as the equivalent iron tool

Maximum level of node the tool can break. It is also used to calculate how many uses the tool loses by breaking a node.

---
### damage, int
Default: Same as the equivalent iron tool

Amount of damage the tool deals.

---
### vanilla_oregen, vanilla_oregen table
Default: Same values as the ore generation parameters of iron in the default mod

Can contain a `wherein_node` member and a `scarcity`, `num_ores`, `size`, `max`, and `min` array.
If the arrays contain more than one value each, the API will register as many ores as the number of elements in the arrays.

Example:
If the arrays have two values each, like in the default values they are given, the API will register two ores using the first value in each array first, then the second value in each array.

---
### wherein_node, string
Default: `"defaul:stone"`

The node in which the ore can be generated.

---
### scarcity, array of int
Default: `{ 7, 24 }`

This is an array of integer numbers. The result of raising each number to the third power is equal to `1 / chance` where `chance` is the chance of the node being converted to the ore if it is the same as `wherein_node`.
That is to say, larger numbers means lower chance, smaller numbers means greater chance of the ore spawning.

---
### num_ores, array of int
Default: `{ 5, 27 }`

The number of ores that will spawn in a cluster of ores when it is generated.
Greater number means more ores per cluster. Cannot be larger than `size` raised to the third power.

---
### size, array of int
Default: `{ 3, 6 }`

The length of each edge of the cube that contains each cluster of ores.
A larger number means the ore will be more spread out, but it will also allow for greater values of `num_ores`.

---
### max, array of int
Default: `{ 0, -64 }`

An array with the highest Y-coordinates the ore can be generated in.

---
### min, array of int
Default: `{ -31000, -31000 }`

An array with the lowest Y-coordinates the ore can be generated in.

---
### floatlands_oregen, floatlands_oregen table

WIP. Not implemented yet.

Currently does nothing. Will likely be removed as it can probably be simulated by the `vanilla_oregen` table.

---
### sobelow_oregen, sobelow_oregen table

WIP. Not implemented yet.

Will be very different from the `vanilla_oregen` table, potentially more complex.
It is designed to register the ore generation of minerals while the `ns_sobelow` mod is installed.
Since `ns_sobelow` is still in very early development this feature cannot be completed yet.

---

Lastly, there will be support for a new feature called `super_mining_layer` soon.
The super mining layer is a configurable layer in which all the minerals will be able to spawn with custom parameters for anyone who doesn't like their ores to be generated in exclusive layers.
More on this topic soon.