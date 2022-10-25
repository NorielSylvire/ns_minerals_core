--[[
Minerals Core Mod by Noriel_Sylvire.
This source file automates tool registration.

Copyright (c) 2020 Noriel_Sylvire (Flaviu E. Hongu).
Copyright (c) 2016 TenPlus1 (for the scythe registration code)

This library is licensed under the terms of the GNU LGPL, version 2.1.
--]]

function nsmc.register_hoe(modname, mineral)
	local name = mineral.name

	farming.register_hoe(modname..":hoe_"..name, {
		description = nslib.first_to_upper(name).." Hoe",
		inventory_image = nslib.tern(mineral.hoe_texture_handle ~= "no_texture", mineral.hoe_texture_handle..".png", "")
						.."^("
						..mineral.hoe_texture_head..".png"
						..nslib.tern(mineral.color ~= "no_color" and mineral.hoe_colorize, "^[multiply:"..mineral.color, "")
						..")",
		max_uses = mineral.hoe.uses,
		material = modname..":"..name..nslib.tern(mineral.mineral_type == "metal", "_ingot", "")
	})
end

function nsmc.register_scythe(modname, mineral)
	local name = mineral.name
	-- Code from here until the end of function is modified and copied from TenPlus1's farming mod, hoes.lua file.
	minetest.register_tool(modname..":scythe_"..name, {
		description = nslib.first_to_upper(name).." Scythe",
		inventory_image = nslib.tern(mineral.scythe_texture_handle ~= "no_texture", mineral.scythe_texture_handle..".png", "")
						.."^("
						..mineral.scythe_texture_head..".png"
						..nslib.tern(mineral.color ~= "no_color" and mineral.scythe_colorize, "^[multiply:"..mineral.color, "")
						..")",
		sound = {breaks = "default_tool_breaks"},
		on_use = function(itemstack, placer, pointed_thing)

			if pointed_thing.type ~= "node" then
				return
			end

			local pos = pointed_thing.under
			local name = placer:get_player_name()

			if minetest.is_protected(pos, name) then
				return
			end

			local node = minetest.get_node_or_nil(pos)

			if not node then
				return
			end

			local def = minetest.registered_nodes[node.name]

			if not def
			or not def.drop
			or not def.groups
			or not def.groups.plant then
				return
			end

			local drops = minetest.get_node_drops(node.name, "")

			if not drops
			or #drops == 0
			or (#drops == 1 and drops[1] == "") then
				return
			end

			-- get crop name
			local mname = node.name:split(":")[1]
			local pname = node.name:split(":")[2]
			local sname = tonumber(pname:split("_")[2])
			pname = pname:split("_")[1]

			if not sname then
				return
			end

			-- add dropped items
			for _, dropped_item in pairs(drops) do

				-- dont drop items on this list
				for _, not_item in pairs(farming.scythe_not_drops) do

					if dropped_item == not_item then
						dropped_item = nil
					end
				end

				if dropped_item then

					local obj = minetest.add_item(pos, dropped_item)

					if obj then

						obj:set_velocity({
							x = math.random(-10, 10) / 9,
							y = 3,
							z = math.random(-10, 10) / 9
						})
					end
				end
			end

			-- Run script hook
			for _, callback in pairs(core.registered_on_dignodes) do
				callback(pos, node, placer)
			end

			-- play sound
			minetest.sound_play("default_grass_footstep", {pos = pos, gain = 1.0})

			local replace = mname .. ":" .. pname .. "_1"

			if minetest.registered_nodes[replace] then

				local p2 = minetest.registered_nodes[replace].place_param2 or 1

				minetest.set_node(pos, {name = replace, param2 = p2})
			else
				minetest.set_node(pos, {name = "air"})
			end

			if not farming.is_creative(name) then

				itemstack:add_wear(65535 / mineral.scythe.uses) -- 150 uses

				return itemstack
			end
		end,
	})
end
