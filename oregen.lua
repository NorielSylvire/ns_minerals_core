--[[
Minerals Core Mod by Noriel_Sylvire.
This source file automates ore registration.

Copyright (c) 2020 Noriel_Sylvire.

This library is licensed under the terms of the GNU LGPL, version 2.1.
--]]

local mgv7_flags = minetest.settings:get_flags("mgv7_spflags")

function nsmc.register_oregen(modname, mineral, sobelow_present)
	local ore_name = modname..":stone_with_"..mineral.name
	if not sobelow_present then
		if mineral.skymineral == true and mgv7_flags.floatlands == true then	-- to be implemented, ignore
			-- for i = 0, #mineral.vanilla_oregen.scarcity do
				-- minetest.register_ore({
					-- ore_type       = "scatter",
					-- ore            = ore_name,
					-- wherein        = mineral.wherein_node,
					-- clust_scarcity = mineral.vanilla_oregen.scarcity[i],
					-- clust_num_ores = mineral.vanilla_oregen.num_ores[i],
					-- clust_size     = mineral.vanilla_oregen.size[i],
					-- y_max          = mineral.floatlands.max[i],
					-- y_min          = mineral.floatlands.min[i]
				-- })
			-- end
		else
			for i = 1, #mineral.vanilla_oregen.scarcity do	-- this is the only bit that currently works
				minetest.register_ore({
					ore_type       = "scatter",
					ore            = ore_name,
					wherein        = mineral.vanilla_oregen.wherein_node,
					clust_scarcity = mineral.vanilla_oregen.scarcity[i] * mineral.vanilla_oregen.scarcity[i] * mineral.vanilla_oregen.scarcity[i],
					clust_num_ores = mineral.vanilla_oregen.num_ores[i],
					clust_size     = mineral.vanilla_oregen.size[i],
					y_max          = mineral.vanilla_oregen.max[i],
					y_min          = mineral.vanilla_oregen.min[i]
				})
			end
		end
	end
	if minetest.settings:get("enable_super_mining_layer") then -- to be implemented, ignore
		for i = 0, #mineral.vanilla_oregen.scarcity do
				minetest.register_ore({
					ore_type       = "scatter",
					ore            = ore_name,
					wherein        = mineral.wherein_node,
					clust_scarcity = mineral.vanilla_oregen.scarcity[i],
					clust_num_ores = mineral.vanilla_oregen.num_ores[i],
					clust_size     = mineral.vanilla_oregen.size[i],
					y_max          = mineral.vanilla_oregen.max[i],
					y_min          = mineral.vanilla_oregen.min[i]
				})
			end
	end
end