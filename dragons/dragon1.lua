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
	on_rightclick = dmobs.dragon.on_rc
})

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
		if self.state == "attack" then
		self.state = "idle"
		end
		return false
		end
		return true
	end,
})
