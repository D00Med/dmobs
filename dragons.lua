dmobs = {}

--thanks to diriel and blert2112

local step_custom = function(self, dtime)
	if self.driver then
		lib_mount.drive(self, dtime, "walk", "stand", true)
		return false
	end
	return true
end

local tamed_dragons = {}


local on_rc = function(self, clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if mobs:feed_tame(self, clicker, 1, false, false) then
		return
	end
	if self.tamed and self.owner == clicker:get_player_name() then
		local inv = clicker:get_inventory()
		if clicker:get_wielded_item():get_name() == "dmobs:dragon_armor_steel" then
				self.armor = true
				inv:remove_item("main", "dmobs:dragon_gem_fire")
			end
		if self.armor == true then 
			self.armor = false
			if inv:room_for_item("main", "dmobs:dragon_armor_steel") then
				inv:add_item("main", "dmobs:dragon_armor_steel")
			else
				minetest.add_item(clicker.getpos(), "dmobs:dragon_armor_steel")
			end
		end
		if self.driver and clicker == self.driver then
			-- detach
			lib_mount.detach(self, clicker, {x=1, y=0, z=1})
			if inv:room_for_item("main", "mobs:saddle") then
				inv:add_item("main", "mobs:saddle")
			else
				minetest.add_item(clicker.getpos(), "mobs:saddle")
			end
			self.object:setacceleration({x=0, y=0, z=0})
		elseif not self.driver then
			-- attach
			if clicker:get_wielded_item():get_name() == "mobs:saddle" then
				lib_mount.attach(self, clicker, {x=0, y=12, z=4}, {x=0, y=0, z=4})
				inv:remove_item("main", "mobs:saddle")
			end
		end
	end
end



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
   },
   blood_texture = "mobs_blood.png",
   visual_size = {x=2, y=2},
   makes_footstep_sound = true,
	runaway = false,
	jump_chance = 30,
	walk_chance = 80,
	fall_speed = 0,
	follow = {"dmobs:dragon_gem"},
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
      {name = "dmobs:egg", chance = 1, min = 1, max = 1},
      {name = "dmobs:dragon_gem", chance = 1, min = 1, max = 1},
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
	do_custom = step_custom,
	on_rightclick = on_rc
})

mobs:register_mob("dmobs:dragon2", {
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
   arrow = "dmobs:lightning",
   shoot_offset = 1,
   hp_min = 70,
   hp_max = 100,
   armor = 100,
	collisionbox = {-0.6, -1.2, -0.6, 0.6, 0.6, 0.6},
   visual = "mesh",
   mesh = "dragon.b3d",
   textures = {
	  {"dmobs_dragon2.png"},
   },
   blood_texture = "mobs_blood.png",
   visual_size = {x=2, y=2},
   makes_footstep_sound = true,
	runaway = false,
	jump_chance = 30,
	walk_chance = 80,
	fall_speed = 0,
	follow = {"dmobs:dragon_gem"},
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
      {name = "dmobs:egg", chance = 1, min = 1, max = 1},
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
	do_custom = step_custom,
	on_rightclick = on_rc
})

mobs:register_mob("dmobs:dragon3", {
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
   arrow = "dmobs:poison",
   shoot_offset = 1,
   hp_min = 70,
   hp_max = 100,
   armor = 100,
	collisionbox = {-0.6, -1.2, -0.6, 0.6, 0.6, 0.6},
   visual = "mesh",
   mesh = "dragon.b3d",
   textures = {
	  {"dmobs_dragon3.png"},
   },
   blood_texture = "mobs_blood.png",
   visual_size = {x=2, y=2},
   makes_footstep_sound = true,
	runaway = false,
	jump_chance = 30,
	walk_chance = 80,
	fall_speed = 0,
	follow = {"dmobs:dragon_gem"},
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
      {name = "dmobs:egg", chance = 1, min = 1, max = 1},
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
	do_custom = step_custom,
	on_rightclick = on_rc
})

