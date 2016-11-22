dmobs = {}

-- dmobs by D00Med

-- mounts api by D00Med and lib_mount api by blert2112

dofile(minetest.get_modpath("dmobs").."/api.lua")

-- Enable dragons (disable to remove tamed dragons and dragon bosses)
dmobs.dragons = true

-- Enable fireballs/explosions
dmobs.destructive = false

-- load baddies

dofile(minetest.get_modpath("dmobs").."/baddies.lua")

--butterflies

minetest.register_abm({
	nodenames = {"flowers:flower_rose", "flowers:flower_tulip", "flowers:flower_dandelion_yellow", "flowers:flower_viola", "flowers:flower_dandelion_white", "flowers:flower_geranium"},
	interval = 10.0,
	chance = 10,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.env:add_entity({x=pos.x,y=pos.y,z=pos.z}, "dmobs:butterfly")
	end
})

minetest.register_entity("dmobs:butterfly", {
	visual = "sprite",
	physical = true,
	textures = {"dmobs_butterfly.png",},
	visual_size = {x=0.2, y=0.2},
	on_activate = function(self)
		num = math.random(1,4)
		self.object:set_properties({textures = {"dmobs_butterfly"..num..".png",},})
		minetest.after(5, function()
		self.object:remove()
		end)
	end,
	on_step = function(self)
		local pos = self.object:getpos()
		local vec = self.object:getvelocity()
		self.object:setvelocity({x=-math.sin(12*pos.y), y=math.cos(12*pos.x), z=-math.sin(12*pos.y)})
		self.object:setacceleration({x=-math.sin(6*vec.y), y=math.cos(6*vec.x), z=-math.sin(6*vec.y)})
	end,
	collisionbox = {0,0,0,0,0.1,0},
})

--wasps nest

minetest.register_node("dmobs:hive", {
	description = "Wasp Nest",
	tiles = {"dmobs_hive.png"},
	groups = {crumbly=1, oddly_breakable_by_hand=1, falling_node=1, flammable=1},
	on_destruct = function(pos, oldnode)
		minetest.env:add_entity(pos, "dmobs:wasp")
		minetest.env:add_entity(pos, "dmobs:wasp")
		minetest.env:add_entity(pos, "dmobs:wasp")
		minetest.env:add_entity(pos, "dmobs:wasp")
	end,
})

--golem

minetest.register_node("dmobs:golemstone", {
	description = "golem stone",
	tiles = {"dmobs_golem_stone.png",},
	groups = {cracky=1},
	on_construct = function(pos, node, _)
		local node1 = minetest.env:get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		local node2 = minetest.env:get_node({x=pos.x, y=pos.y-2, z=pos.z}).name
		local node3 = minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
		if node1 == "default:stone" and node2 == "default:stone" and node3 == "air" then
		minetest.env:add_entity(pos, "dmobs:golem_friendly")
		minetest.env:remove_node({x=pos.x, y=pos.y-1, z=pos.z})
		minetest.env:remove_node({x=pos.x, y=pos.y-2, z=pos.z})
		minetest.env:remove_node({x=pos.x, y=pos.y, z=pos.z})
		end
	end,
})

mobs:register_mob("dmobs:golem_friendly", {
	type = "npc",
	reach = 3,
	damage = 2,
	attack_type = "dogfight",
	attacks_monsters = true,
	hp_min = 62,
	hp_max = 72,
	armor = 100,
	collisionbox = {-0.4, 0, -0.4, 0.4, 2.5, 0.4},
	visual = "mesh",
	mesh = "golem.b3d",
	textures = {
		{"dmobs_golem.png"},
	},
	follow = "default:cobble",
	blood_texture = "default_stone.png",
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 2.5,
	jump = true,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 0,
	fear_height = 10,
	view_range = 14,
	animation = {
		speed_normal = 10,
		speed_run = 14,
		walk_start = 46,
		walk_end = 66,
		stand_start = 1,
		stand_end = 20,
		run_start = 46,
		run_end = 66,
		punch_start = 20,
		punch_end = 45,
	},
})

mobs:register_egg("dmobs:golem_friendly", "Stone Golem (friendly)", "default_stone.png", 1)

--friendly mobs

