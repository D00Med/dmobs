--vehicles/mounts api by D00Med, based on lib_mount(see below)

--License of lib_mount:
-- Minetest mod: lib_mount
-- =======================
-- by blert2112

-- Based on the Boats mod by PilzAdam.


-- -----------------------------------------------------------
-- -----------------------------------------------------------


-- Minetest Game mod: boats
-- ========================
-- by PilzAdam

-- License of source code:
-- -----------------------
-- WTFPL


--from lib_mount (required by new functions)


local mobs_redo = false
if mobs.mod and mobs.mod == "redo" then
	mobs_redo = true
end

local function is_group(pos, group)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, group) ~= 0
end

local function force_detach(player)
	local attached_to = player:get_attach()
	if attached_to and attached_to:get_luaentity() then
		local entity = attached_to:get_luaentity()
		if entity.driver then
			entity.driver = nil
		end
		player:set_detach()
	end
	default.player_attached[player:get_player_name()] = false
	player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
end

function object_attach(entity, player, attach_at, eye_offset)
	eye_offset = eye_offset or {x=0, y=0, z=0}
	force_detach(player)
	entity.driver = player
	player:set_attach(entity.object, "", attach_at, {x=0, y=0, z=0})
	
	player:set_properties({visual_size = {x=1, y=1}})
	
	player:set_eye_offset(eye_offset, {x=0, y=0, z=0})
	default.player_attached[player:get_player_name()] = true
	minetest.after(0.2, function()
		default.player_set_animation(player, "sit" , 30)
	end)
	entity.object:setyaw(player:get_look_yaw() - math.pi / 2)
end

function object_detach(entity, player, offset)
	entity.driver = nil
	player:set_detach()
	default.player_attached[player:get_player_name()] = false
	default.player_set_animation(player, "stand" , 30)
	player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
	local pos = player:getpos()
	pos = {x = pos.x + offset.x, y = pos.y + 0.2 + offset.y, z = pos.z + offset.z}
	minetest.after(0.1, function()
		player:setpos(pos)
	end)
end
-------------------------------------------------------------------------------


minetest.register_on_leaveplayer(function(player)
	force_detach(player)
end)

minetest.register_on_shutdown(function()
    local players = minetest.get_connected_players()
	for i = 1,#players do
		force_detach(players[i])
	end
end)

minetest.register_on_dieplayer(function(player)
	force_detach(player)
	return true
end)

-------------------------------------------------------------------------------

--mixed code(from this mod and lib_mount)

function object_drive(entity, dtime, speed, shoots, arrow, moving_anim, stand_anim, jumps)
	local ctrl = entity.driver:get_player_control()
	local dir = entity.driver:get_look_dir();
	local vec_forward = {x=dir.x*speed,y=-2,z=dir.z*speed}
	local vec_backward = {x=-dir.x*speed,y=-2,z=-dir.z*speed}
	local vec_stop = {x=0,y=0,z=0}
	local yaw = entity.driver:get_look_yaw();
	if ctrl.up then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_forward)
	elseif ctrl.down then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_backward)
	elseif not ctrl.down or ctrl.up then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_stop)
	end
	if ctrl.sneak and ctrl.LMB and shoots then
			local pos = entity.object:getpos()
			local obj = minetest.env:add_entity({x=pos.x+0+dir.x*2,y=pos.y+1.5+dir.y,z=pos.z+0+dir.z*2}, arrow)
			local vec = {x=dir.x*6,y=dir.y*6,z=dir.z*6}
			local yaw = entity.driver:get_look_yaw();
			obj:setyaw(yaw+math.pi/2)
			obj:setvelocity(vec)
	end
	--lib_mount animation
	local velo = entity.object:getvelocity()
	if velo.x == 0 and velo.y == 0 and velo.z == 0 then
		if stand_anim and stand_anim ~= nil and mobs_redo == true then
			set_animation(entity, stand_anim)
		end
		entity.object:setpos(entity.object:getpos())
		return
	end
	if moving_anim and moving_anim ~= nil and mobs_redo == true then
		set_animation(entity, moving_anim)
	end
	--jumping not working
	-- local jumps = jumps or false
	-- if jumps == true and ctrl.jump then
		-- local xvel = entity.object:getvelocity().x
		-- local zvel = entity.object:getvelocity().z
		-- local yvel = entity.object:getvelocity().y
		-- local vel = {x=xvel,y=10,z=zvel}
		-- entity.object:setvelocity(vel)
		-- minetest.after(1.5, function()
		-- local xvel = entity.object:getvelocity().x
		-- local zvel = entity.object:getvelocity().z
		-- local yvel = entity.object:getvelocity().y
		-- local vel = {x=xvel,y=-10,z=zvel}
		-- entity.object:setvelocity(vel)
		-- end)
	-- end