mobs:register_mob("dmobs:dragon4", {
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
   arrow = "dmobs:ice",
   shoot_offset = 1,
   hp_min = 70,
   hp_max = 100,
   armor = 100,
	collisionbox = {-0.6, -1.2, -0.6, 0.6, 0.6, 0.6},
   visual = "mesh",
   mesh = "dragon.b3d",
   textures = {
	  {"dmobs_dragon4.png"},
   },
   blood_texture = "mobs_blood.png",
   visual_size = {x=2, y=2},
   makes_footstep_sound = true,
	runaway = false,
	jump_chance = 30,
	walk_chance = 80,
	fall_speed = 0,
	follow = {"dmobs:dragon_gem"},
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
      {name = "dmobs:egg", chance = 1, min = 1, max = 1},
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
	do_custom = step_custom,
	on_rightclick = on_rc
})

--hatched dragons
mobs:register_mob("dmobs:dragon_red", {
   type = "npc",
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
   hp_min = 80,
   hp_max = 100,
   armor = 100,
	collisionbox = {-0.6, -0.9, -0.6, 0.6, 0.6, 0.6},
   visual = "mesh",
   mesh = "dragon.b3d",
   textures = {
      {"dmobs_dragon.png"},
   },
	child_texture = {
		{"dmobs_dragon_young.png"}
	},
   blood_texture = "mobs_blood.png",
   visual_size = {x=1.5, y=1.5},
   makes_footstep_sound = true,
	runaway = false,
	jump_chance = 30,
	walk_chance = 80,
	fall_speed = 0,
	follow = {"dmobs:dragon_gem_fire"},
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
      {name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
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
	on_rightclick = function(self, clicker)
	if self.tamed and self.owner == clicker:get_player_name() then
		local inv = clicker:get_inventory()
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		if inv:room_for_item("main", "mobs:saddle") then
				inv:add_item("main", "mobs:saddle")
		else
				minetest.add_item(clicker.getpos(), "mobs:saddle")
		end
		elseif not self.driver then
		if clicker:get_wielded_item():get_name() == "mobs:saddle" then
		object_attach(self, clicker, {x=0, y=12, z=4}, {x=0, y=0, z=4})
		inv:remove_item("main", "mobs:saddle")
		end
		end
		end
	end,
	do_custom = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 10, true, "dmobs:fire_plyr", "walk", "stand")
		return false
		end
		return true
	end,
})

mobs:register_mob("dmobs:dragon_black", {
   type = "npc",
   passive = false,
   attacks_monsters = true,
   damage = 4,
   reach = 3,
   attack_type = "dogshoot",
   shoot_interval = 2.5,
	dogshoot_switch = 2,
	dogshoot_count = 0,
	dogshoot_count_max =5,
   arrow = "dmobs:lightning",
   shoot_offset = 1,
   hp_min = 80,
   hp_max = 100,
   armor = 100,
	collisionbox = {-0.6, -0.9, -0.6, 0.6, 0.6, 0.6},
   visual = "mesh",
   mesh = "dragon.b3d",
   textures = {
      {"dmobs_dragon2.png"},
   },
	child_texture = {
		{"dmobs_dragon_young.png"}
	},
   blood_texture = "mobs_blood.png",
   visual_size = {x=1.5, y=1.5},
   makes_footstep_sound = true,
	runaway = false,
	jump_chance = 30,
	walk_chance = 80,
	fall_speed = 0,
	follow = {"dmobs:dragon_gem_lightning"},
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
      {name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
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
	on_rightclick = function(self, clicker)
	if self.tamed and self.owner == clicker:get_player_name() then
		local inv = clicker:get_inventory()
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		if inv:room_for_item("main", "mobs:saddle") then
				inv:add_item("main", "mobs:saddle")
		else
				minetest.add_item(clicker.getpos(), "mobs:saddle")
		end
		elseif not self.driver then
		if clicker:get_wielded_item():get_name() == "mobs:saddle" then
		object_attach(self, clicker, {x=0, y=12, z=4}, {x=0, y=0, z=4})
		inv:remove_item("main", "mobs:saddle")
		end
		end
		end
	end,
	do_custom = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 15, true, "dmobs:lightning_plyr", "walk", "stand")
		return false
		end
		return true
	end,
})

