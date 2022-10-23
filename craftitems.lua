--[[
Minerals Core Mod by Noriel_Sylvire.
This source file automates item registration.

Copyright (c) 2020 Noriel_Sylvire.

This library is licensed under the terms of the GNU LGPL, version 2.1.
--]]

function nsmc.register_metal(modname, metal, is_flammable)
	local formatted_name = modname..":"..metal.name
	minetest.register_craftitem(formatted_name.."_lump", {
		description = "Lump of "..nslib.first_to_upper(metal.name),
		stack_max = 99,
		inventory_image = metal.lump_texture..".png"..nslib.tern(metal.color ~= "no_color" and metal.lump_colorize, "^[multiply:"..metal.color, ""),
		groups = nslib.tern(is_flammable, {flammable = 1}, {})
		}
	)
	minetest.register_craftitem(formatted_name.."_ingot", {
		description = nslib.first_to_upper(metal.name).." Ingot",
		stack_max = 99,
		inventory_image = metal.material_texture..".png"..nslib.tern(metal.color ~= "no_color" and metal.material_colorize, "^[multiply:"..metal.color, "")
		}
	)
end

function nsmc.register_gem(modname, gem, is_flammable)
	local formatted_name = modname..":"..gem.name
	minetest.register_craftitem(formatted_name, {
		description = nslib.first_to_upper(gem.name),
		stack_max = 99,
		inventory_image = gem.material_texture..".png"..nslib.tern(gem.color ~= "no_color" and gem.material_colorize, "^[multiply:"..gem.color, ""),
		groups = nslib.tern(is_flammable, {flammable = 1}, {})
	})
end

function nsmc.register_mineral_craftitems(modname, mineral)
	if mineral.mineral_type == "metal" then
		nsmc.register_metal(modname, mineral, mineral.flammable)
	elseif mineral.mineral_type == "gem" then
		nsmc.register_gem(modname, mineral, mineral.flammable)
	else
		minetest.log("warning","Invalid mineral definition for "..mineral.name..". Defaulting to 'metal'.")
		nsmc.register_metal(modname, mineral, mineral.flammable)
	end
end