end

function object_fly(entity, dtime, speed, shoots, arrow, moving_anim, stand_anim)
	local ctrl = entity.driver:get_player_control()
	local velo = entity.object:getvelocity()
	local dir = entity.driver:get_look_dir();
	local vec_forward = {x=dir.x*speed,y=dir.y*speed+2,z=dir.z*speed}
	local vec_backward = {x=-dir.x*speed,y=dir.y*speed+2,z=-dir.z*speed}
	local vec_rise = {x=velo.x,y=velo.y+0.2,z=velo.z}
	local vec_stop = {x=0,y=-0.2,z=0}
	local yaw = entity.driver:get_look_yaw();
	local pos = entity.object:getpos()
	local node = minetest.get_node(pos).name
	if node == "default:water_source" or node == "default:river_water_source" or node == "default:river_water_flowing" or node == "default:water_flowing" then
		entity.object:setvelocity({x=velo.x*0.9, y=-1, z=velo.z*0.9})
	elseif ctrl.up then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_forward)
	elseif ctrl.down then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_backward)
	elseif ctrl.jump then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_rise)
	elseif not ctrl.down or ctrl.up or ctrl.jump then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_stop)
	end
	if ctrl.aux1 and shoots and not entity.loaded then
			local pos = entity.object:getpos()
			local obj = minetest.env:add_entity({x=pos.x+0+dir.x*2.5,y=pos.y+1.5+dir.y,z=pos.z+0+dir.z*2.5}, arrow)
			local vec = {x=dir.x*12,y=dir.y*12,z=dir.z*12}
			local yaw = entity.driver:get_look_yaw();
			entity.loaded = true
			obj:setyaw(yaw+math.pi/2)
			obj:setvelocity(vec)
			local object = obj:get_luaentity()
			object.launcher = entity.driver
			minetest.after(1, function()
			entity.loaded = false
			end)
	end
	--lib_mount animation
	if velo.x == 0 and velo.y == 0 and velo.z == 0 then
		if stand_anim and stand_anim ~= nil and mobs_redo == true then
			set_animation(entity, stand_anim)
		end
		entity.object:setpos(entity.object:getpos())
		return
	end
	if moving_anim and moving_anim ~= nil and mobs_redo == true then
		set_animation(entity, moving_anim)
	end
end

--lib_mount (not required by new functions)


local function is_group(pos, group)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, group) ~= 0
end

local function get_sign(i)
	i = i or 0
	if i == 0 then
		return 0
	else
		return i / math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = -math.sin(yaw) * v
	local z =  math.cos(yaw) * v
	return {x = x, y = y, z = z}
end

local function get_v(v)
	return math.sqrt(v.x ^ 2 + v.z ^ 2)
end

lib_mount = {}

function lib_mount.attach(entity, player, attach_at, eye_offset)
	eye_offset = eye_offset or {x=0, y=0, z=0}
	force_detach(player)
	entity.driver = player
	player:set_attach(entity.object, "", attach_at, {x=0, y=0, z=0})
	
	player:set_properties({visual_size = {x=1, y=1}})
	
	player:set_eye_offset(eye_offset, {x=0, y=0, z=0})
	default.player_attached[player:get_player_name()] = true
	minetest.after(0.2, function()
		default.player_set_animation(player, "sit" , 30)
	end)
	entity.object:setyaw(player:get_look_yaw() - math.pi / 2)