mobs:register_mob("dmobs:dragon_green", {
   type = "npc",
   passive = false,
   attacks_monsters = true,
   damage = 4,
   reach = 3,
   attack_type = "dogshoot",
   shoot_interval = 2.5,
	dogshoot_switch = 2,
	dogshoot_count = 0,
	dogshoot_count_max =5,
   arrow = "dmobs:poison",
   shoot_offset = 1,
   hp_min = 80,
   hp_max = 100,
   armor = 100,
	collisionbox = {-0.6, -0.9, -0.6, 0.6, 0.6, 0.6},
   visual = "mesh",
   mesh = "dragon.b3d",
   textures = {
      {"dmobs_dragon3.png"},
   },
	child_texture = {
		{"dmobs_dragon_young.png"}
	},
   blood_texture = "mobs_blood.png",
   visual_size = {x=1.5, y=1.5},
   makes_footstep_sound = true,
	runaway = false,
	jump_chance = 30,
	walk_chance = 80,
	fall_speed = 0,
	follow = {"dmobs:dragon_gem_poison"},
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
      {name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
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
	on_rightclick = function(self, clicker)
	if self.tamed and self.owner == clicker:get_player_name() then
		local inv = clicker:get_inventory()
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		if inv:room_for_item("main", "mobs:saddle") then
				inv:add_item("main", "mobs:saddle")
		else
				minetest.add_item(clicker.getpos(), "mobs:saddle")
		end
		elseif not self.driver then
		if clicker:get_wielded_item():get_name() == "mobs:saddle" then
		object_attach(self, clicker, {x=0, y=12, z=4}, {x=0, y=0, z=4})
		inv:remove_item("main", "mobs:saddle")
		end
		end
		end
	end,
	do_custom = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 10, true, "dmobs:poison_plyr", "walk", "stand")
		return false
		end
		return true
	end,
})

mobs:register_mob("dmobs:dragon_blue", {
   type = "npc",
   passive = false,
   attacks_monsters = true,
   damage = 4,
   reach = 3,
   attack_type = "dogshoot",
   shoot_interval = 2.5,
	dogshoot_switch = 2,
	dogshoot_count = 0,
	dogshoot_count_max =5,
   arrow = "dmobs:ice",
   shoot_offset = 1,
   hp_min = 80,
   hp_max = 100,
   armor = 100,
	collisionbox = {-0.6, -0.9, -0.6, 0.6, 0.6, 0.6},
   visual = "mesh",
   mesh = "dragon.b3d",
   textures = {
      {"dmobs_dragon4.png"},
   },
	child_texture = {
		{"dmobs_dragon_young.png"}
	},
   blood_texture = "mobs_blood.png",
   visual_size = {x=1.5, y=1.5},
   makes_footstep_sound = true,
	runaway = false,
	jump_chance = 30,
	walk_chance = 80,
	fall_speed = 0,
	follow = {"dmobs:dragon_gem_ice"},
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
      {name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
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
	on_rightclick = function(self, clicker)
	if self.tamed and self.owner == clicker:get_player_name() then
		local inv = clicker:get_inventory()
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		if inv:room_for_item("main", "mobs:saddle") then
				inv:add_item("main", "mobs:saddle")
		else
				minetest.add_item(clicker.getpos(), "mobs:saddle")
		end
		elseif not self.driver then
		if clicker:get_wielded_item():get_name() == "mobs:saddle" then
		object_attach(self, clicker, {x=0, y=12, z=4}, {x=0, y=0, z=4})
		inv:remove_item("main", "mobs:saddle")
		end
		end
		end
	end,
	do_custom = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 10, true, "dmobs:ice_plyr", "walk", "stand")
		return false
		end
		return true
	end,
})




-- eggs from mobs_dragon 

