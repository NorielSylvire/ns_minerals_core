--[[
Minerals Core Mod by Noriel_Sylvire.
This mod implements an API for registering minerals in minetest.
Node, oregen, craftitems, crafting (recipes), tools, and all other
definitions typically associated with a mineral in minetest are
registered automatically by this API.

Copyright (c) 2020 Noriel_Sylvire.

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

Contact Noriel_Sylvire via private message on the Minetest Forum:
https://forum.minetest.net/memberlist.php?mode=viewprofile&u=24116
or any of my social media attached to my Minetest Forum profile,
such as GitHub: https://github.com/NorielSylvire
--]]

local default_path = minetest.get_modpath("ns_minerals_core")

nsmc = {}

nsmc.odeps = {
	sobelow = minetest.get_modpath("ns_sobelow") ~= nil,
	farming = minetest.get_modpath("farming") ~= nil
}

dofile(default_path.."/crafting.lua")
dofile(default_path.."/craftitems.lua")
dofile(default_path.."/tools.lua")
dofile(default_path.."/hoes.lua")
dofile(default_path.."/nodes.lua")
dofile(default_path.."/oregen.lua")

function nsmc.register_minerals(modname, minerals)

	local default_ctime = 6 --default time it takes for furnace recipes to cook, in seconds
	
	for i, mineral in ipairs(minerals) do
	
		mineral = mineral or {}
	
		if not mineral.name then
			minetest.log("warning", "Mineral number "..(i+1).." in mod "..modname.." has no name. Registering as '"..modname..i.."mineral'.")
			mineral.name = modname..i.."mineral"
		end
		mineral.mineral_type = mineral.mineral_type or "metal"
		
		mineral.use_custom_textures = mineral.use_custom_textures or false
		mineral.color = mineral.color or "no_color"	-- leave this blank if you do not want to colorize the texture
		mineral.texture_brightness = mineral.texture_brightness or "bright"
		mineral.ore_texture = mineral.ore_texture or mineral.texture_brightness.."_ore_overlay"	-- leave this blank to use the default ore texture
		mineral.wherein_texture = mineral.wherein_texture or "default_stone.png"	-- only modify this if you do not want the ore to generate in stone
		mineral.block_texture = mineral.block_texture or mineral.texture_brightness.."_"..nslib.tern(mineral.mineral_type == "metal", "metal", "gem").."_block"
		mineral.material_texture_index = nslib.clamp(mineral.material_texture_index, 1, nslib.tern(mineral.mineral_type == "metal", 2, 3)) or 2
		mineral.lump_texture_index = nslib.clamp(mineral.lump_texture_index, 1, 3) or 1
		mineral.material_texture = mineral.material_texture or mineral.texture_brightness.."_ingot_1"
		mineral.lump_texture = mineral.lump_texture or mineral.texture_brightness.."_lump_1"
		
		
		mineral.ore_colorize = mineral.ore_colorize or true
		mineral.block_colorize = mineral.block_colorize or true
		mineral.axe_colorize = mineral.axe_colorize or true
		mineral.sword_colorize = mineral.sword_colorize or true
		mineral.pick_colorize = mineral.pick_colorize or true
		mineral.shovel_colorize = mineral.shovel_colorize or true
		mineral.hoe_colorize = mineral.hoe_colorize or true
		mineral.scythe_colorize = mineral.scythe_colorize or true
		mineral.lump_colorize = mineral.lump_colorize or true
		mineral.material_colorize = mineral.material_colorize or true
		
		if not use_custom_textures then
			mineral.axe_texture_handle = "axe_handle"
			mineral.axe_texture_head = mineral.texture_brightness.."_axe_head"
			
			mineral.sword_texture_handle = "sword_handle"
			mineral.sword_texture_blade = mineral.texture_brightness.."_sword_blade"
			
			mineral.pick_texture_handle = "pick_handle"
			mineral.pick_texture_head = mineral.texture_brightness.."_pick_head"
			
			mineral.shovel_texture_handle = "shovel_handle"
			mineral.shovel_texture_head = mineral.texture_brightness.."_shovel_head"
			
			mineral.hoe_texture_handle = "hoe_handle"
			mineral.hoe_texture_head = mineral.texture_brightness.."_hoe_head"
			
			mineral.scythe_texture_handle = "scythe_handle"
			mineral.scythe_texture_head = mineral.texture_brightness.."_scythe_head"
			
			if mineral.mineral_type == "metal" then
				mineral.lump_texture = mineral.texture_brightness.."_lump_"..mineral.lump_texture_index
				mineral.material_texture = mineral.texture_brightness.."_ingot_"..mineral.material_texture_index
			else
				mineral.material_texture = mineral.texture_brightness.."_crystal_"..mineral.material_texture_index
			end
		else	-- any textures you don't provide will use the default texture
			mineral.axe_texture_handle = mineral.axe_texture_handle or "axe_handle"
			mineral.axe_texture_head = mineral.axe_texture_head or mineral.texture_brightness.."_axe_head"
			
			mineral.sword_texture_handle = mineral.sword_texture_handle or "sword_handle"
			mineral.sword_texture_blade = mineral.sword_texture_blade or mineral.texture_brightness.."_sword_blade"
			
			mineral.pick_texture_handle = mineral.pick_texture_handle or "pick_handle"
			mineral.pick_texture_head = mineral.pick_texture_head or mineral.texture_brightness.."_pick_head"
			
			mineral.shovel_texture_handle = mineral.shovel_texture_handle or "shovel_handle"
			mineral.shovel_texture_head = mineral.shovel_texture_head or mineral.texture_brightness.."_shovel_head"
			
			mineral.hoe_texture_handle = mineral.hoe_texture_handle or "hoe_handle"
			mineral.hoe_texture_head = mineral.hoe_texture_head or mineral.texture_brightness.."_hoe_head"
			
			mineral.scythe_texture_handle = mineral.scythe_texture_handle or "scythe_handle"
			mineral.scythe_texture_head = mineral.scythe_texture_head or mineral.texture_brightness.."_scythe_head"
			
			if mineral.mineral_type == "metal" then
				mineral.lump_texture = mineral.lump_texture or mineral.texture_brightness.."_lump_"..mineral.lump_texture_index
				mineral.material_texture = mineral.material_texture or mineral.texture_brightness.."_ingot_"..mineral.material_texture_index
			else
				mineral.material_texture = mineral.material_texture or mineral.texture_brightness.."_crystal_"..mineral.material_texture_index
			end
		end
		
		mineral.flammable = mineral.flammable or false
		mineral.skymineral = mineral.skymineral or false
		mineral.burntime = mineral.burntime or nslib.tern(mineral.flammable, 1, 0)
		mineral.block_burntime = mineral.block_burntime or (mineral.burntime * 9 + 5)
		mineral.ctime = mineral.ctime or 6
		
		mineral.node = mineral.node or {}
		mineral.node.groups = mineral.node.groups or { cracky = 2 }
		
		mineral.axe = mineral.axe or {}
		mineral.axe.full_punch_interval = mineral.axe.full_punch_interval or 1.0
		mineral.axe.times = mineral.axe.times or { [1] = 2.50, [2] = 1.40, [3] = 1.00 }
		mineral.axe.uses = mineral.axe.uses or 20
		mineral.axe.maxlevel = mineral.axe.maxlevel or 2
		mineral.axe.damage = mineral.axe.damage or 4
		
		mineral.sword = mineral.sword or {}
		mineral.sword.full_punch_interval = mineral.sword.full_punch_interval or 0.8
		mineral.sword.times = mineral.sword.times or { [1] = 2.5, [2] = 1.20, [3] = 0.35 }
		mineral.sword.uses = mineral.sword.uses or 30
		mineral.sword.maxlevel = mineral.sword.maxlevel or 2
		mineral.sword.damage = mineral.sword.damage or 6
		
		mineral.pick = mineral.pick or {}
		mineral.pick.full_punch_interval = mineral.pick.full_punch_interval or 1.0
		mineral.pick.times = mineral.pick.times or { [1] = 4.00, [2] = 1.60, [3] = 0.80 }
		mineral.pick.uses = mineral.pick.uses or 20
		mineral.pick.maxlevel = mineral.pick.maxlevel or 2
		mineral.pick.damage = mineral.pick.damage or 4
		
		mineral.shovel = mineral.shovel or {}
		mineral.shovel.full_punch_interval = mineral.shovel.full_punch_interval or 1.1
		mineral.shovel.times = mineral.shovel.times or { [1] = 1.50, [2] = 0.90, [3] = 0.40 }
		mineral.shovel.uses = mineral.shovel.uses or 30
		mineral.shovel.maxlevel = mineral.shovel.maxlevel or 2
		mineral.shovel.damage = mineral.shovel.damage or 3
		
		mineral.hoe = mineral.hoe or {}
		mineral.hoe.uses = mineral.hoe.uses or 200
		
		mineral.scythe = mineral.scythe or {}
		mineral.scythe.uses = mineral.scythe.uses or 250
		
		mineral.vanilla_oregen = mineral.vanilla_oregen or {}	-- this bit here is used by normal ore generation, regardless of installed mods and settings
		mineral.vanilla_oregen.wherein_node = mineral.vanilla_oregen.wherein_node or "default:stone"
		mineral.vanilla_oregen.scarcity = mineral.vanilla_oregen.scarcity or { 7, 24 }
		mineral.vanilla_oregen.num_ores = mineral.vanilla_oregen.num_ores or { 5, 27 }
		mineral.vanilla_oregen.size = mineral.vanilla_oregen.size or { 3, 6 }
		mineral.vanilla_oregen.max = mineral.vanilla_oregen.max or { 0, -64 }
		mineral.vanilla_oregen.min = mineral.vanilla_oregen.min or { -31000, -31000 }
		
		mineral.floatlands_oregen = mineral.floatlands_oregen or {}	-- this bit is only used by skyminerals and only if floatlands are enabled
			-- to be implemented, ignore
		mineral.sobelow_oregen = mineral.sobelow_oregen or {}	-- this bit is only used when the NS So Below Mod is installed
			-- to be implemented, ignore
		
		nsmc.register_crafts(modname, mineral)
		nsmc.register_mineral_craftitems(modname, mineral)
		nsmc.register_tools(modname, mineral)
		nsmc.register_oregen(modname, mineral, nsmc.odeps.sobelow)
		nsmc.register_nodes(modname, mineral)
		
		if nsmc.odeps.farming then
			nsmc.register_hoe(modname, mineral)
		end
		if farming.scythe_not_drops then	-- if farming.scythe_not_drops table exists it means the version of farming mod installed contains scythes
			nsmc.register_scythe(modname, mineral)
		end
	end
end