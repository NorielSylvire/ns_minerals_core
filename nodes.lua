--[[
Minerals Core Mod by Noriel_Sylvire.
This source file automates node registration.

Copyright (c) 2020 Noriel_Sylvire.

This library is licensed under the terms of the GNU LGPL, version 2.1.
--]]

function nsmc.register_nodes(modname, mineral)
	minetest.register_node(modname..":stone_with_"..mineral.name, {
		description = nslib.first_to_upper(mineral.name).." Ore",
		tiles = {
			nslib.tern(mineral.wherein_texture ~= "no_base_texture", mineral.wherein_texture.."^(", "")
			..mineral.ore_texture
			..".png"
			..nslib.tern(mineral.color ~= "no_color" and mineral.ore_colorize, "^[multiply:"..mineral.color, "")
			..nslib.tern(mineral.wherein_texture ~= "no_base_texture",")", "")
		},
		groups = mineral.node.groups,
		drop = modname..":"..mineral.name..nslib.tern(mineral.mineral_type == "metal", "_lump", ""),
		sounds = default.node_sound_stone_defaults()
	})
		minetest.register_node(modname..":"..mineral.name.."_block", {
		description = nslib.first_to_upper(mineral.name).." Block",
		tiles = {
			mineral.block_texture
			..".png"
			..nslib.tern(mineral.color ~= "no_color" and mineral.block_colorize, "^[multiply:"..mineral.color, "")
		},
		groups = mineral.node.groups,
		drop = modname..":"..mineral.name.."_block",
		sounds = nslib.tern(mineral.mineral_type == "gem", default.node_sound_stone_defaults(), default.node_sound_metal_defaults())
	})
end