--thanks to diriel, blert2112 and taikedz 

dmobs.dragon = {}

dofile(minetest.get_modpath("dmobs").."/dragons/piloting.lua")

local tamed_dragons = {}

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

