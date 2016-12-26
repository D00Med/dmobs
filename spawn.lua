if dmobs.regulars then
	-- friendlies

	mobs:register_spawn("dmobs:nyan", {"default:pine_needles","default:leaves"}, 20, 10, 50000, 2, 31000)
	mobs:register_spawn("dmobs:nyan", {"nyanland:meseleaves"}, 20, 10, 15000, 2, 31000)

	mobs:register_spawn("dmobs:hedgehog", {"default:dirt_with_grass","default:pine_needles"}, 20, 10, 15000, 2, 31000)
	mobs:register_spawn("dmobs:whale", {"default:water_source"}, 20, 10, 15000, -20, 1000)
	mobs:register_spawn("dmobs:owl", {"default:leaves","default:tree"}, 20, 10, 15000, 2, 31000)
	mobs:register_spawn("dmobs:gnorm", {"default:dirt_with_grass","default:wood"}, 20, 10, 32000, 2, 31000)
	mobs:register_spawn("dmobs:tortoise", {"default:clay","default:sand"}, 20, 10, 15000, 2, 31000)
	mobs:register_spawn("dmobs:elephant", {"default:dirt_with_dry_grass","default:desert_sand"}, 20, 10, 15000, 2, 31000)
	mobs:register_spawn("dmobs:badger", {"default:dirt_with_grass","default:dirt"}, 20, 10, 15000, 2, 31000)
	mobs:register_spawn("dmobs:pig", {"default:pine_needles","default:leaves", "nyanland:cloudstone"}, 20, 10, 32000, 2, 31000)
	mobs:register_spawn("dmobs:panda", {"default:dirt_with_grass","ethereal:bamboo_dirt"}, 20, 10, 15000, 2, 31000)

	-- baddies

	mobs:register_spawn("dmobs:wasp", {"default:dirt_with_grass"}, 20, 10, 32000, 2, 31000)
	mobs:register_spawn("dmobs:wasp", {"dmobs:hive"}, 20, 10, 16000, 2, 31000)
	mobs:register_spawn("dmobs:wasp_leader", {"default:dirt_with_grass","dmobs:hive"}, 20, 10, 64000, 2, 31000)

	mobs:register_spawn("dmobs:golem", {"default:stone"}, 7, 0, 16000, 2, 31000)
	mobs:register_spawn("dmobs:pig_evil", {"default:pine_needles","default:leaves"}, 20, 10, 32000, 2, 31000)
	mobs:register_spawn("dmobs:fox", {"default:dirt_with_grass","default:dirt"}, 20, 10, 32000, 2, 31000)

	if not dmobs.dragons then
		mobs:register_spawn("dmobs:orc", {"default:snow","default:snow_block", "default:desert_sand"}, 20, 10, 15000, 2, 31000)
		mobs:register_spawn("dmobs:ogre", {"default:snow","default:dirt_with_dry_grass", "default:desert_sand"}, 20, 10, 15000, 2, 31000)
	else
		mobs:register_spawn("dmobs:orc", {"default:snow","default:snow_block", "default:desert_sand"}, 20, 10, 3500, 2, 31000)
		mobs:register_spawn("dmobs:ogre", {"default:snow","default:dirt_with_dry_grass", "default:desert_sand"}, 20, 10, 350, 2, 31000)
	end


	mobs:register_spawn("dmobs:rat", {"default:stone","default:sand"}, 20, 0, 32000, 2, 31000)
	mobs:register_spawn("dmobs:treeman", {"default:leaves", "default:pine_needles"}, 7, 0, 16000, 2, 31000)
	mobs:register_spawn("dmobs:skeleton", {"default:stone"}, 7, 0, 16000, 2, 31000)
end

-- dragons

mobs:register_spawn("dmobs:dragon", {"default:leaves","default:dirt_with_grass"}, 20, 10, 64000, 2, 31000)

if dmobs.dragons then
	mobs:register_spawn("dmobs:dragon2", {"default:pine_needles"}, 20, 10, 64000, 2, 31000)
	mobs:register_spawn("dmobs:dragon3", {"default:acacia_leaves","default:dirt_with_dry_grass"}, 20, 10, 64000, 2, 31000)
	mobs:register_spawn("dmobs:dragon4", {"default:jungleleaves"}, 20, 10, 64000, 2, 31000)
	mobs:register_spawn("dmobs:waterdragon", {"default:water_source"}, 20, 10, 32000, 1, 31000, false)
	mobs:register_spawn("dmobs:wyvern",	{"default:leaves"}, 20, 10, 32000, 1, 31000, false)
	mobs:register_spawn("dmobs:dragon_great", {"default:lava_source"}, 20, 0, 64000, -21000, 1000, false)
end
