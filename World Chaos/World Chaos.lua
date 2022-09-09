--- Author: Rostal
--- Last edit date: 2022/9/9
---
util.require_natives("1660775568")
util.keep_running()

local function IS_PED_PLAYER(Ped)
    if PED.GET_PED_TYPE(Ped) >= 4 then
        return false
    else
        return true
    end
end

local function IS_PLAYER_VEHICLE(Vehicle)
    if Vehicle == entities.get_user_vehicle_as_handle() or Vehicle == entities.get_user_personal_vehicle_as_handle() then
        return true
    elseif not VEHICLE.IS_VEHICLE_SEAT_FREE(Vehicle, -1, false) then
        local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(Vehicle, -1)
        if ped then
            if IS_PED_PLAYER(ped) then
                return true
            end
        end
    end
    return false
end

local function REQUEST_CONTROL_ENTITY(ent, tick)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) then
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        for i = 1, tick do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) then
                return true
            end
        end
    end
    return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent)
end

local function GET_NEARBY_VEHICLES(p, radius)
    local vehicles = {}
    local pos = ENTITY.GET_ENTITY_COORDS(p)
    for k, veh in pairs(entities.get_all_vehicles_as_handles()) do
        if radius == 0 then
            table.insert(vehicles, veh)
        else
            local veh_pos = ENTITY.GET_ENTITY_COORDS(veh)
            local distance = v3.distance(v3(pos), v3(veh_pos))
            if distance <= radius then
                table.insert(vehicles, veh)
            end
        end
    end
    return vehicles
end

local function GET_NEARBY_PEDS(p, radius)
    local peds = {}
    local pos = ENTITY.GET_ENTITY_COORDS(p)
    for k, ped in pairs(entities.get_all_peds_as_handles()) do
        if radius == 0 then
            table.insert(peds, ped)
        else
            local ped_pos = ENTITY.GET_ENTITY_COORDS(ped)
            local distance = v3.distance(v3(pos), v3(ped_pos))
            if distance <= radius then
                table.insert(peds, ped)
            end
        end
    end
    return peds
end

local function GET_NEARBY_OBJECTS(p, radius)
    local objects = {}
    local pos = ENTITY.GET_ENTITY_COORDS(p)
    for k, obj in pairs(entities.get_all_objects_as_handles()) do
        if radius == 0 then
            table.insert(objects, obj)
        else
            local obj_pos = ENTITY.GET_ENTITY_COORDS(obj)
            local distance = v3.distance(v3(pos), v3(obj_pos))
            if distance <= radius then
                table.insert(objects, obj)
            end
        end
    end
    return objects
end

local menuRoot = menu.my_root()
menu.divider(menuRoot, "混乱世界")

local world_chaos_setting = {
    chaos_radius = 100,
    vehicle_toggle = true,
    ped_toggle = true,
    object_toggle = false,
    forward_speed = 30,
    forward_degree = 30,
    has_gravity = true,
    time_delay = 100,
    exclude_mission = false,
    exclude_dead = false
}