minetest.register_node("dmobs:egg", {
	description = "Dragon Egg",
	drawtype = "mesh",
	mesh = "egg.b3d",
	tiles = {"dmobs_egg.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {fleshy=3, dig_immediate=3},
	sounds = default.node_sound_leaves_defaults(),
	on_rightclick = function(pos, node, clicker, item, _)
		local wield_item = clicker:get_wielded_item():get_name()
		if wield_item == "dmobs:dragon_gem" then
		
		local p = {x = pos.x, y = pos.y - 1, z = pos.z}
		local name1
		for x1 = -1,1 do
			for z1 = -1,1 do
				p.x = pos.x + x1
				p.z = pos.z + z1
				local name2 = minetest.get_node(p).name
				if x1 == -1 and z1 == -1 then
					name1 = minetest.get_node(p).name
				elseif x1 == 0 and z1 == 0 then
					if name2 ~= "default:obsidian" then return end
				else
					if name2 ~= name1 then return end
				end
			end
		end
		local which_dragon
		if name1 == "default:lava_source" then which_dragon = "red"
		elseif name1 == "default:obsidian" then which_dragon = "black"
		elseif name1 == "default:cactus" then which_dragon = "green"
		elseif name1 == "default:ice" then which_dragon = "blue"
		end
		minetest.after(100, function(pos, dragon, pname)
			if which_dragon == "red" then
			minetest.set_node(pos, {name="dmobs:dragon_egg_fire"})
			elseif which_dragon == "black" then
			minetest.set_node(pos, {name="dmobs:dragon_egg_lightning"})
			elseif which_dragon == "green" then
			minetest.set_node(pos, {name="dmobs:dragon_egg_poison"})
			elseif which_dragon == "blue" then
			minetest.set_node(pos, {name="dmobs:dragon_egg_ice"})
			end
		end, pos)
			item:take_item()
		else
	end
	end,
})


minetest.register_node("dmobs:dragon_egg_fire", {
	description = "Dragon Egg",
	drawtype = "mesh",
	mesh = "egg.b3d",
	tiles = {"dmobs_egg1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {fleshy=3, dig_immediate=3, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	on_rightclick = function(pos, node, clicker, item, _)
		local wield_item = clicker:get_wielded_item():get_name()
		if wield_item == "dmobs:dragon_gem_fire" then
		minetest.after(100, function(pos, dragon, pname)
			minetest.remove_node(pos)
			local ent = minetest.add_entity(pos, "dmobs:dragon_red")
			local obj = ent:get_luaentity()
			self.object:set_properties({
				textures = {"dmobs_dragon_young.png"},
				visual_size = {x=1, y=1},
			})
			obj.tamed = true
			obj.owner = clicker:get_player_name()
		end, pos, clicker:get_player_name())
		item:take_item()
	end
	end
})

minetest.register_node("dmobs:dragon_egg_lightning", {
	description = "Dragon Egg",
	drawtype = "mesh",
	mesh = "egg.b3d",
	tiles = {"dmobs_egg2.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {fleshy=3, dig_immediate=3, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	on_rightclick = function(pos, node, clicker, item, _)
		local pname = clicker:get_player_name()
		local wield_item = clicker:get_wielded_item():get_name()
		if wield_item == "dmobs:dragon_gem_lightning" then
		minetest.after(100, function(pos, dragon, pname)
			minetest.remove_node(pos)
			local ent = minetest.add_entity(pos, "dmobs:dragon_black")
			local obj = ent:get_luaentity()
			ent:set_properties({
				textures = {"dmobs_dragon_young.png"},
				visual_size = {x=1, y=1},
			})
			obj.tamed = true
			obj.owner = clicker:get_player_name()
		end, pos, clicker:get_player_name())
		item:take_item()
	end
	end
})

minetest.register_node("dmobs:dragon_egg_poison", {
	description = "Dragon Egg",
	drawtype = "mesh",
	mesh = "egg.b3d",
	tiles = {"dmobs_egg3.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {fleshy=3, dig_immediate=3, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	on_rightclick = function(pos, node, clicker, item, _)
		local wield_item = clicker:get_wielded_item():get_name()
		if wield_item == "dmobs:dragon_gem_poison" then
		minetest.after(100, function(pos, dragon, pname)
			minetest.remove_node(pos)
			local ent = minetest.add_entity(pos, "dmobs:dragon_green")
			local obj = ent:get_luaentity()
			obj:set_properties({
				textures = {"dmobs_dragon_young.png"},
				visual_size = {x=1, y=1},
			})
			obj.tamed = true
			obj.owner = clicker:get_player_name()
		end, pos, clicker:get_player_name())
		item:take_item()
	end
	end
})

minetest.register_node("dmobs:dragon_egg_ice", {
	description = "Dragon Egg",
	drawtype = "mesh",
	mesh = "egg.b3d",
	tiles = {"dmobs_egg4.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {fleshy=3, dig_immediate=3, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	on_rightclick = function(pos, node, clicker, item, _)
		local wield_item = clicker:get_wielded_item():get_name()
		if wield_item == "dmobs:dragon_gem_ice" then
		minetest.after(100, function(pos, dragon, pname)
			minetest.remove_node(pos)
			local ent = minetest.add_entity(pos, "dmobs:dragon_blue")
			local obj = ent:get_luaentity()
			obj:set_properties({
				textures = {"dmobs_dragon_young.png"},
				visual_size = {x=1, y=1},
			})
			obj.tamed = true
			obj.owner = clicker:get_player_name()
		end, pos, clicker:get_player_name())
		item:take_item()
	end
	end
})

minetest.register_node("dmobs:egg_great", {
	description = "Great Dragon Egg",
	drawtype = "mesh",
	mesh = "egg.b3d",
	tiles = {"dmobs_egg.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {fleshy=3, dig_immediate=3},
	sounds = default.node_sound_leaves_defaults(),
	on_rightclick = function(pos, node, clicker, item, _)
		local wield_item = clicker:get_wielded_item():get_name()
		if wield_item == "dmobs:dragon_gem" then
		minetest.after(100, function(pos, dragon, pname)
			minetest.remove_node(pos)
			local ent = minetest.add_entity(pos, "dmobs:dragon_great_tame")
			local obj = ent:get_luaentity()
			obj.tamed = true
			obj.owner = clicker:get_player_name()
		end, pos, clicker:get_player_name())
		item:take_item()
	end
	end
})


--saddle license

-- **mobs_saddle.png**
-- -------------------
-- The MIT License (MIT)

-- Copyright (c) 2014 Krupnov Pavel

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.


-- saddle (if not already available)
if not minetest.get_modpath("mobs_horse") then
	minetest.register_craftitem(":mobs:saddle", {
		description = "Saddle",
		inventory_image = "mobs_saddle.png"
	})

	minetest.register_craft({
		output = "mobs:saddle",
		recipe = {
			{"mobs:leather", "mobs:leather", "mobs:leather"},
			{"mobs:leather", "default:steel_ingot", "mobs:leather"},
			{"mobs:leather", "default:steel_ingot", "mobs:leather"}
		}
	})
end

--arrows

--Thanks to Tenplus1
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

--function to register tamed dragon attacks

function dmobs.register_fire(fname, texture, dmg, replace_node, explode)
minetest.register_entity(fname, {
	textures = {texture},
	velocity = 0.1,
	damage = dmg,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= fname and obj:get_luaentity().name ~= "dmobs:dragon_red" and obj:get_luaentity().name ~= "dmobs:dragon_blue" and obj:get_luaentity().name ~= "dmobs:dragon_black" and obj:get_luaentity().name ~= "dmobs:dragon_green" and obj:get_luaentity().name ~= "dmobs:dragon_great_tame" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=3},
						}, nil)
					self.object:remove()
					end
				end
			end
			for dx=0,1 do
						for dy=0,1 do
							for dz=0,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= fname and n ~="default:dirt_with_grass" and n ~="default:dirt_with_dry_grass" and n ~="default:stone"  then	
									if minetest.registered_nodes[n].groups.flammable --[[or math.random(1, 100) <= 1]] then
										minetest.env:set_node(t, {name=replace_node})
									self.object:remove()
									return
									end
								end
							end
						end
					end
			hit_node = function(self, pos, node)
			if explode then
				local pos = self.object:getpos()
				tnt.boom(pos, {damage_radius=5,radius=5,ignore_protection=false})
	else
--	local pos = self.object:getpos()
		for dx=-4,4 do
			for dy=-4,4 do
				for dz=-4,4 do
					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local n = minetest.env:get_node(pos).name
					if math.random(1, 50) <= 35 then
						minetest.env:remove_node(p)
					end
					if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <=5 then
										minetest.env:set_node(t, {name=replace_node})
					end
				end
			end
		end
		end
		end
		local apos = self.object:getpos()
		local part = minetest.add_particlespawner(
			6, --amount
			0.3, --time
			{x=apos.x-0.3, y=apos.y-0.3, z=apos.z-0.3}, --minpos
			{x=apos.x+0.3, y=apos.y+0.3, z=apos.z+0.3}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=0,y=-0.5,z=0}, --minacc
			{x=0.5,y=0.5,z=0.5}, --maxacc
			0.1, --minexptime
			0.3, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			texture --texture
		)
		
	end,
})
end

dmobs.register_fire("dmobs:fire_plyr", "dmobs_fire.png", 2, "fire:basic_flame", true)
dmobs.register_fire("dmobs:ice_plyr", "dmobs_ice.png", 2, "default:snow", false)
dmobs.register_fire("dmobs:poison_plyr", "dmobs_poison.png", 2, "air", false)
dmobs.register_fire("dmobs:lightning_plyr", "dmobs_lightning.png", 2, "air", true)



mobs:register_arrow("dmobs:ice", {
   visual = "sprite",
   visual_size = {x = 0.5, y = 0.5},
   textures = {"dmobs_ice.png"},
   velocity = 8,
   tail = 1, -- enable tail
   tail_texture = "dmobs_ice.png",

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

mobs:register_arrow("dmobs:lightning", {
   visual = "sprite",
   visual_size = {x = 0.5, y = 0.5},
   textures = {"dmobs_lightning.png"},
   velocity = 8,
   tail = 1, -- enable tail
   tail_texture = "dmobs_lightning.png",

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

mobs:register_arrow("dmobs:poison", {
   visual = "sprite",
   visual_size = {x = 0.5, y = 0.5},
   textures = {"dmobs_poison.png"},
   velocity = 8,
   tail = 1, -- enable tail
   tail_texture = "dmobs_poison.png",

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


--items and tools

minetest.register_craftitem("dmobs:dragon_gem_lightning", {
	description = "Lightning Gem",
	inventory_image = "dmobs_gem_lightning.png"
})
minetest.register_craftitem("dmobs:dragon_gem_ice", {
	description = "Ice Gem",
	inventory_image = "dmobs_gem_ice.png"
})
minetest.register_craftitem("dmobs:dragon_gem_fire", {
	description = "Fire Gem",
	inventory_image = "dmobs_gem_fire.png"
})
minetest.register_craftitem("dmobs:dragon_gem_poison", {
	description = "Poison Gem",
	inventory_image = "dmobs_gem_poison.png"
})

minetest.register_craftitem("dmobs:dragon_gem", {
	description = "Dragon Gem",
	inventory_image = "dmobs_gem.png"
})

-- minetest.register_craftitem("dmobs:dragon_armor_steel", {
	-- description = "Dragon Armor",
	-- inventory_image = "dmobs_dragon_armor_inv.png"
-- })

--spawns and eggs

mobs:spawn_specific("dmobs:dragon", {"air"}, {"default:stone"}, 20, 10, 300, 15000, 2, -100, 11000)
mobs:spawn_specific("dmobs:dragon2", {"air"}, {"default:stone"}, 20, 10, 300, 15000, 2, -100, 11000)
mobs:spawn_specific("dmobs:dragon3", {"air"}, {"default:stone"}, 20, 10, 300, 15000, 2, -100, 11000)
mobs:spawn_specific("dmobs:dragon4", {"air"}, {"default:stone"}, 20, 10, 300, 15000, 2, -100, 11000)
   
mobs:register_egg("dmobs:dragon", "Wild Fire Dragon", "default_apple.png", 1)
mobs:register_egg("dmobs:dragon2", "Wild Lightning Dragon", "default_mese_crystal.png", 1)
mobs:register_egg("dmobs:dragon3", "Wild Poison Dragon", "dmobs_poison.png", 1)
mobs:register_egg("dmobs:dragon4", "Wild Ice Dragon", "default_ice.png", 1)
mobs:register_egg("dmobs:dragon_red", "Tame Fire Dragon", "dmobs_egg.png", 1)

--other dragons

mobs:register_mob("dmobs:waterdragon", {
	type = "monster",
	passive = false,
	attack_type = "dogshoot",
	dogshoot_switch = 2,
	dogshoot_count = 0,
	dogshoot_count_max =5,
	shoot_interval = 2.5,
	arrow = "dmobs:ice",
	shoot_offset = 0,
	pathfinding = false,
	reach = 5,
	damage = 2,
	hp_min = 100,
	hp_max = 127,
	armor = 100,
	collisionbox = {-0.4, -0.5, -0.4, 0.4, 5, 0.4},
	visual_size = {x=4, y=4},
	visual = "mesh",
	mesh = "water_dragon.b3d",
	textures = {
		{"dmobs_waterdragon.png"},
	},
	blood_texture = "mobs_blood.png",
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_dirtmonster",
	},
	view_range = 15,
	rotate = 180,
	walk_velocity = 0.01,
	run_velocity = 0.01,
	jump = false,
	drops = {
		{name = "dmobs:dragon_gem_ice", chance = 1, min = 1, max = 1},
		{name = "dmobs:dragon_gem_fire", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	floats = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 1,
		stand_end = 20,
		walk_start = 1,
		walk_end = 20,
		run_start = 1,
		run_end = 20,
		punch_start = 40,
		punch_end = 60,
		shoot_start = 20,
		shoot_end = 40,
	},
	do_custom = function(self)
	--follow thanks to TenPlus1 and Byakuren
            if not self.hydra then
                self.hydra = true -- flip switch so this part is done only once

                -- get head position and define a few temp variables
                local pos = self.object:getpos()
                local obj, obj2, ent

                -- add body and make it follow head
                obj = minetest.add_entity({x=pos.x+1, y=pos.y, z=pos.z}, "dmobs:waterdragon_2")
                ent = obj:get_luaentity()
                ent.following = self.object

                -- add body and make it follow previous body segment
                obj2 = minetest.add_entity({x=pos.x-1, y=pos.y, z=pos.z}, "dmobs:waterdragon_2")
                ent = obj2:get_luaentity()
                ent.following = self.object
            end
    end,
})

mobs:register_mob("dmobs:waterdragon_2", {
	type = "monster",
	passive = false,
	attack_type = "shoot",
	dogshoot_switch = 2,
	dogshoot_count = 0,
	dogshoot_count_max =5,
	shoot_interval = 3,
	arrow = "dmobs:ice",
	shoot_offset = 0,
	pathfinding = false,
	reach = 5,
	damage = 2,
	hp_min = 50,
	hp_max = 60,
	armor = 50,
	collisionbox = {-0.4, -0.2, -0.4, 0.4, 5, 0.4},
	visual_size = {x=3, y=3},
	visual = "mesh",
	mesh = "water_dragon.b3d",
	textures = {
		{"dmobs_waterdragon.png"},
	},
	blood_texture = "mobs_blood.png",
	makes_footstep_sound = true,
   sounds = {
	  shoot_attack = "mobs_fireball",
	  random = "velociraptor",
   },
	view_range = 15,
	rotate = 180,
	floats = 0,
	walk_velocity = 0.01,
	run_velocity = 0.01,
	jump = false,
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 1,
		stand_end = 20,
		walk_start = 1,
		walk_end = 20,
		run_start = 1,
		run_end = 20,
		punch_start = 40,
		punch_end = 60,
		shoot_start = 20,
		shoot_end = 40,
	},
})

mobs:register_spawn("dmobs:waterdragon",
	{"default:water_source"}, 20, 10, 7000, 1, 31000, false)

mobs:register_egg("dmobs:waterdragon", "Boss Waterdragon", "dmobs_egg4.png", 1)

mobs:register_mob("dmobs:wyvern", {
   type = "monster",
   passive = false,
   attacks_monsters = false,
   damage = 4,
   reach = 3,
   attack_type = "dogshoot",
   shoot_interval = 2.5,
	dogshoot_switch = 2,
	dogshoot_count = 0,
	dogshoot_count_max =5,
   arrow = "dmobs:poison",
   shoot_offset = 0.5,
   hp_min = 100,
   hp_max = 150,
   armor = 100,
	collisionbox = {-0.6, -1.4, -0.6, 0.6, 0.6, 0.6},
   visual = "mesh",
   mesh = "wyvern.b3d",
   textures = {
      {"dmobs_wyvern.png"},
   },
   blood_texture = "mobs_blood.png",
   visual_size = {x=1, y=1},
   makes_footstep_sound = true,
	runaway = true,
	jump_chance = 30,
	walk_chance = 80,
	pathfinding = true,
   walk_velocity = 3,
   run_velocity = 5,
   fall_speed = -2,
   jump = true,
   fly = false,
   drops = {
      {name = "dmobs:dragon_gem_poison", chance = 1, min = 1, max = 1},
	  {name = "dmobs:dragon_gem_lightning", chance = 1, min = 1, max = 1},
   },
   sounds = {
	  shoot_attack = "mobs_fireball",
	  random = "velociraptor",
   },
   water_damage = 0,
   lava_damage = 2,
   light_damage = 0,
   view_range = 20,
   animation = {
      speed_normal = 20,
      speed_run = 30,
      walk_start = 33,
      walk_end = 68,
      stand_start = 1,
      stand_end = 30,
      run_start = 33,
      run_end = 68,
      punch_start = 70,
      punch_end = 89,
   },
	knock_back = 2,
})

mobs:register_spawn("dmobs:wyvern",
	{"default:leaves"}, 20, 10, 7000, 1, 31000, false)

mobs:register_egg("dmobs:wyvern", "Boss Wyvern", "dmobs_egg3.png", 1)

mobs:register_mob("dmobs:dragon_great", {
   type = "monster",
   passive = false,
   attacks_monsters = false,
   damage = 5,
   reach = 4,
   attack_type = "dogshoot",
   shoot_interval = 2.5,
	dogshoot_switch = 2,
	dogshoot_count = 0,
	dogshoot_count_max =5,
   arrow = "dmobs:lightning",
   shoot_offset = 1,
   hp_min = 140,
   hp_max = 180,
   armor = 220,
	collisionbox = {-0.6, -1.4, -0.6, 0.6, 0.6, 0.6},
   visual = "mesh",
   mesh = "dragon.b3d",
   textures = {
	  {"dmobs_dragon_great.png"},
   },
   blood_texture = "mobs_blood.png",
   visual_size = {x=2.5, y=2.5},
   makes_footstep_sound = true,
	runaway = false,
	jump_chance = 30,
	walk_chance = 80,
	fall_speed = 0,
	pathfinding = true,
	fall_damage = 0,
   sounds = {
      shoot_attack = "mobs_fireball",
	  random = "roar",
   },
   walk_velocity = 3,
   run_velocity = 5,
   jump = true,
   fly = true,
   drops = {
      {name = "dmobs:egg_great", chance = 1, min = 1, max = 1},
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

mobs:register_mob("dmobs:dragon_great_tame", {
   type = "npc",
   passive = false,
   attacks_monsters = true,
   damage = 5,
   reach = 4,
   attack_type = "dogshoot",
   shoot_interval = 2.5,
	dogshoot_switch = 2,
	dogshoot_count = 0,
	dogshoot_count_max =5,
   arrow = "dmobs:lightning",
   shoot_offset = 1,
   hp_min = 140,
   hp_max = 180,
   armor = 220,
	collisionbox = {-0.6, -1.4, -0.6, 0.6, 0.6, 0.6},
   visual = "mesh",
   mesh = "dragon.b3d",
   textures = {
	  {"dmobs_dragon_great.png"},
   },
   blood_texture = "mobs_blood.png",
   visual_size = {x=2.5, y=2.5},
   makes_footstep_sound = true,
	runaway = false,
	jump_chance = 30,
	walk_chance = 80,
	fall_speed = 0,
	pathfinding = true,
	fall_damage = 0,
   sounds = {
      shoot_attack = "mobs_fireball",
	  random = "roar",
   },
   walk_velocity = 3,
   run_velocity = 5,
   jump = true,
   fly = true,
   drops = {
      {name = "dmobs:egg_great", chance = 1, min = 1, max = 1},
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
	on_rightclick = function(self, clicker)
	if self.tamed and self.owner == clicker:get_player_name() then
		local inv = clicker:get_inventory()
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		if inv:room_for_item("main", "mobs:saddle") then
				inv:add_item("main", "mobs:saddle")
		else
				minetest.add_item(clicker.getpos(), "mobs:saddle")
		end
		elseif not self.driver then
		if clicker:get_wielded_item():get_name() == "mobs:saddle" then
		object_attach(self, clicker, {x=0, y=12, z=4}, {x=0, y=0, z=4})
		inv:remove_item("main", "mobs:saddle")
		end
		end
		end
	end,
	do_custom = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 10, true, "dmobs:fire_plyr", "walk", "stand")
		return false
		end
		return true
	end,
})

mobs:register_spawn("dmobs:dragon_great",
	{"default:lava_source"}, 20, 0, 7000, -21000, 1000, false)

mobs:register_egg("dmobs:dragon_great", "Boss Dragon", "dmobs_egg1.png", 1)
