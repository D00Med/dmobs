
--butterflies

minetest.register_abm({
	nodenames = {"flowers:flower_rose", "flowers:flower_tulip", "flowers:flower_dandelion_yellow", "flowers:flower_viola", "flowers:flower_dandelion_white", "flowers:flower_geranium"},
	interval = 10.0,
	chance = 10,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.env:add_entity({x=pos.x,y=pos.y+0.3,z=pos.z}, "dmobs:butterfly")
	end
})

minetest.register_entity("dmobs:butterfly", {
	visual = "mesh",
	mesh = "butterfly.b3d",
	physical = true,
	textures = {"dmobs_butterfly.png",},
	visual_size = {x=0.3, y=0.3},
	on_activate = function(self)
		num = math.random(1,4)
		self.object:set_properties({textures = {"dmobs_butterfly"..num..".png",},})
		self.object:set_animation({x=1, y=10}, 20, 0)
		self.object:setyaw(math.pi+num)
		minetest.after(10, function()
		self.object:remove()
		end)
	end,
	on_step = function(self)
		local pos = self.object:getpos()
		local vec = self.object:getvelocity()
		local num = math.random(-math.pi, math.pi)
		self.object:setyaw(math.pi+num)
		self.object:setvelocity({x=-math.sin(12*pos.y), y=math.cos(12*pos.x), z=-math.sin(12*pos.y)})
		self.object:setacceleration({x=-math.sin(6*vec.y), y=math.cos(6*vec.x), z=-math.sin(6*vec.y)})
	end,
	collisionbox = {0,0,0,0,0.1,0},
})
