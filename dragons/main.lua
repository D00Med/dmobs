--thanks to diriel, blert2112 and taikedz 

dmobs.dragon = {}

local step_custom = function(self, dtime)
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
	dmobs.dragon.ride(self,clicker)
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

-- eggs from mobs_dragon --------------------------------------------------------------------------

local function egg_transform(pos, node, clicker, item, _)
	local wield_item = clicker:get_wielded_item():get_name()
	if wield_item == "dmobs:dragon_gem" then
	
		local p = {x = pos.x, y = pos.y - 1, z = pos.z}
		local corner_name
		for x1 = -1,1 do
			for z1 = -1,1 do
				p.x = pos.x + x1
				p.z = pos.z + z1
				local nestfloor_name = minetest.get_node(p).name

				if x1 == -1 and z1 == -1 then
					corner_name = minetest.get_node(p).name

				elseif x1 == 0 and z1 == 0 then -- special case in centre
					-- must be obsidian
					if nestfloor_name ~= "default:obsidian" then return end

				else
					-- else ring must all be of the same type
					if nestfloor_name ~= corner_name then return end
				end
			end
		end
		
		local dragon_type
		if corner_name == "default:lava_source" then
			dragon_type = "fire"
			
		elseif corner_name == "default:obsidian" then
			dragon_type = "lightning"
			
		elseif corner_name == "default:cactus" then
			dragon_type = "poison"

		elseif corner_name == "default:ice" then
			dragon_type = "ice"
		end
		
		minetest.chat_send_player(clicker:get_player_name()," ... something seems to be happening .... come back later?")
		
		minetest.after(100,
			function(pos, dragon, pname)
				minetest.set_node(pos, {name="dmobs:dragon_egg_"..dragon_type})
			end,
			pos
		)
		
		item:take_item()
	end
end
	
local dragonpairs = {
	fire = "red",
	lightning = "black",
	poison = "green",
	ice = "black",
	great = "great",
}

local function egghatch(pos, node, clicker, item, _)
	local wield_item = clicker:get_wielded_item():get_name()
	local eggnode = minetest.get_node(pos).name
	
	for nature,colour in pairs(dragonpairs) do
		if ( wield_item == "dmobs:dragon_gem_"..nature and eggnode:find(nature) ) or
		   ( wield_item == "dmobs:dragon_gem" and eggnode == "dmobs:dragon_egg_great" ) then -- special case... because inconsiderate/inconsistent naming
		   
		   	minetest.chat_send_player(clicker:get_player_name(), " ... let the hatching... begin...")
		   	
			minetest.after(100,
				function(pos, dragon, pname)
					local neweggnode = minetest.get_node(pos).name
					if eggnode ~= neweggnode then return end -- prevent infinite hatchings

					minetest.remove_node(pos)
					local ent = minetest.add_entity(pos, "dmobs:dragon_"..colour )
					minetest.sound_play("dmobs_chirrup",{pos=pos,max_hear_distance=20})
					
					local obj = ent:get_luaentity()
					ent:set_properties({
						textures = {"dmobs_dragon_young.png"},
						visual_size = {x=1, y=1},
					})
					obj.tamed = true
					obj.owner = clicker:get_player_name()
				end,
				pos, clicker:get_player_name()
			)
			item:take_item()
		end
	end -- for loop
end

local base_egg = { -- base template for all dragon eggs
	description = "Dragon Egg",
	drawtype = "mesh",
	mesh = "egg.b3d",
	tiles = {"dmobs_egg.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {fleshy=3, dig_immediate=3},
	sounds = default.node_sound_leaves_defaults(),	
	on_rightclick = egg_transform,
}


minetest.register_node("dmobs:egg", dmobs.deepclone(base_egg) ) -- clone, to not affect the base template

base_egg.groups.not_in_creative_inventory=1
base_egg.on_rightclick = egghatch

base_egg.tiles = {"dmobs_egg1.png"}
minetest.register_node("dmobs:dragon_egg_fire", dmobs.deepclone(base_egg) )

base_egg.tiles = {"dmobs_egg2.png"}
minetest.register_node("dmobs:dragon_egg_lightning", dmobs.deepclone(base_egg) )

base_egg.tiles = {"dmobs_egg3.png"}
minetest.register_node("dmobs:dragon_egg_poison", dmobs.deepclone(base_egg) )

base_egg.tiles = {"dmobs_egg4.png"}
minetest.register_node("dmobs:dragon_egg_ice", dmobs.deepclone(base_egg) )

base_egg.groups.not_in_creative_inventory=nil
--base_egg.tiles = {"dmobs_dragon_egg_great.png"}
base_egg.tiles = {"dmobs_fire.png"}
base_egg.description = "Great Dragon Egg"
minetest.register_node("dmobs:dragon_egg_great", dmobs.deepclone(base_egg) )


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

