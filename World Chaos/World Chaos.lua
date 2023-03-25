---------------------------
--- Author: Rostal
---------------------------

util.keep_running()
util.require_natives("natives-1676318796")

-- 脚本版本
local SCRIPT_VERSION <const> = "2023/3/25"



---------------------------
--- Functions
---------------------------

local function is_ped_player(ped)
    if ENTITY.IS_ENTITY_A_PED(ped) then
        if PED.GET_PED_TYPE(ped) >= 4 then
            return false
        else
            return true
        end
    end
    return false
end

local function is_player_vehicle(vehicle)
    if vehicle == entities.get_user_vehicle_as_handle() or vehicle == entities.get_user_personal_vehicle_as_handle() then
        return true
    elseif not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1, false) then
        local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
        if is_ped_player(ped) then
            return true
        end
    end
    return false
end

local function request_control(ent, tick)
    tick = tick or 20
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and util.is_session_started() then
        entities.set_can_migrate(entities.handle_to_pointer(entity), true)

        local i = 0
        while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and i <= tick do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
            i = i + 1
            util.yield()
        end
    end
    return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity)
end

local function get_nearby_vehicles(p, radius)
    local vehicles = {}
    local p_pos = ENTITY.GET_ENTITY_COORDS(p)
    for k, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
        local veh_pos = ENTITY.GET_ENTITY_COORDS(vehicle)
        if radius <= 0 then
            table.insert(vehicles, vehicle)
        elseif v3.distance(p_pos, veh_pos) <= radius then
            table.insert(vehicles, vehicle)
        end
    end
    return vehicles
end

local function get_nearby_peds(p, radius)
    local peds = {}
    local p_pos = ENTITY.GET_ENTITY_COORDS(p)
    for k, ped in pairs(entities.get_all_peds_as_handles()) do
        if ped ~= p then
            local ped_pos = ENTITY.GET_ENTITY_COORDS(ped)
            if radius <= 0 then
                table.insert(peds, ped)
            elseif v3.distance(p_pos, ped_pos) <= radius then
                table.insert(peds, ped)
            end
        end
    end
    return peds
end

local function get_nearby_objects(p, radius)
    local objs = {}
    local p_pos = ENTITY.GET_ENTITY_COORDS(p)
    for k, obj in pairs(entities.get_all_objects_as_handles()) do
        local obj_pos = ENTITY.GET_ENTITY_COORDS(obj)
        if radius <= 0 then
            table.insert(objs, obj)
        elseif v3.distance(p_pos, obj_pos) <= radius then
            table.insert(objs, obj)
        end
    end
    return objs
end

local function get_random_colour()
    local colour = { a = 255 }
    colour.r = math.random(0, 255)
    colour.g = math.random(0, 255)
    colour.b = math.random(0, 255)
    return colour
end

local function apply_force_to_entity(entity, force, offset)
    offset = offset or v3(0, 0, 0)
    ENTITY.APPLY_FORCE_TO_ENTITY(entity, 1, force.x, force.y, force.z, offset.x, offset.y, offset.z,
        0, false, true, true, true, true)
end



---------------------------
--- Menu
---------------------------

local menu_root = menu.my_root()
menu.divider(menu_root, "混乱世界")

local chaos_setting = {
    radius = 100,
    time_delay = 100,
    vehicle = {
        toggle = true,
        force_degree = 30,
        offset_degree = 10,
        random_colour = false,
    },
    ped = {
        toggle = true,
        kick_out = false,
        force_degree = 30,
        offset_degree = 10,
        ragdoll = true,
    },
    object = {
        toggle = false,
        force_degree = 30,
        offset_degree = 10,
    },
    has_gravity = true,
    -- exclude entity
    exclude_mission = false,
    exclude_dead = false
}

