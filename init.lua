-- Mapgen
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 80,
	fill_ratio = 0.015,
	height = 1, 
	y_min = 1,
	y_max = 100,
	decoration = "teacraft:tea_plant_wild",
})

-- Mugs
minetest.register_node("teacraft:mug", {
	description = ("Empty Mug"),
	drawtype = "torchlike",
	tiles = {"teacraft_mug.png"},
	inventory_image = "teacraft_mug.png",
	wield_image = "teacraft_mug.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft( {
	output = "teacraft:mug 4",
	recipe = {
		{ "default:clay_lump", "", "default:clay_lump" },
		{"", "default:clay_lump",""},
	}
})

minetest.register_node("teacraft:mug_water", {
	description = ("Mug of Water"),
	drawtype = "torchlike",
	tiles = {"teacraft_watermug.png"},
	inventory_image = "teacraft_watermug.png",
	wield_image = "teacraft_watermug.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1},
	on_use = minetest.item_eat(1, "teacraft:mug"),
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft( {
	output = "teacraft:mug_water 4",
	type = "shapeless",
	recipe = {"teacraft:mug",  "teacraft:mug", "teacraft:mug", "teacraft:mug", "bucket:bucket_water"},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
})

minetest.register_node("teacraft:mug_water_hot", {
	description = ("Mug of Boiling Water"),
	drawtype = "torchlike",
	tiles = {"teacraft_hotwatermug.png"},
	inventory_image = "teacraft_hotwatermug.png",
	wield_image = "teacraft_hotwatermug.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1},
	on_use = minetest.item_eat(-2, "teacraft:mug"),
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft( {
	type = "cooking",
	recipe = "teacraft:mug_water",
	output = "teacraft:mug_water_hot",
})

-- Tea Plants
minetest.register_node("teacraft:tea_plant_wild", {
	description = "Tea Plant (Wild)",
	drawtype = "plantlike",
	tiles = {"teacraft_teaplant.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1},
	sounds = default.node_sound_leaves_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {"teacraft:tea_plant"}}
		}
	}
})
minetest.register_node("teacraft:tea_plant", {
	description = "Tea Plant",
	drawtype = "plantlike",
	tiles = {"teacraft_teaplant.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_abm({
	nodenames = {"teacraft:tea_plant"},
	interval = 14,
	chance = 71,
	action = function(pos, node)
		direction = math.random(1, 4)
		if direction == 1 then
			if minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}).name == "air" and minetest.get_node({x = pos.x + 1, y = pos.y - 1, z = pos.z}).name == "farming:soil_wet" then
				minetest.set_node({x = pos.x + 1, y = pos.y, z = pos.z}, {name = "teacraft:tea_plant"})
			end
		elseif direction == 2 then
			if minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}).name == "air" and minetest.get_node({x = pos.x - 1, y = pos.y - 1, z = pos.z}).name == "farming:soil_wet" then
				minetest.set_node({x = pos.x - 1, y = pos.y, z = pos.z}, {name = "teacraft:tea_plant"})
			end
		elseif direction == 3 then
			if minetest.get_node({x = pos.x, y = pos.y, z = pos.z + 1}).name == "air" and minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z + 1}).name == "farming:soil_wet" then
				minetest.set_node({x = pos.x, y = pos.y, z = pos.z + 1}, {name = "teacraft:tea_plant"})
			end
		elseif direction == 4 then
			if minetest.get_node({x = pos.x, y = pos.y, z = pos.z - 1}).name == "air" and minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z - 1}).name == "farming:soil_wet" then
				minetest.set_node({x = pos.x, y = pos.y, z = pos.z - 1}, {name = "teacraft:tea_plant"})
			end
		end
	end,
})

-- Teabags
minetest.register_craftitem("teacraft:teabag", {
	description = "Tea Bag",
	inventory_image = "teacraft_teabag.png"
})
minetest.register_craft({
	output = "teacraft:teabag",
	recipe = {
		{"farming:cotton"},
		{"default:paper"}
	}
})

