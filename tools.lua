--[[
Minerals Core Mod by Noriel_Sylvire.
This source file automates tool registration.

Copyright (c) 2020 Noriel_Sylvire.

This library is licensed under the terms of the GNU LGPL, version 2.1.
--]]

function nsmc.register_tools(modname, mineral)
	local name = mineral.name
	
	minetest.register_tool(modname..":axe_"..name, {
		description = nslib.first_to_upper(name).." Axe",
		inventory_image = nslib.tern(mineral.axe_texture_handle ~= "no_texture", mineral.axe_texture_handle..".png", "")
						.."^("
						..mineral.axe_texture_head..".png"
						..nslib.tern(mineral.color ~= "no_color" and mineral.axe_colorize, "^[multiply:"..mineral.color, "")
						..")",
		tool_capabilities = {
			full_punch_interval = mineral.axe.full_punch_interval,
			max_drop_level = mineral.axe.maxlevel,
			groupcaps = {
				choppy = {times = mineral.axe.times, uses = mineral.axe.uses, maxlevel = mineral.axe.maxlevel}
			},
			damage_groups = {fleshy = mineral.axe.damage}
		},
		sound = {breaks = "default_tool_breaks"},
		groups = {axe = 1}
	})

	minetest.register_tool(modname..":sword_"..name, {
		description = nslib.first_to_upper(name).." Sword",
		inventory_image = nslib.tern(mineral.sword_texture_handle ~= "no_texture", mineral.sword_texture_handle..".png", "")
						.."^("
						..mineral.sword_texture_blade..".png"
						..nslib.tern(mineral.color ~= "no_color" and mineral.sword_colorize, "^[multiply:"..mineral.color, "")
						..")",
		tool_capabilities = {
			full_punch_interval = mineral.sword.full_punch_interval,
			max_drop_level = mineral.sword.maxlevel,
			groupcaps = {
				snappy = {times = mineral.sword.times, uses = mineral.sword.uses, maxlevel = mineral.sword.maxlevel}
			},
			damage_groups = {fleshy = mineral.sword.damage}
		},
		sound = {breaks = "default_tool_breaks"},
		groups = {sword = 1}
	})
	
	minetest.register_tool(modname..":pick_"..name, {
		description = nslib.first_to_upper(name).." Pickaxe",
		inventory_image = nslib.tern(mineral.pick_texture_handle ~= "no_texture", mineral.pick_texture_handle..".png", "")
						.."^("
						..mineral.pick_texture_head..".png"
						..nslib.tern(mineral.color ~= "no_color" and mineral.pick_colorize, "^[multiply:"..mineral.color, "")
						..")",
		tool_capabilities = {
			full_punch_interval = mineral.pick.full_punch_interval,
			max_drop_level = mineral.pick.maxlevel,
			groupcaps = {
				cracky = {times = mineral.pick.times, uses = mineral.pick.uses, maxlevel = mineral.pick.maxlevel}
			},
			damage_groups = {fleshy = mineral.pick.damage}
		},
		sound = {breaks = "default_tool_breaks"},
		groups = {pickaxe = 1}
	})

	minetest.register_tool(modname..":shovel_"..name, {
		description = nslib.first_to_upper(name).." Shovel",
		inventory_image = nslib.tern(mineral.shovel_texture_handle ~= "no_texture", mineral.shovel_texture_handle..".png", "")
						.."^("
						..mineral.shovel_texture_head..".png"
						..nslib.tern(mineral.color ~= "no_color" and mineral.shovel_colorize, "^[multiply:"..mineral.color, "")
						..")",
		wield_image = mineral.shovel_texture_handle..".png"
						.."^("
						..mineral.shovel_texture_head..".png"
						..nslib.tern(mineral.color ~= "no_color" and mineral.shovel_colorize, "^[multiply:"..mineral.color, "")
						..")"
						.."^[transformR90",
		tool_capabilities = {
			full_punch_interval = mineral.shovel.full_punch_interval,
			max_drop_level = mineral.shovel.maxlevel,
			groupcaps = {
				crumbly = {times = mineral.shovel.times, uses = mineral.shovel.uses, maxlevel = mineral.shovel.maxlevel}
			},
			damage_groups = {fleshy = mineral.shovel.damage}
		},
		sound = {breaks = "default_tool_breaks"},
		groups = {shovel = 1}
	})

	minetest.register_tool(modname..":hoe_"..name, {
		description = nslib.first_to_upper(name).." Hoe",
		inventory_image = nslib.tern(mineral.hoe_texture_handle ~= "no_texture", mineral.hoe_texture_handle..".png", "")
						.."^("
						..mineral.hoe_texture_head..".png"
						..nslib.tern(mineral.color ~= "no_color" and mineral.hoe_colorize, "^[multiply:"..mineral.color, "")
						..")",
		tool_capabilities = {
			full_punch_interval = mineral.hoe.full_punch_interval,
			max_drop_level = mineral.hoe.maxlevel,
			groupcaps = {
				snappy = {times = mineral.hoe.times, uses = mineral.hoe.uses, maxlevel = mineral.hoe.maxlevel}
			},
			damage_groups = {fleshy = mineral.hoe.damage}
		},
		sound = {breaks = "default_tool_breaks"},
		groups = {axe = 1}
	})
end