menu.toggle_loop(menu_root, "开启", { "world_chaos" }, "", function()
    -- Vehicle
    if chaos_setting.vehicle.toggle then
        for _, ent in pairs(get_nearby_vehicles(players.user_ped(), chaos_setting.radius)) do
            if not is_player_vehicle(ent) then
                if chaos_setting.exclude_mission and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                elseif chaos_setting.exclude_dead and ENTITY.IS_ENTITY_DEAD(ent) then
                else
                    request_control(ent)
                    ENTITY.SET_ENTITY_MAX_SPEED(ent, 99999.0)
                    VEHICLE.SET_VEHICLE_MAX_SPEED(ent, 99999.0)
                    ENTITY.FREEZE_ENTITY_POSITION(ent, false)
                    VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(ent, false, false)
                    VEHICLE.SET_VEHICLE_GRAVITY(ent, chaos_setting.has_gravity)

                    -- VEHICLE.SET_VEHICLE_FORWARD_SPEED(ent, 30)

                    local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(ent)
                    local force = {}
                    force.x = vector.x * math.random(-1, 1) * chaos_setting.vehicle.force_degree
                    force.y = vector.y * math.random(-1, 1) * chaos_setting.vehicle.force_degree
                    force.z = vector.z * math.random(-1, 1) * chaos_setting.vehicle.force_degree
                    local offset = {}
                    offset.x = math.random(-1, 1) * chaos_setting.vehicle.offset_degree
                    offset.y = math.random(-1, 1) * chaos_setting.vehicle.offset_degree
                    offset.z = math.random(-1, 1) * chaos_setting.vehicle.offset_degree
                    apply_force_to_entity(ent, force, offset)

                    if chaos_setting.vehicle.random_colour then
                        local primary, secundary = get_random_colour(), get_random_colour()
                        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(ent, primary.r, primary.g, primary.b)
                        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(ent, secundary.r, secundary.g, secundary.b)
                    end
                end
            end
        end
    end
    -- Ped
    if chaos_setting.ped.toggle then
        for _, ent in pairs(get_nearby_peds(players.user_ped(), chaos_setting.radius)) do
            if not is_ped_player(ent) then
                if chaos_setting.exclude_mission and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                elseif chaos_setting.exclude_dead and ENTITY.IS_ENTITY_DEAD(ent) then
                else
                    request_control(ent)
                    ENTITY.SET_ENTITY_MAX_SPEED(ent, 99999.0)
                    ENTITY.FREEZE_ENTITY_POSITION(ent, false)
                    ENTITY.SET_ENTITY_HAS_GRAVITY(ent, chaos_setting.has_gravity)

                    if chaos_setting.ped.kick_out and PED.IS_PED_IN_ANY_VEHICLE(ent, false) then
                        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ent)
                    end

                    local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(ent)
                    local force = {}
                    force.x = vector.x * math.random(-1, 1) * chaos_setting.ped.force_degree
                    force.y = vector.y * math.random(-1, 1) * chaos_setting.ped.force_degree
                    force.z = vector.z * math.random(-1, 1) * chaos_setting.ped.force_degree
                    local offset = {}
                    offset.x = math.random(-1, 1) * chaos_setting.ped.offset_degree
                    offset.y = math.random(-1, 1) * chaos_setting.ped.offset_degree
                    offset.z = math.random(-1, 1) * chaos_setting.ped.offset_degree
                    apply_force_to_entity(ent, force, offset)

                    if chaos_setting.ped.ragdoll then
                        PED.SET_PED_TO_RAGDOLL(ent, 500, 500, 0, false, false, false)
                    end
                end
            end
        end
    end
    -- Object
    if chaos_setting.object.toggle then
        for _, ent in pairs(get_nearby_objects(players.user_ped(), chaos_setting.radius)) do
            if chaos_setting.exclude_mission and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            elseif chaos_setting.exclude_dead and ENTITY.IS_ENTITY_DEAD(ent) then
            else
                request_control(ent)
                ENTITY.SET_ENTITY_MAX_SPEED(ent, 99999.0)
                ENTITY.FREEZE_ENTITY_POSITION(ent, false)
                ENTITY.SET_ENTITY_HAS_GRAVITY(ent, chaos_setting.has_gravity)

                local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(ent)
                local force = {}
                force.x = vector.x * math.random(-1, 1) * chaos_setting.object.force_degree
                force.y = vector.y * math.random(-1, 1) * chaos_setting.object.force_degree
                force.z = vector.z * math.random(-1, 1) * chaos_setting.object.force_degree
                local offset = {}
                offset.x = math.random(-1, 1) * chaos_setting.object.offset_degree
                offset.y = math.random(-1, 1) * chaos_setting.object.offset_degree
                offset.z = math.random(-1, 1) * chaos_setting.object.offset_degree
                apply_force_to_entity(ent, force, offset)
            end
        end
    end

    util.yield(chaos_setting.time_delay)