end

function lib_mount.detach(entity, player, offset)
	if entity ~= nil then entity.driver = nil end
	player:set_detach()
	default.player_attached[player:get_player_name()] = false
	default.player_set_animation(player, "stand" , 30)
	player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
	local pos = player:getpos()
	pos = {x = pos.x + offset.x, y = pos.y + 0.2 + offset.y, z = pos.z + offset.z}
	minetest.after(0.1, function()
		player:setpos(pos)
	end)
end

function lib_mount.drive(entity, dtime, moving_anim, stand_anim, can_fly)
	entity.v = get_v(entity.object:getvelocity()) * get_sign(entity.v)
	
	local ctrl = entity.driver:get_player_control()
	local yaw = entity.object:getyaw()
	if ctrl.up then
		entity.v = entity.v + 0.1
	elseif ctrl.down then
		entity.v = entity.v - 0.1
	end
	if ctrl.left then
		if entity.v < 0 then
			entity.object:setyaw(yaw - (1 + dtime) * 0.03)
		else
			entity.object:setyaw(yaw + (1 + dtime) * 0.03)
		end
	elseif ctrl.right then
		if entity.v < 0 then
			entity.object:setyaw(yaw + (1 + dtime) * 0.03)
		else
			entity.object:setyaw(yaw - (1 + dtime) * 0.03)
		end
	end
	
	local velo = entity.object:getvelocity()
	if entity.v == 0 and velo.x == 0 and velo.y == 0 and velo.z == 0 then
		if stand_anim and stand_anim ~= nil and mobs_redo == true then
			set_animation(entity, stand_anim)
		end
		entity.object:setpos(entity.object:getpos())
		return
	end
	if moving_anim and moving_anim ~= nil and mobs_redo == true then
		set_animation(entity, moving_anim)
	end
	local s = get_sign(entity.v)
	entity.v = entity.v - 0.02 * s
	if s ~= get_sign(entity.v) then
		entity.object:setvelocity({x = 0, y = 0, z = 0})
		entity.v = 0
		return
	end
	if math.abs(entity.v) > 5 then
		entity.v = 5 * get_sign(entity.v)
	end

	local p = entity.object:getpos()
	p.y = p.y - 0.5
	local new_velo = {x = 0, y = 0, z = 0}
	local new_acce = {x = 0, y = 0, z = 0}
	if not is_group(p, "crumbly") then
		local nodedef = minetest.registered_nodes[minetest.get_node(p).name]
		if (not nodedef) or nodedef.walkable then
			entity.v = 0
			new_acce = {x = 0, y = 1, z = 0}
		else
			new_acce = {x = 0, y = -9.8, z = 0}
		end
		new_velo = get_velocity(entity.v, entity.object:getyaw(),
			entity.object:getvelocity().y)
		entity.object:setpos(entity.object:getpos())
	else
		p.y = p.y + 1
		if is_group(p, "crumbly") then
			local y = entity.object:getvelocity().y
			if y >= 5 then
				y = 5
			elseif y < 0 then
				new_acce = {x = 0, y = 20, z = 0}
			else
				new_acce = {x = 0, y = 5, z = 0}
			end
			new_velo = get_velocity(entity.v, entity.object:getyaw(), y)
			entity.object:setpos(entity.object:getpos())
		else
			new_acce = {x = 0, y = 0, z = 0}
			if math.abs(entity.object:getvelocity().y) < 1 then
				local pos = entity.object:getpos()
				pos.y = math.floor(pos.y) + 0.5
				entity.object:setpos(pos)
				new_velo = get_velocity(entity.v, entity.object:getyaw(), 0)
			else
				new_velo = get_velocity(entity.v, entity.object:getyaw(),
					entity.object:getvelocity().y)
				entity.object:setpos(entity.object:getpos())
			end
		end
	end
	if can_fly and can_fly == true and ctrl.jump then 
		new_velo.y = new_velo.y + 0.75
	end
	entity.object:setvelocity(new_velo)
	entity.object:setacceleration(new_acce)
end