mobs:register_mob("dmobs:panda", {
	type = "animal",
	passive = false,
	reach = 1,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 12,
	hp_max = 22,
	armor = 130,
	collisionbox = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
	visual = "mesh",
	mesh = "panda.b3d",
	textures = {
		{"dmobs_panda.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	walk_velocity = 0.5,
	run_velocity = 1,
	jump = true,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fall_speed = -10,
	fear_height = 4,
	jump_height = 2,
	replace_rate = 10,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "ethereal:bamboo"},
	replace_with = "air",
	follow = {"default:papyrus"},
	view_range = 14,
	animation = {
		speed_normal = 6,
		speed_run = 10,
		walk_start = 25,
		walk_end = 45,
		stand_start = 10,
		stand_end = 10,
		run_start = 25,
		run_end = 45,
		punch_start = 46,
		punch_end = 57,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})

mobs:register_spawn("dmobs:panda", {"default:dirt_with_grass","ethereal:bamboo_dirt"}, 20, 10, 15000, 2, 31000)

mobs:register_egg("dmobs:panda", "Panda", "default_papyrus.png", 1)

mobs:register_mob("dmobs:tortoise", {
	type = "animal",
	passive = false,
	reach = 1,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 6,
	hp_max = 12,
	armor = 130,
	collisionbox = {-0.2, 0, -0.2, 0.2, 0.3, 0.2},
	visual = "mesh",
	mesh = "tortoise.b3d",
	textures = {
		{"dmobs_tortoise.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	walk_velocity = 0.5,
	run_velocity = 1,
	jump = false,
	jump_height = 0.5,
	floats = true,
	drops = {
		{name = "default:stick", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fall_speed = -10,
	fear_height = 4,
	follow = {"default:papyrus"},
	view_range = 14,
	animation = {
		speed_normal = 6,
		speed_run = 10,
		walk_start = 23,
		walk_end = 43,
		stand_start = 1,
		stand_end = 20,
		run_start = 23,
		run_end = 43,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 30, 50, 80, false, nil)
	end,
})

mobs:register_spawn("dmobs:tortoise", {"default:clay","default:sand"}, 20, 10, 15000, 2, 31000)

mobs:register_egg("dmobs:tortoise", "Panda", "default_grass.png", 1)

mobs:register_mob("dmobs:pig", {
	type = "animal",
	passive = true,
	reach = 4,
	damage = 2,
	attack_type = "explode",
	explosion_radius = 3,
	hp_min = 12,
	hp_max = 22,
	armor = 130,
	collisionbox = {-0.4, 0, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "flying_pig.b3d",
	textures = {
		{"dmobs_flying_pig.png"},
	},
   jump = true,
   fly = true,
   fall_speed = 0,
   stepheight = 1.5,
	blood_texture = "mobs_blood.png",
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	runaway = false,
	walk_velocity = 2,
	run_velocity = 3,
	run_chance = 20,
	jump = true,
	drops = {
		{name = "mobs:meat_raw", chance = 2, min = 1, max = 1},
	},
	sounds = {
      random = "mobs_pig",
	  explode = "tnt_explode",
	},
	do_custom = function(self)
		if self.state == "attack" then
			self.fly = false
			self.fall_speed = -4
		end
	end,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	follow = {"default:apple"},
	view_range = 14,
	animation = {
		speed_normal = 10,
		speed_run = 15,
		walk_start = 1,
		walk_end = 20,
		stand_start = 1,
		stand_end = 20,
		run_start = 22,
		run_end = 28,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})

mobs:register_spawn("dmobs:pig", {"default:pine_needles","default:leaves", "nyanland:cloudstone"}, 20, 10, 32000, 2, 31000)

mobs:register_egg("dmobs:pig", "flying Pig", "wool_pink.png", 1)

mobs:register_mob("dmobs:nyan", {
	type = "animal",
	passive = true,
	reach = 4,
	damage = 2,
	hp_min = 12,
	hp_max = 22,
	armor = 130,
	collisionbox = {-0.2, 0, -0.2, 0.2, 0.6, 0.2},
	visual = "mesh",
	mesh = "nyancat.b3d",
	textures = {
		{"dmobs_nyancat.png"},
	},
   jump = true,
   fly = true,
   fall_speed = 0,
   stepheight = 1.5,
	blood_texture = "mobs_blood.png",
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	runaway = false,
	walk_velocity = 2,
	run_velocity = 3,
	run_chance = 20,
	jump = true,
	drops = {
		{name = "default:nyan_cat", chance = 2, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	follow = {"default:mese"},
	view_range = 14,
	animation = {
		speed_normal = 4,
		speed_run = 5,
		walk_start = 1,
		walk_end = 7,
		stand_start = 1,
		stand_end = 7,
		run_start = 1,
		run_end = 7,

	},
   do_custom = function(self)
   local apos = self.object:getpos()
		local vec = self.object:getvelocity()
		local part = minetest.add_particlespawner(
			5, --amount
			0.3, --time
			{x=apos.x-0.1, y=apos.y+0.3, z=apos.z-0.1}, --minpos
			{x=apos.x+0.1, y=apos.y+0.4, z=apos.z+0.1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=0,y=0,z=0}, --minacc
			{x=-vec.x,y=0,z=-vec.z}, --maxacc
			0.5, --minexptime
			1.5, --maxexptime
			3, --minsize
			5, --maxsize
			false, --collisiondetection
			"dmobs_rainbow.png" --texture
		)
   end,
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})

mobs:register_spawn("dmobs:nyan", {"default:pine_needles","default:leaves"}, 20, 10, 50000, 2, 31000)
mobs:register_spawn("dmobs:nyan", {"nyanland:meseleaves"}, 20, 10, 15000, 2, 31000)

mobs:register_egg("dmobs:nyan", "Nyan Cat", "wool_pink.png", 1)

mobs:register_mob("dmobs:gnorm", {
	type = "npc",
	can_dig = true,
	passive = true,
	reach = 1,
	damage = 1,
	attack_type = "dogfight",
	hp_min = 32,
	hp_max = 42,
	armor = 130,
	collisionbox = {-0.4, -0.3, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "gnorm.b3d",
	textures = {
		{"dmobs_gnorm.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	runaway = true,
	walk_velocity = 0.5,
	run_velocity = 4,
	jump = true,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fall_speed = -6,
	fear_height = 4,
	replace_rate = 10,
	replace_what = {"default:apple", "default:stone", "default:stone_with_coal", "default:fence_wood"},
	replace_with = "air",
	follow = {"default:apple"},
	view_range = 14,
	animation = {
		speed_normal = 8,
		speed_run = 30,
		walk_start = 62,
		walk_end = 81,
		stand_start = 2,
		stand_end = 9,
		run_start = 62,
		run_end = 81,
		punch_start = 1,
		punch_end = 1,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})

mobs:register_spawn("dmobs:gnorm", {"default:dirt_with_grass","default:wood"}, 20, 10, 32000, 2, 31000)

mobs:register_egg("dmobs:gnorm", "Gnorm", "default_dirt.png", 1)

mobs:register_mob("dmobs:hedgehog", {
	type = "animal",
	passive = true,
	hp_min = 12,
	hp_max = 22,
	armor = 130,
	collisionbox = {-0.1, -0.1, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "hedgehog.b3d",
	textures = {
		{"dmobs_hedgehog.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=2, y=2},
	makes_footstep_sound = true,
	walk_velocity = 0.5,
	run_velocity = 1,
	jump = true,
	jump_height = 0.6,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fall_speed = -6,
	fear_height = 4,
	view_range = 14,
	follow = {"farming:bread"},
	animation = {
		speed_normal = 5,
		speed_run = 10,
		walk_start = 1,
		walk_end = 10,
		stand_start = 1,
		stand_end = 10,
		run_start = 1,
		run_end = 10,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})

mobs:register_spawn("dmobs:hedgehog", {"default:dirt_with_grass","default:pine_needles"}, 20, 10, 15000, 2, 31000)

mobs:register_egg("dmobs:hedgehog", "Hedgehog", "wool_brown.png", 1)

mobs:register_mob("dmobs:owl", {
	type = "animal",
	passive = true,
	hp_min = 12,
	hp_max = 22,
	armor = 130,
	collisionbox = {-0.3, -0.5, -0.3, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "owl.b3d",
	textures = {
		{"dmobs_owl.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=2, y=2},
	makes_footstep_sound = false,
	walk_velocity = 0,
	run_velocity = 0,
	jump = false,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 0,
	view_range = 1,
	do_custom = function(self)
	local daytime = minetest.get_timeofday()*24000 
	if daytime <=6000 then
	self.object:set_properties({
						textures = {"dmobs_owl_awake.png"},
						mesh = "owl.b3d",
					})
	elseif daytime >=6000 then
	self.object:set_properties({
						textures = {"dmobs_owl.png"},
						mesh = "owl.b3d",
					})
	end
	end,
	animation = {
		speed_normal = 1,
		walk_start = 1,
		walk_end = 50,

	},
})

mobs:register_spawn("dmobs:owl", {"default:leaves","default:tree"}, 20, 10, 15000, 2, 31000)

mobs:register_egg("dmobs:owl", "Owl", "default_tree.png", 1)


mobs:register_mob("dmobs:elephant", {
	type = "animal",
	passive = false,
	reach = 1,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 12,
	hp_max = 22,
	armor = 130,
	collisionbox = {-0.9, -1.2, -0.9, 0.9, 0.9, 0.9},
	visual = "mesh",
	mesh = "elephant.b3d",
	textures = {
		{"dmobs_elephant.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=2.5, y=2.5},
	makes_footstep_sound = true,
	walk_velocity = 0.5,
	run_velocity = 1,
	jump = false,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fall_speed = -20, -- extra heavy!
	fear_height = 2,
	replace_rate = 10,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "ethereal:bamboo"},
	replace_with = "air",
	follow = {"farming:wheat"},
	view_range = 14,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	animation = {
		speed_normal = 5,
		speed_run = 10,
		walk_start = 3,
		walk_end = 19,
		stand_start = 20,
		stand_end = 30,
		run_start = 3,
		run_end = 19,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})

mobs:register_spawn("dmobs:elephant", {"default:dirt_with_dry_grass","default:desert_sand"}, 20, 10, 15000, 2, 31000)

mobs:register_egg("dmobs:elephant", "Elephant", "default_dry_grass.png", 1)

mobs:register_mob("dmobs:whale", {
	type = "animal",
	passive = false,
	reach = 1,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 52,
	hp_max = 82,
	armor = 230,
	collisionbox = {-0.9, -1.2, -0.9, 0.9, 0.9, 0.9},
	visual = "mesh",
	mesh = "whale.b3d",
	textures = {
		{"dmobs_whale.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=2.5, y=2.5},
	makes_footstep_sound = true,
	walk_velocity = 0.5,
	run_velocity = 1,
	jump = false,	
	stepheight = 1.5,
	fall_damage = 0,
	fall_speed = -6,
	fly = true,
	fly_in = "default:water_source",
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	follow = {"fishing:fish_cooked"},
	view_range = 14,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	sounds = {
      random = "whale_1",
      death = "whale_1",
      distance = 128,
	},
	animation = {
		speed_normal = 5,
		speed_run = 10,
		walk_start = 2,
		walk_end = 39,
		stand_start = 2,
		stand_end = 39,
		run_start = 2,
		run_end = 39,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})

mobs:register_spawn("dmobs:whale", {"default:water_source"}, 20, 10, 15000, -20, 1000)

mobs:register_egg("dmobs:whale", "Whale", "default_water_source.png", 1)

mobs:register_mob("dmobs:badger", {
	type = "animal",
	passive = false,
	reach = 1,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 12,
	hp_max = 22,
	armor = 130,
	collisionbox = {-0.3, -0.15, -0.3, 0.3, 0.4, 0.3},
	visual = "mesh",
	mesh = "badger.b3d",
	textures = {
		{"dmobs_badger.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=2, y=2},
	makes_footstep_sound = true,
	walk_velocity = 0.7,
	run_velocity = 1,
	jump = true,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fall_speed = -8,
	fear_height = 4,
	follow = {"mobs:meat_raw"},
	view_range = 14,
	animation = {
		speed_normal = 12,
		speed_run = 18,
		walk_start = 34,
		walk_end = 58,
		stand_start = 1,
		stand_end = 30,
		run_start = 34,
		run_end = 58,
		punch_start = 60,
		punch_end = 80,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})

mobs:register_spawn("dmobs:badger", {"default:dirt_with_grass","default:dirt"}, 20, 10, 15000, 2, 31000)

mobs:register_egg("dmobs:badger", "Badger", "default_obsidian.png", 1)