-- Tea Leaves
minetest.register_craftitem("teacraft:tea_green", {
	description = "Green Tea",
	inventory_image = "teacraft_greentea.png"
})
minetest.register_craft({
	output = "teacraft:tea_green",
	recipe = {
		{"teacraft:tea_plant"}
	}
})

minetest.register_craftitem("teacraft:tea_black", {
	description = "Black Tea",
	inventory_image = "teacraft_blacktea.png"
})
minetest.register_craft({
	type = "cooking",
	recipe = "teacraft:tea_green",
	output = "teacraft:tea_black",
})

-- Tea in Bags
minetest.register_craftitem("teacraft:teabag_green", {
	description = "Green Tea Bag",
	inventory_image = "teacraft_greenbag.png"
})
minetest.register_craft({
	output = "teacraft:teabag_green",
	type = "shapeless",
	recipe = {"teacraft:teabag", "teacraft:tea_green"}
})

minetest.register_craftitem("teacraft:teabag_black", {
	description = "Black Tea Bag",
	inventory_image = "teacraft_blackbag.png"
})
minetest.register_craft({
	output = "teacraft:teabag_black",
	type = "shapeless",
	recipe = {"teacraft:teabag", "teacraft:tea_black"}
})

-- Mugs of Tea
minetest.register_node("teacraft:mug_green", {
	description = ("Mug of Green Tea"),
	drawtype = "torchlike",
	tiles = {"teacraft_greenmug.png"},
	inventory_image = "teacraft_greenmug.png",
	wield_image = "teacraft_greenmug.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1},
	on_use = minetest.item_eat(4, "teacraft:mug"),
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft( {
	output = "teacraft:mug_green",
	type = "shapeless",
	recipe = {"teacraft:teabag_green", "teacraft:mug_water_hot"}
})

minetest.register_node("teacraft:mug_black", {
	description = ("Mug of Black Tea"),
	drawtype = "torchlike",
	tiles = {"teacraft_blackmug.png"},
	inventory_image = "teacraft_blackmug.png",
	wield_image = "teacraft_blackmug.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1},
	on_use = minetest.item_eat(6, "teacraft:mug"),
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft( {
	output = "teacraft:mug_black",
	type = "shapeless",
	recipe = {"teacraft:teabag_black", "teacraft:mug_water_hot"}
})

-- Mobs + Animals Support
if minetest.get_modpath("mobs_animal") then
	minetest.register_node("teacraft:mug_black_milk", {
		description = ("Mug of Black Tea with Milk"),
		drawtype = "torchlike",
		tiles = {"teacraft_blackmilkmug.png"},
		inventory_image = "teacraft_blackmilkmug.png",
		wield_image = "teacraft_blackmilkmug.png",
		paramtype = "light",
		walkable = false,
		selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
		},
		groups = {dig_immediate = 3, attached_node = 1},
		on_use = minetest.item_eat(10, "teacraft:mug"),
		sounds = default.node_sound_stone_defaults(),
	})
	minetest.register_craft( {
		output = "teacraft:mug_black_milk",
		type = "shapeless",
		recipe = {"teacraft:teabag_black", "teacraft:mug_water_hot", "mobs:bucket_milk"},
		replacements = {{"mobs:bucket_milk", "bucket:bucket_empty"}}
	})
end

-- Farming Redo Support
if minetest.get_modpath("farming") then
if farming.mod == "redo" then
	minetest.register_node("teacraft:andrew_horowitz", {
		description = ("The Andrew Horowitz"),
		drawtype = "torchlike",
		tiles = {"teacraft_andrew_horowitz.png"},
		inventory_image = "teacraft_andrew_horowitz.png",
		wield_image = "teacraft_andrew_horowitz.png",
		paramtype = "light",
		walkable = false,
		selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
		},
		groups = {dig_immediate = 3, attached_node = 1},
		on_use = minetest.item_eat(8, "farming:drinking_cup"),
		sounds = default.node_sound_stone_defaults(),
	})
	minetest.register_craft( {
		output = "teacraft:andrew_horowitz",
		type = "shapeless",
		recipe = {"teacraft:teabag_black", "farming:coffee_cup_hot"},
	})
end
end
