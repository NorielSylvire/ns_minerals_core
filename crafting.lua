--[[
Minerals Core Mod by Noriel_Sylvire.
This source file automates crafting recipe registration.

Copyright (c) 2020 Noriel_Sylvire.

This library is licensed under the terms of the GNU LGPL, version 2.1.
--]]

function nsmc.generate_recipe(mat, recipe)
	if recipe == "sword" then
		return {{mat}, {mat}, {"group:stick"}}
	end
	if recipe == "shovel" then
		return {{mat}, {"group:stick"}, {"group:stick"}}
	end
	if recipe == "axe" then
		return {{mat, mat}, {mat, "group:stick"}, {"", "group:stick"}}
	end
	if recipe == "pick" then
		return {{mat, mat, mat}, {"", "group:stick", ""}, {"", "group:stick", ""}}
	end
	if recipe == "hoe" then
		return {{mat, mat}, {"", "group:stick"}, {"", "group:stick"}}
	end
	if recipe == "block" then
		return {{mat, mat, mat}, {mat, mat, mat}, {mat, mat, mat}}
	end
end

function nsmc.register_crafts(modname, mat)
	modname = modname..":" --Used when you only want the mod's name, then tool type, then material's name. For example: ns_arkane_minerals:sword_mithril
	local modmat = modname..mat.name --Used when you want the mod's name right next to the material's name. For example: ns_arkane_minerals:mithril_block
	local matingot = modmat --The formatted name of the material used for crafting. If it's a metal, it gets "_ingot" added to the end, otherwise it stays the same.
	if is_metal then 
		matingot = modmat.."_ingot"
		minetest.register_craft({
			type = "shaped",
			output = modmat.."_block",
			recipe = nsmc.generate_recipe(matingot, "block")
		})
		minetest.register_craft({
			type = "cooking",
			output = matingot,
			recipe = modmat.."_lump",
			cooktime = mat.ctime
		})
	else 
		minetest.register_craft({
			type = "shaped",
			output = modmat.."_block",
			recipe = nsmc.generate_recipe(modmat, "block")
		})
	end
	if is_fuel then
		minetest.register_craft({
			type = "fuel",
			recipe = modmat,
			burntime = mat.burntime
		})
		minetest.register_craft({
			type = "fuel",
			recipe = modmat.."_block",
			burntime = mat.block_burntime
		})
	end
	minetest.register_craft({
		type = "shaped",
		output = modname.."sword_"..mat.name,
		recipe = nsmc.generate_recipe(matingot, "sword")
	})
	minetest.register_craft({
		type = "shaped",
		output = modname.."pick_"..mat.name,
		recipe = nsmc.generate_recipe(matingot, "pick")
	})
	minetest.register_craft({
		type = "shaped",
		output = modname.."axe_"..mat.name,
		recipe = nsmc.generate_recipe(matingot, "axe")
	})
	minetest.register_craft({
		type = "shaped",
		output = modname.."shovel_"..mat.name,
		recipe = nsmc.generate_recipe(matingot, "shovel")
	})
	minetest.register_craft({
		type = "shaped",
		output = modname.."hoe_"..mat.name,
		recipe = nsmc.generate_recipe(matingot, "hoe")
	})
end