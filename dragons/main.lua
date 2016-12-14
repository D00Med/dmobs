--thanks to diriel, blert2112 and taikedz 

dmobs.dragon = {}

dmobs.dragon.step_custom = function(self, dtime)
	if self.driver then
		lib_mount.drive(self, dtime, "walk", "stand", true)
		if self.state == "attack" then
			self.state = nil
		end
		return false
	end
	return true
end

local tamed_dragons = {}

dmobs.dragon.ride = function(self, clicker)
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
end


dmobs.dragon.on_rc = function(self, clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if mobs:feed_tame(self, clicker, 1, false, false) then
		return
	end
	dmobs.dragon.ride(self, clicker)
end

dmobs.dragon.do_custom = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 10, true, "dmobs:fire_plyr", "walk", "stand")
		
		if self.state == "attack" then
			self.state = "idle"
		end
		
		return false
	end
	return true
end


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


--spawns and eggs

-- mobs:spawn_specific("dmobs:dragon", {"air"}, {"default:stone"}, 20, 10, 300, 15000, 2, -100, 11000)
-- mobs:spawn_specific("dmobs:dragon2", {"air"}, {"default:stone"}, 20, 10, 300, 15000, 2, -100, 11000)
-- mobs:spawn_specific("dmobs:dragon3", {"air"}, {"default:stone"}, 20, 10, 300, 15000, 2, -100, 11000)
-- mobs:spawn_specific("dmobs:dragon4", {"air"}, {"default:stone"}, 20, 10, 300, 15000, 2, -100, 11000)

   
mobs:register_egg("dmobs:dragon", "Wild Fire Dragon", "default_apple.png", 1)
mobs:register_egg("dmobs:dragon2", "Wild Lightning Dragon", "default_mese_crystal.png", 1)
mobs:register_egg("dmobs:dragon3", "Wild Poison Dragon", "dmobs_poison.png", 1)
mobs:register_egg("dmobs:dragon4", "Wild Ice Dragon", "default_ice.png", 1)

mobs:register_egg("dmobs:dragon_red", "Tame Fire Dragon", "default_apple.png", 1)
mobs:register_egg("dmobs:dragon_black", "Tame Lightning Dragon", "default_mese_crystal.png", 1)
mobs:register_egg("dmobs:dragon_green", "Tame Poison Dragon", "dmobs_poison.png", 1)
mobs:register_egg("dmobs:dragon_blue", "Tame Ice Dragon", "default_ice.png", 1)

