local pigdef = {
	type = "monster",
	passive = true,
	reach = 3,
	damage = 2,
	attack_type = "dogfight",
	explosion_radius = 2,
	hp_min = 12,
	hp_max = 22,
	armor = 130,
	collisionbox = {-0.4, 0, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "flying_pig.b3d",
	textures = {
		{"dmobs_flying_pig_mean.png"},
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
}

if dmobs.destructive then
	pigdef.sounds.explode = "tnt_explode"
	pigdef.attack_type = "explode"
end

mobs:register_mob("dmobs:pig_evil", pigdef)

mobs:register_spawn("dmobs:pig_evil", {"default:pine_needles","default:leaves"}, 20, 10, 32000, 2, 31000)

mobs:register_egg("dmobs:pig_evil", "kamikaze Pig", "wool_pink.png", 1)

-- Fox
mobs:register_mob("dmobs:fox", {
	type = "monster",
	attacks_monsters = true,
	reach = 1,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 42,
	hp_max = 52,
	armor = 130,
	collisionbox = {-0.4, -0.6, -0.4, 0.3, 0.3, 0.3},
	runaway = true,
	pathfinding = true,
	visual = "mesh",
	mesh = "fox.b3d",
	textures = {
		{"dmobs_fox.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=1.5, y=1.5},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 2.5,
	jump = true,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	on_activate = function(self)
		if math.random(1,5) == 1 then
		self.type = "animal"
		end
	end,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fear_height = 4,
	replace_rate = 10,
	replace_what = {"farming:wheat_5", "default:fence_wood", "default:grass_5", "default:dirt_with_grass"},
	replace_with = "air",
	follow = {"mobs:meat_raw"},
	view_range = 14,
	animation = {
		speed_normal = 6,
		speed_run = 15,
		walk_start = 25,
		walk_end = 35,
		stand_start = 51,
		stand_end = 60,
		run_start = 1,
		run_end = 16,
		punch_start = 36,
		punch_end = 51,
	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})

mobs:register_spawn("dmobs:fox", {"default:dirt_with_grass","default:dirt"}, 20, 10, 32000, 2, 31000)

mobs:register_egg("dmobs:fox", "Fox", "wool_orange.png", 1)

--Rat

mobs:register_mob("dmobs:rat", {
	type = "monster",
	reach = 2,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 22,
	hp_max = 42,
	armor = 130,
	collisionbox = {-0.4, 0, -0.4, 0.3, 1, 0.3},
	runaway = true,
	visual = "mesh",
	mesh = "dmobs_rat.b3d",
	textures = {
		{"dmobs_rat.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 2.5,
	jump = true,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fear_height = 5,
	replace_rate = 10,
	replace_what = {"farming:wheat_5", "farming:wheat_4", "farming:wheat_2", "farming:wheat_3"},
	replace_with = "air",
	follow = {"mobs_animal:cheese"},
	view_range = 14,
	animation = {
		speed_normal = 10,
		speed_run = 18,
		walk_start = 43,
		walk_end = 63,
		stand_start = 1,
		stand_end = 20,
		run_start = 43,
		run_end = 63,
		punch_start = 20,
		punch_end = 40,
	},
})

mobs:register_spawn("dmobs:rat", {"default:stone","default:sand"}, 20, 0, 32000, 2, 31000)

mobs:register_egg("dmobs:rat", "Giant Rat", "wool_grey.png", 1)

--Wasps!
mobs:register_mob("dmobs:wasp", {
	type = "monster",
	reach = 1,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 2,
	hp_max = 5,
	armor = 100,
	collisionbox = {-0.1, -0, -0.1, 0.1, 0.5, 0.1},
	fly = true,
	fall_speed = 0,
	stepheight = 1.5,
	visual = "mesh",
	mesh = "wasp.b3d",
	textures = {
		{"dmobs_wasp.png"},
	},
	sounds = {
		random = "wasp",
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=0.6, y=0.6},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 0,
	view_range = 14,
	animation = {
		speed_normal = 15,
		speed_run = 30,
		walk_start = 1,
		walk_end = 5,
		stand_start = 1,
		stand_end = 5,
		run_start = 1,
		run_end = 5,
		punch_start = 6,
		punch_end = 15,
	},
})

mobs:register_spawn("dmobs:wasp", {"default:dirt_with_grass"}, 20, 10, 32000, 2, 31000)
mobs:register_spawn("dmobs:wasp", {"dmobs:hive"}, 20, 10, 16000, 2, 31000)

mobs:register_egg("dmobs:wasp", "Wasp", "dmobs_wasp_bg.png", 1)

mobs:register_mob("dmobs:wasp_leader", {
	type = "monster",
	reach = 1,
	damage = 2,
	attack_type = "shoot",
	shoot_interval = 1,
	arrow = "dmobs:sting",
	shoot_offset = 0,
	hp_min = 82,
	hp_max = 122,
	armor = 130,
	collisionbox = {-0.4, -0, -0.4, 0.3, 2, 0.3},
	pathfinding = true,
	fly = true,
	fall_speed = 0,
	stepheight = 1.5,
	visual = "mesh",
	mesh = "wasp.b3d",
	textures = {
		{"dmobs_wasp.png"},
	},
	sounds = {
		random = "wasp",
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=3.5, y=3.5},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 2.5,
	jump = true,
	drops = {
		{name = "default:gold_lump", chance = 1, min = 3, max = 5},
	},
	do_custom = function(self)
	if math.random(1, 500) >= 500 then
	local pos = self.object:getpos()
	minetest.env:add_entity(pos, "dmobs:wasp")
	end
	end,
	replace_rate = 700,
	replace_what = {"air"},
	replace_with = "dmobs:hive",
	water_damage = 2,
	lava_damage = 2,
	light_damage = 0,
	view_range = 14,
	animation = {
		speed_normal = 6,
		speed_run = 15,
		walk_start = 1,
		walk_end = 5,
		stand_start = 1,
		stand_end = 5,
		run_start = 1,
		run_end = 5,
		shoot_start = 6,
		shoot_end = 15,
	},
})

mobs:register_spawn("dmobs:wasp_leader", {"default:dirt_with_grass","dmobs:hive"}, 20, 10, 64000, 2, 31000)

mobs:register_egg("dmobs:wasp_leader", "King of Sting", "dmobs_wasp_bg.png", 1)

-- Treeman

mobs:register_mob("dmobs:treeman", {
	type = "monster",
	reach = 3,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 62,
	hp_max = 72,
	armor = 130,
	collisionbox = {-0.4, 0, -0.4, 0.4, 3, 0.4},
	visual = "mesh",
	mesh = "treeman.b3d",
	textures = {
		{"dmobs_treeman.png"},
		{"dmobs_treeman2.png"},
	},
	blood_texture = "default_tree.png",
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 2.5,
	jump = true,
	drops = {
		{name = "default:tree", chance = 5, min = 3, max = 6},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fear_height = 10,
	view_range = 14,
	animation = {
		speed_normal = 10,
		speed_run = 13,
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

mobs:register_spawn("dmobs:treeman", {"default:leaves", "default:pine_needles"}, 7, 0, 16000, 2, 31000)

mobs:register_egg("dmobs:treeman", "Treeman", "default_tree.png", 1)

--stone golem


mobs:register_mob("dmobs:golem", {
	type = "monster",
	reach = 3,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 62,
	hp_max = 72,
	armor = 100,
	collisionbox = {-0.4, 0, -0.4, 0.4, 2.5, 0.4},
	visual = "mesh",
	mesh = "golem.b3d",
	textures = {
		{"dmobs_golem.png"},
	},
	blood_texture = "default_stone.png",
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 2.5,
	jump = true,
	drops = {
		{name = "dmobs:golemstone", chance = 30, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 1,
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

mobs:register_spawn("dmobs:golem", {"default:stone"}, 7, 0, 16000, 2, 31000)

mobs:register_egg("dmobs:golem", "Stone Golem", "default_stone.png", 1)

--skeleton


mobs:register_mob("dmobs:skeleton", {
	type = "monster",
	reach = 3,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 62,
	hp_max = 72,
	armor = 100,
	collisionbox = {-0.4, 0, -0.4, 0.4, 2.5, 0.4},
	visual = "mesh",
	mesh = "skeleton.b3d",
	textures = {
		{"dmobs_skeleton.png"},
	},
	blood_texture = "default_stone.png",
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 2.5,
	jump = true,
	drops = {
		{name = "bones:bones", chance = 5, min = 3, max = 6},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 1,
	fall_damage = 0,
	fear_height = 10,
	view_range = 14,
	animation = {
		speed_normal = 15,
		speed_run = 20,
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

mobs:register_spawn("dmobs:skeleton", {"default:stone"}, 7, 0, 16000, 2, 31000)

mobs:register_egg("dmobs:skeleton", "Skeleton", "default_dirt.png", 1)

-- Orc
mobs:register_mob("dmobs:orc", {
	type = "monster",
	passive = false,
	reach = 1,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 12,
	hp_max = 22,
	armor = 130,
	collisionbox = {-0.4, -1.3, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "orc.b3d",
	textures = {
		{"dmobs_orc.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=3, y=3},
	makes_footstep_sound = true,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	walk_velocity = 1,
	run_velocity = 2,
	jump = true,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fall_speed = -13,
	fear_height = 4,
	view_range = 14,
	animation = {
		speed_normal = 10,
		speed_run = 20,
		walk_start = 2,
		walk_end = 18,
		stand_start = 30,
		stand_end = 40,
		run_start = 2,
		run_end = 18,
		punch_start = 20,
		punch_end = 30,

	},
})

-- Orc (Redesign)
mobs:register_mob("dmobs:orc_redesign", {
	type = "monster",
	passive = false,
	reach = 1,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 12,
	hp_max = 22,
	armor = 130,
	collisionbox = {-0.4, -0, -0.4, 0.4, 2, 0.4},
	visual = "mesh",
	mesh = "orc_redesign.b3d",
	textures = {
		{"dmobs_orc_redesign.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=1.5, y=1.5},
	makes_footstep_sound = true,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	walk_velocity = 1,
	run_velocity = 2,
	jump = true,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fall_speed = -13,
	fear_height = 4,
	view_range = 14,
	animation = {
		speed_normal = 12,
		speed_run = 20,
		walk_start = 20,
		walk_end = 40,
		stand_start = 60,
		stand_end = 80,
		run_start = 20,
		run_end = 40,
		punch_start = 1,
		punch_end = 15,

	},
})

if not dmobs.dragons == true then
mobs:register_spawn("dmobs:orc", {"default:snow","default:snow_block", "default:desert_sand"}, 20, 10, 15000, 2, 31000)
else
mobs:register_spawn("dmobs:orc", {"default:snow","default:snow_block", "default:desert_sand"}, 20, 10, 3500, 2, 31000)
end

mobs:register_egg("dmobs:orc_redesign", "Orc (redesign)", "default_desert_sand.png", 1)
mobs:register_egg("dmobs:orc", "Orc", "default_desert_sand.png", 1)

-- Ogre
mobs:register_mob("dmobs:ogre", {
	type = "monster",
	passive = false,
	reach = 2,
	damage = 4,
	attack_type = "dogfight",
	hp_min = 22,
	hp_max = 32,
	armor = 130,
	collisionbox = {-0.6, -1.3, -0.6, 0.6, 1.5, 0.6},
	visual = "mesh",
	mesh = "ogre.b3d",
	textures = {
		{"dmobs_ogre.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=3.5, y=3.5},
	makes_footstep_sound = true,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	walk_velocity = 1,
	run_velocity = 2,
	jump = true,
	rotate = 180,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fall_speed = -14,
	fear_height = 4,
	view_range = 14,
	animation = {
		speed_normal = 10,
		speed_run = 20,
		walk_start = 3,
		walk_end = 38,
		stand_start = 40,
		stand_end = 70,
		run_start = 3,
		run_end = 38,
		punch_start = 70,
		punch_end = 100,

	},
})

if not dmobs.dragons == true then
mobs:register_spawn("dmobs:ogre", {"default:snow","default:dirt_with_dry_grass", "default:desert_sand"}, 20, 10, 15000, 2, 31000)
else
mobs:register_spawn("dmobs:ogre", {"default:snow","default:dirt_with_dry_grass", "default:desert_sand"}, 20, 10, 350, 2, 31000)
end

mobs:register_egg("dmobs:ogre", "Ogre", "default_desert_sand.png", 1)

mobs:register_arrow("dmobs:sting", {
	   visual = "sprite",
	   visual_size = {x = 0.5, y = 0.5},
	   textures = {"dmobs_sting.png"},
	   velocity = 8,
	   tail = 0, -- enable tail
	   tail_texture = "fire_basic_flame.png",

	   hit_player = function(self, player)
	      player:punch(self.object, 1.0, {
		 full_punch_interval = 1.0,
		 damage_groups = {fleshy = 1},
	      }, nil)
	   end,
	   
	   hit_mob = function(self, player)
	   end,

	   hit_node = function(self, pos, node)
	      self.object:remove()
	   end,
	})

--dragon
if dmobs.dragons == true then
	dofile(minetest.get_modpath("dmobs").."/dragons.lua")
else
	mobs:register_mob("dmobs:dragon", {
	   type = "monster",
	   passive = false,
	   attacks_monsters = true,
	   damage = 4,
	   reach = 3,
	   attack_type = "dogshoot",
	   shoot_interval = 2.5,
		dogshoot_switch = 2,
		dogshoot_count = 0,
		dogshoot_count_max =5,
	   arrow = "dmobs:fire",
	   shoot_offset = 1,
	   hp_min = 70,
	   hp_max = 100,
	   armor = 100,
		collisionbox = {-0.6, -1.2, -0.6, 0.6, 0.6, 0.6},
	   visual = "mesh",
	   mesh = "dragon.b3d",
	   textures = {
	      {"dmobs_dragon.png"},
	      {"dmobs_dragon2.png"},
	      {"dmobs_dragon3.png"},
	      {"dmobs_dragon4.png"},
	   },
	   blood_texture = "mobs_blood.png",
	   visual_size = {x=2, y=2},
	   makes_footstep_sound = true,
		runaway = false,
		jump_chance = 30,
		walk_chance = 80,
		fall_speed = 0,
		pathfinding = true,
		fall_damage = 0,
	   sounds = {
	      shoot_attack = "mobs_fireball",
	   },
	   walk_velocity = 3,
	   run_velocity = 5,
	   jump = true,
	   fly = true,
	   drops = {
	      {name = "mobs:lava_orb", chance = 1, min = 1, max = 1},
	   },
	   fall_speed = 0,
	   stepheight = 10,
	   water_damage = 2,
	   lava_damage = 0,
	   light_damage = 0,
	   view_range = 20,
	   animation = {
	      speed_normal = 10,
	      speed_run = 20,
	      walk_start = 1,
	      walk_end = 22,
	      stand_start = 1,
	      stand_end = 22,
	      run_start = 1,
	      run_end = 22,
	      punch_start = 22,
	      punch_end = 47,
	   },
		knock_back = 2,
	})

	--Thanks to Tenplus1
	if dmobs.destructive == true then
	mobs:register_arrow("dmobs:fire", {
	   visual = "sprite",
	   visual_size = {x = 0.5, y = 0.5},
	   textures = {"dmobs_fire.png"},
	   velocity = 8,
	   tail = 1, -- enable tail
	   tail_texture = "fire_basic_flame.png",

	   hit_player = function(self, player)
	      player:punch(self.object, 1.0, {
		 full_punch_interval = 1.0,
		 damage_groups = {fleshy = 8},
	      }, nil)
	   end,
	   
	   hit_mob = function(self, player)
	      player:punch(self.object, 1.0, {
		 full_punch_interval = 1.0,
		 damage_groups = {fleshy = 8},
	      }, nil)
	   end,

	   hit_node = function(self, pos, node)
	      mobs:explosion(pos, 2, 1, 1)
	   end,
	})
	else
	mobs:register_arrow("dmobs:fire", {
	   visual = "sprite",
	   visual_size = {x = 0.5, y = 0.5},
	   textures = {"dmobs_fire.png"},
	   velocity = 8,
	   tail = 1, -- enable tail
	   tail_texture = "fire_basic_flame.png",

	   hit_player = function(self, player)
	      player:punch(self.object, 1.0, {
		 full_punch_interval = 1.0,
		 damage_groups = {fleshy = 8},
	      }, nil)
	   end,
	   
	   hit_mob = function(self, player)
	      player:punch(self.object, 1.0, {
		 full_punch_interval = 1.0,
		 damage_groups = {fleshy = 8},
	      }, nil)
	   end,

	   hit_node = function(self, pos, node)
	      self.object:remove()
	   end,
	})
end


mobs:spawn_specific("dmobs:dragon", {"air"}, {"default:stone"}, 20, 10, 300, 15000, 2, -100, 11000)
   
mobs:register_egg("dmobs:dragon", "Dragon", "default_apple.png", 1)
end