menu.toggle_loop(menuRoot, "开启", { "world_chaos" }, "", function()
    -- Vehicle
    if world_chaos_setting.vehicle_toggle then
        for _, ent in pairs(GET_NEARBY_VEHICLES(players.user_ped(), world_chaos_setting.chaos_radius)) do
            if not IS_PLAYER_VEHICLE(ent) then
                if world_chaos_setting.exclude_mission and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                elseif world_chaos_setting.exclude_dead and ENTITY.IS_ENTITY_DEAD(ent) then
                else
                    REQUEST_CONTROL_ENTITY(ent, 10)
                    VEHICLE._SET_VEHICLE_MAX_SPEED(ent, 99999.0)
                    ENTITY.FREEZE_ENTITY_POSITION(ent, false)
                    VEHICLE.SET_VEHICLE_FORWARD_SPEED(ent, world_chaos_setting.forward_speed)
                    VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(ent, false, false)
                    VEHICLE.SET_VEHICLE_GRAVITY(ent, world_chaos_setting.has_gravity)
                end
            end
        end
    end
    -- Ped
    if world_chaos_setting.ped_toggle then
        for _, ent in pairs(GET_NEARBY_PEDS(players.user_ped(), world_chaos_setting.chaos_radius)) do
            if not IS_PED_PLAYER(ent) then
                if world_chaos_setting.exclude_mission and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                elseif world_chaos_setting.exclude_dead and ENTITY.IS_ENTITY_DEAD(ent) then
                else
                    REQUEST_CONTROL_ENTITY(ent, 10)
                    ENTITY.SET_ENTITY_MAX_SPEED(ent, 99999.0)
                    ENTITY.FREEZE_ENTITY_POSITION(ent, false)
                    local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(ent)
                    local force = {}
                    force.x = vector.x * math.random(-1, 1) * world_chaos_setting.forward_degree
                    force.y = vector.y * math.random(-1, 1) * world_chaos_setting.forward_degree
                    force.z = vector.z * math.random(-1, 1) * world_chaos_setting.forward_degree

                    ENTITY.APPLY_FORCE_TO_ENTITY(ent, 1, force.x, force.y, force.z, 0.0, 0.0, 0.0, 1, false, true, true,
                        true, true)
                    ENTITY.SET_ENTITY_HAS_GRAVITY(ent, world_chaos_setting.has_gravity)
                end
            end
        end
    end
    -- Object
    if world_chaos_setting.object_toggle then
        for _, ent in pairs(GET_NEARBY_OBJECTS(players.user_ped(), world_chaos_setting.chaos_radius)) do
            if world_chaos_setting.exclude_mission and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            elseif world_chaos_setting.exclude_dead and ENTITY.IS_ENTITY_DEAD(ent) then
            else
                REQUEST_CONTROL_ENTITY(ent, 10)
                ENTITY.SET_ENTITY_MAX_SPEED(ent, 99999.0)
                ENTITY.FREEZE_ENTITY_POSITION(ent, false)
                local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(ent)
                local force = {}
                force.x = vector.x * math.random(-1, 1) * world_chaos_setting.forward_degree
                force.y = vector.y * math.random(-1, 1) * world_chaos_setting.forward_degree
                force.z = vector.z * math.random(-1, 1) * world_chaos_setting.forward_degree

                ENTITY.APPLY_FORCE_TO_ENTITY(ent, 1, force.x, force.y, force.z, 0.0, 0.0, 0.0, 1, false, true, true,
                    true, true)
                ENTITY.SET_ENTITY_HAS_GRAVITY(ent, world_chaos_setting.has_gravity)
            end
        end
    end

    util.yield(world_chaos_setting.time_delay)
end)

menu.divider(menuRoot, "设置")
local chaos_radius_slider = menu.slider(menuRoot, "混乱范围", { "world_chaos_radius" },
    "以你为中心的范围, 0 表示全部范围", 0, 1000, 100, 10, function(value)
    world_chaos_setting.chaos_radius = value
end)
menu.toggle(menuRoot, "混乱实体：载具", { "world_chaos_vehicle_toggle" }, "", function(toggle)
    world_chaos_setting.vehicle_toggle = toggle
end, true)
menu.toggle(menuRoot, "混乱实体：行人", { "world_chaos_ped_toggle" }, "", function(toggle)
    world_chaos_setting.ped_toggle = toggle
end, true)
menu.toggle(menuRoot, "混乱实体：物体", { "world_chaos_object_toggle" }, "", function(toggle)
    world_chaos_setting.object_toggle = toggle
end)
menu.slider(menuRoot, "载具向前加速速度", { "world_chaos_forward_speed" }, "", 0, 1000, 30, 10,
    function(value)
        world_chaos_setting.forward_speed = value
    end)
menu.slider(menuRoot, "行人物体向前推进程度", { "world_chaos_forward_degree" }, "", 0, 1000, 30, 10,
    function(value)
        world_chaos_setting.forward_degree = value
    end)
menu.toggle(menuRoot, "实体有重力", { "world_chaos_has_gravity" }, "", function(toggle)
    world_chaos_setting.has_gravity = toggle
end, true)
menu.slider(menuRoot, "加速延迟", { "world_chaos_time_delay" }, "单位: ms", 0, 3000, 100, 10, function(value)
    world_chaos_setting.time_delay = value
end)
menu.toggle(menuRoot, "排除任务实体", { "world_chaos_exclude_mission" }, "", function(toggle)
    world_chaos_setting.exclude_mission = toggle
end)
menu.toggle(menuRoot, "排除已死亡实体", { "world_chaos_exclude_dead" }, "", function(toggle)
    world_chaos_setting.exclude_dead = toggle
end)

local is_chaos_radius_slider_onFocus
menu.on_focus(chaos_radius_slider, function()
    is_chaos_radius_slider_onFocus = true
    util.create_tick_handler(function()
        if not is_chaos_radius_slider_onFocus then
            return false
        end

        local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        GRAPHICS._DRAW_SPHERE(coords.x, coords.y, coords.z, world_chaos_setting.chaos_radius, 200, 50, 200, 0.5)
    end)
end)

menu.on_blur(chaos_radius_slider, function()
    is_chaos_radius_slider_onFocus = false
end)
