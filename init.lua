dmobs = {}

-- dmobs by D00Med

-- mounts api by D00Med and lib_mount api by blert2112

dofile(minetest.get_modpath("dmobs").."/api.lua")

-- Enable dragons (disable to remove tamed dragons and dragon bosses)
dmobs.dragons = minetest.setting_get_bool("dmobs.dragons") or true

-- Enable fireballs/explosions
dmobs.destructive = minetest.setting_get_bool("dmobs.destructive") or false


dofile(minetest.get_modpath("dmobs").."/nodes.lua")

dofile(minetest.get_modpath("dmobs").."/arrows/sting.lua")

local function loadmob(mobname,dir)
	dir = dir or "/mobs/"
	dofile(minetest.get_modpath("dmobs")..dir..mobname..".lua")
end

-- regular mobs

local mobslist = {
	-- friendlies
	"pig",
	"panda",
	"tortoise",
	"golem_friendly",
	"nyan",
	"gnorm",
	"hedgehog",
	"owl",
	"whale",
	"badger",
	"butterfly",
	
	-- baddies
	"pig_evil",
	"fox",
	"rat",
	"wasps",
	"treeman",
	"golem",
	"skeleton",
	"orc",
	"ogre",
}

for _,mobname in pairs(mobslist) do
	loadmob(mobname)
end

-- dragons!!


if dmobs.destructive == true then
	dofile(minetest.get_modpath("dmobs").."/arrows/fire_explosive.lua")
else
	dofile(minetest.get_modpath("dmobs").."/arrows/fire.lua")
end

if dmobs.dragons then
	loadmob("dragon_normal","/dragons/")
else
	loadmob("main","/dragons/")
	loadmob("dragon1","/dragons/")
	loadmob("dragon2","/dragons/")
	loadmob("dragon3","/dragons/")
	loadmob("dragon4","/dragons/")
end