end)


menu.divider(menu_root, "设置")
local chaos_radius_slider = menu.slider(menu_root, "混乱范围", { "chaos_radius" },
    "以你为中心的范围, 0 表示全部范围", 0, 1000, 100, 10, function(value)
        chaos_setting.radius = value
    end)
menu.slider(menu_root, "时间间隔", { "chaos_time_delay" }, "单位: ms", 0, 3000, 100, 10, function(value)
    chaos_setting.time_delay = value
end)



----------------
-- 混乱实体
----------------
local chaos_entity = menu.list(menu_root, "混乱实体", {}, "")

menu.toggle(chaos_entity, "载具", {}, "默认排除玩家载具", function(toggle)
    chaos_setting.vehicle.toggle = toggle
end, true)
menu.toggle(chaos_entity, "NPC", {}, "", function(toggle)
    chaos_setting.ped.toggle = toggle
end, true)
menu.toggle(chaos_entity, "物体", {}, "", function(toggle)
    chaos_setting.object.toggle = toggle
end)

menu.divider(chaos_entity, "排除实体")
menu.toggle(chaos_entity, "任务实体", {}, "", function(toggle)
    chaos_setting.exclude_mission = toggle
end)
menu.toggle(chaos_entity, "已死亡实体", {}, "", function(toggle)
    chaos_setting.exclude_dead = toggle
end)



----------------
-- 混乱行为
----------------
local chaos_behavior = menu.list(menu_root, "混乱行为", {}, "")

menu.toggle(chaos_behavior, "保留重力", {}, "", function(toggle)
    chaos_setting.has_gravity = toggle
end, true)

menu.divider(chaos_behavior, "载具")
menu.slider(chaos_behavior, "推进程度", { "chaos_vehicle_force_degree" }, "", 0, 1000, 30, 10,
    function(value)
        chaos_setting.vehicle.force_degree = value
    end)
menu.slider(chaos_behavior, "位移程度", { "chaos_vehicle_offset_degree" }, "", 0, 1000, 10, 10,
    function(value)
        chaos_setting.vehicle.offset_degree = value
    end)
menu.toggle(chaos_behavior, "随机变色", {}, "", function(toggle)
    chaos_setting.vehicle.random_colour = toggle
end)

menu.divider(chaos_behavior, "NPC")
menu.toggle(chaos_behavior, "踢出载具内NPC", {}, "", function(toggle)
    chaos_setting.ped.kick_out = toggle
end)
menu.slider(chaos_behavior, "推进程度", { "chaos_ped_force_degree" }, "", 0, 1000, 30, 10,
    function(value)
        chaos_setting.ped.force_degree = value
    end)
menu.slider(chaos_behavior, "位移程度", { "chaos_ped_offset_degree" }, "", 0, 1000, 10, 10,
    function(value)
        chaos_setting.ped.offset_degree = value
    end)
menu.toggle(chaos_behavior, "摔倒", {}, "", function(toggle)
    chaos_setting.ped.ragdoll = toggle
end, true)

menu.divider(chaos_behavior, "物体")
menu.slider(chaos_behavior, "推进程度", { "chaos_object_force_degree" }, "", 0, 1000, 30, 10,
    function(value)
        chaos_setting.object.force_degree = value
    end)
menu.slider(chaos_behavior, "位移程度", { "chaos_object_offset_degree" }, "", 0, 1000, 10, 10,
    function(value)
        chaos_setting.object.offset_degree = value
    end)



local radius_slider_onFocus
menu.on_focus(chaos_radius_slider, function()
    radius_slider_onFocus = true
    util.create_tick_handler(function()
        if not radius_slider_onFocus then
            return false
        end

        local coords = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        GRAPHICS.DRAW_MARKER_SPHERE(coords.x, coords.y, coords.z, chaos_setting.radius, 200, 50, 200, 0.5)
    end)
end)

menu.on_blur(chaos_radius_slider, function()
    radius_slider_onFocus = false
end)





---------------------------
--- 关于
---------------------------
menu.divider(menu_root, "")
local about_options = menu.list(menu_root, "关于", {}, "")
menu.readonly(about_options, "Author", "Rostal")
menu.hyperlink(about_options, "Github", "https://github.com/TCRoid/Stand-_-Lua-_-Scripts")
menu.readonly(about_options, "Version", SCRIPT_VERSION)
