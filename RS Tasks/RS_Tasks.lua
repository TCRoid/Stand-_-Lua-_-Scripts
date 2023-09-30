-------------------------------
--- Author: Rostal
-------------------------------

util.keep_running()
util.require_natives("2944b", "init")

local SCRIPT_VERSION <const> = "2023/9/30"

local SUPPORT_GTAO <const> = 1.67


--#region Functions

--------------------------------
-- Base Functions
--------------------------------

function tp_entity(entity, coords, heading)
    if heading ~= nil then
        ENTITY.SET_ENTITY_HEADING(entity, heading)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entity, coords.x, coords.y, coords.z, true, false, false)
end

function entity_heading(entity, heading)
    if heading ~= nil then
        ENTITY.SET_ENTITY_HEADING(entity, heading)
        return heading
    end
    return ENTITY.GET_ENTITY_HEADING(entity)
end

--------------------------------
-- Local Player Functions
--------------------------------

function teleport(coords, heading)
    local ent = entities.get_user_vehicle_as_handle(false)
    if ent == INVALID_GUID then
        ent = players.user_ped()
    end
    tp_entity(ent, coords, heading)
end

function teleport2(x, y, z, heading)
    teleport(v3(x, y, z), heading)
end

function player_heading(heading)
    local ent = entities.get_user_vehicle_as_handle(false)
    if ent == INVALID_GUID then
        ent = players.user_ped()
    end

    if heading ~= nil then
        ENTITY.SET_ENTITY_HEADING(ent, heading)
        return heading
    end
    return ENTITY.GET_ENTITY_HEADING(ent)
end

function tp_entity_to_me(entity, offsetX, offsetY, offsetZ)
    offsetX = offsetX or 0.0
    offsetY = offsetY or 0.0
    offsetZ = offsetZ or 0.0
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), offsetX, offsetY, offsetZ)
    tp_entity(entity, coords)
end

function tp_to_entity(entity, offsetX, offsetY, offsetZ)
    offsetX = offsetX or 0.0
    offsetY = offsetY or 0.0
    offsetZ = offsetZ or 0.0
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, offsetX, offsetY, offsetZ)
    teleport(coords)
end

function tp_into_vehicle(vehicle, seat, door, driver)
    seat = seat or -1
    -- unlock doors
    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, false)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(vehicle, false)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_TEAMS(vehicle, false)
    VEHICLE.SET_DONT_ALLOW_PLAYER_TO_ENTER_VEHICLE_IF_LOCKED_FOR_PLAYER(vehicle, false)
    -- unfreeze
    ENTITY.FREEZE_ENTITY_POSITION(vehicle, false)
    VEHICLE.SET_VEHICLE_IS_CONSIDERED_BY_PLAYER(vehicle, true)
    VEHICLE.SET_VEHICLE_UNDRIVEABLE(vehicle, false)
    -- clear wanted
    VEHICLE.SET_VEHICLE_IS_WANTED(vehicle, false)
    VEHICLE.SET_VEHICLE_INFLUENCES_WANTED_LEVEL(vehicle, false)
    VEHICLE.SET_VEHICLE_HAS_BEEN_OWNED_BY_PLAYER(vehicle, true)
    VEHICLE.SET_VEHICLE_IS_STOLEN(vehicle, false)
    VEHICLE.SET_POLICE_FOCUS_WILL_TRACK_VEHICLE(vehicle, false)

    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, false)

    if door == "delete" then
        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 0, true) -- left front door
    end

    if driver ~= nil then
        local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, seat)
        if ped ~= 0 then
            if driver == "tp" then
                set_entity_move(ped, 0.0, 5.0, 3.0)
            elseif driver == "delete" then
                entities.delete(ped)
            end
        end
    end

    PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, seat)
end

function tp_vehicle_to_me(vehicle, seat, door, driver)
    entity_heading(vehicle, player_heading())
    tp_entity_to_me(vehicle)
    tp_into_vehicle(vehicle, seat, door, driver)
end

--------------------------------
-- Entity Functions
--------------------------------

function set_entity_move(entity, offsetX, offsetY, offsetZ)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, offsetX, offsetY, offsetZ)
    tp_entity(entity, coords)
end

function tp_entity_to_entity(tpEntity, toEntity, offsetX, offsetY, offsetZ)
    offsetX = offsetX or 0.0
    offsetY = offsetY or 0.0
    offsetZ = offsetZ or 0.0
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(toEntity, offsetX, offsetY, offsetZ)
    tp_entity(tpEntity, coords)
end

function get_all_entities(Type)
    Type = string.lower(Type)

    if Type == "ped" then
        return entities.get_all_peds_as_handles()
    end
    if Type == "vehicle" then
        return entities.get_all_vehicles_as_handles()
    end
    if Type == "object" then
        return entities.get_all_objects_as_handles()
    end
    if Type == "pickup" then
        return entities.get_all_pickups_as_handles()
    end

    return {}
end

function get_entities_by_hash(Type, isMission, ...)
    local all_entity = get_all_entities(Type)

    local entity_list = {}
    local hash_list = { ... }

    for k, ent in pairs(all_entity) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        for _, Hash in pairs(hash_list) do
            if EntityHash == Hash then
                if isMission then
                    if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                        table.insert(entity_list, ent)
                    end
                else
                    table.insert(entity_list, ent)
                end
            end
        end
    end

    return entity_list
end

function set_entity_godmode(entity, toggle)
    ENTITY.SET_ENTITY_INVINCIBLE(entity, toggle)
    ENTITY.SET_ENTITY_PROOFS(entity, toggle, toggle, toggle, toggle, toggle, toggle, toggle, toggle)
    ENTITY.SET_ENTITY_CAN_BE_DAMAGED(entity, not toggle)
end

function is_hostile_entity(entity)
    if ENTITY.IS_ENTITY_A_PED(entity) then
        if is_hostile_ped(entity) then
            return true
        end
    end

    if ENTITY.IS_ENTITY_A_VEHICLE(entity) then
        local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(entity, -1)
        if is_hostile_ped(driver) then
            return true
        end
    end

    local blip = HUD.GET_BLIP_FROM_ENTITY(entity)
    if HUD.DOES_BLIP_EXIST(blip) then
        local blip_colour = HUD.GET_BLIP_COLOUR(blip)
        if blip_colour == 1 or blip_colour == 59 then -- red
            return true
        end
    end

    return false
end

-----------------------------
-- Ped Functions
-----------------------------

function is_hostile_ped(ped)
    if not ENTITY.IS_ENTITY_A_PED(ped) then
        return false
    end

    if PED.IS_PED_IN_COMBAT(ped, players.user_ped()) then
        return true
    end

    local rel = PED.GET_RELATIONSHIP_BETWEEN_PEDS(ped, players.user_ped())
    if rel == 3 or rel == 4 or rel == 5 then -- Dislike or Wanted or Hate
        return true
    end

    return false
end

-----------------------------
-- Vehicle Functions
-----------------------------

function kill_hostile_vehicle_engine()
    for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
        if is_hostile_entity(vehicle) then
            VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, -4000.0)
        end
    end
end

--------------------------------
-- Blip Functions
--------------------------------

function get_entity_from_blip(blip)
    if not HUD.DOES_BLIP_EXIST(blip) then
        return 0
    end

    local entity = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(blip)
    if not ENTITY.DOES_ENTITY_EXIST(entity) then
        return 0
    end

    return entity
end

--------------------------------
-- Stat Functions
--------------------------------

function ADD_MP_INDEX(stat)
    if not string.contains(stat, "MP_") and not string.contains(stat, "MPPLY_") then
        return "MP" .. util.get_char_slot() .. "_" .. stat
    end
    return stat
end

function STAT_SET_INT(stat, value)
    STATS.STAT_SET_INT(util.joaat(ADD_MP_INDEX(stat)), value, true)
end

function STAT_GET_INT(stat)
    local IntPTR = memory.alloc_int()
    STATS.STAT_GET_INT(util.joaat(ADD_MP_INDEX(stat)), IntPTR, -1)
    return memory.read_int(IntPTR)
end

--#endregion


--------------------
-- Menu
--------------------

local Menu_Root <const> = menu.my_root()

menu.divider(Menu_Root, "RS Tasks")

menu.action(Menu_Root, "Restart Script", {}, "", function()
    util.restart_script()
end)




--#region Contact Mission

---------------------------------------
--------    Contact Mission    --------
---------------------------------------

local Contact_Mission = {
    Series = {},
}

Contact_Mission.Root = menu.list(Menu_Root, "联系人差事", {}, "")
---------------
-- 拉玛
---------------
Contact_Mission.Lamar = menu.list(Contact_Mission.Root, "拉玛", {}, "")

menu.divider(Contact_Mission.Lamar, "通用")
menu.action(Contact_Mission.Lamar, "传送进 油罐车/拖车", {},
    "任务: 冲下大洋高速公路, 禁止吸烟, 极乐世界的门票, 圣安地列斯之小首尔",
    function()
        local ent = get_entity_from_blip(HUD.GET_CLOSEST_BLIP_INFO_ID(1))
        if ent ~= 0 and ENTITY.IS_ENTITY_ATTACHED(ent) then
            set_entity_godmode(ent, true)
            local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
            tp_into_vehicle(attached_ent, -1, "", "delete")
        end
    end)

menu.divider(Contact_Mission.Lamar, "巴勒帮背水一战")
menu.action(Contact_Mission.Lamar, "莎夫特 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, -1255452397)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            tp_vehicle_to_me(ent, -1, "", "delete")
        end
    end
end)

menu.divider(Contact_Mission.Lamar, "攻其不备")
menu.action(Contact_Mission.Lamar, "目标NPC(友好) 传送到我", {}, "", function()
    local ent = get_entity_from_blip(HUD.GET_NEXT_BLIP_INFO_ID(270))
    if ent ~= 0 then
        set_entity_godmode(ent, true)
        tp_entity_to_me(ent, 0.0, 2.0, 0.0)
    end
end)


---------------
-- 崔佛
---------------
Contact_Mission.Trevor = menu.list(Contact_Mission.Root, "崔佛", {}, "")

menu.divider(Contact_Mission.Trevor, "尾行直升机")
menu.action(Contact_Mission.Trevor, "传送到 目的地", {},
    "直升机传送到目标地点,玩家传送进目标载具", function()
        local target_vehicle, heli = 0, 0
        local entity_list = get_entities_by_hash("object", true, -230239317)
        if next(entity_list) ~= nil then
            local ent = entity_list[1]
            if ENTITY.IS_ENTITY_ATTACHED(ent) then
                local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
                if ENTITY.IS_ENTITY_A_VEHICLE(attached_ent) then
                    target_vehicle = attached_ent
                end
            end
        end

        entity_list = get_entities_by_hash("ped", true, -1422914553)
        if next(entity_list) ~= nil then
            local ent = entity_list[1]
            heli = PED.GET_VEHICLE_PED_IS_IN(ent, false)
        end

        if ENTITY.DOES_ENTITY_EXIST(target_vehicle) and ENTITY.DOES_ENTITY_EXIST(heli) then
            tp_into_vehicle(target_vehicle)
            tp_entity(heli, v3(-291.0237731, 2508.635009, 74.99934796), 189.40745544)
        end
    end)

menu.divider(Contact_Mission.Trevor, "洛圣都姓崔")
menu.action(Contact_Mission.Trevor, "拾取物 传送到我", {}, "", function()
    for _, pickup in pairs(entities.get_all_pickups_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(pickup) then
            if ENTITY.IS_ENTITY_ATTACHED(pickup) then
                ENTITY.DETACH_ENTITY(pickup, false, true)
                ENTITY.SET_ENTITY_VISIBLE(pickup, true, false)
            end
            tp_entity_to_me(pickup)
        end
    end
end)
menu.action(Contact_Mission.Trevor, "传送进 船", {}, "", function()
    local ent = get_entity_from_blip(HUD.GET_NEXT_BLIP_INFO_ID(427))
    if ent ~= 0 then
        tp_into_vehicle(ent)
    end
end)


---------------
-- 小罗
---------------
Contact_Mission.Ron = menu.list(Contact_Mission.Root, "小罗", {}, "")

menu.divider(Contact_Mission.Ron, "基地侵略")
menu.action(Contact_Mission.Ron, "传送进 小罗的飞机", {}, "", function()
    local ent = get_entity_from_blip(HUD.GET_NEXT_BLIP_INFO_ID(423))
    if ent ~= 0 then
        tp_into_vehicle(ent)
    end
end)
menu.action(Contact_Mission.Ron, "摧毁 天煞", {}, "", function()
    kill_hostile_vehicle_engine()
end)
menu.action(Contact_Mission.Ron, "传送进 运兵直升机", {}, "会同时传送到目的地", function()
    local ent = get_entity_from_blip(HUD.GET_NEXT_BLIP_INFO_ID(64))
    if ent ~= 0 then
        tp_entity(ent, v3(1771.157958, 3239.66015, 42.99959997))
        tp_into_vehicle(ent)
    end
end)


---------------
-- 杰拉德
---------------
Contact_Mission.Gerald = menu.list(Contact_Mission.Root, "杰拉德", {}, "")

menu.divider(Contact_Mission.Gerald, "通用")
menu.action(Contact_Mission.Gerald, "拾取物 传送到我", {},
    "任务: 小道消息, 洛圣都河水泛滥", function()
        for _, pickup in pairs(entities.get_all_pickups_as_handles()) do
            if ENTITY.IS_ENTITY_A_MISSION_ENTITY(pickup) then
                if ENTITY.IS_ENTITY_ATTACHED(pickup) then
                    ENTITY.DETACH_ENTITY(pickup, false, true)
                    ENTITY.SET_ENTITY_VISIBLE(pickup, true, false)
                end
                tp_entity_to_me(pickup)
            end
        end
    end)


---------------
-- 西米恩
---------------
Contact_Mission.Simeon = menu.list(Contact_Mission.Root, "西米恩", {}, "")

menu.divider(Contact_Mission.Simeon, "通用")
menu.action(Contact_Mission.Simeon, "目标载具 传送到我", {},
    "任务: 原则之上, 追逐者, 追逐者2, 布罗抢劫任务", function()
        local ent = get_entity_from_blip(HUD.GET_NEXT_BLIP_INFO_ID(1))
        if ent ~= 0 then
            tp_vehicle_to_me(ent, -1, "", "delete")
        end
    end)
menu.action(Contact_Mission.Simeon, "摧毁 敌对载具", {},
    "任务: 炸毁汽车, 炸毁汽车2, 炸毁汽车3", function()
        kill_hostile_vehicle_engine()
    end)


---------------
-- 莱斯特
---------------
Contact_Mission.Lester = menu.list(Contact_Mission.Root, "莱斯特", {}, "")

menu.divider(Contact_Mission.Lester, "通用")
menu.action(Contact_Mission.Lester, "摧毁 敌对载具", {},
    "任务: 声东击警, 拒绝服务", function()
        kill_hostile_vehicle_engine()
    end)
menu.action(Contact_Mission.Lester, "拾取物 传送到我", {},
    "任务: 拒绝服务", function()
        for _, pickup in pairs(entities.get_all_pickups_as_handles()) do
            if ENTITY.IS_ENTITY_A_MISSION_ENTITY(pickup) then
                if ENTITY.IS_ENTITY_ATTACHED(pickup) then
                    ENTITY.DETACH_ENTITY(pickup, false, true)
                    ENTITY.SET_ENTITY_VISIBLE(pickup, true, false)
                end
                tp_entity_to_me(pickup)
            end
        end
    end)

menu.divider(Contact_Mission.Lester, "泰坦号之差事")
menu.action(Contact_Mission.Lester, "传送进 泰坦号", {}, "", function()
    local ent = get_entity_from_blip(HUD.GET_NEXT_BLIP_INFO_ID(423))
    if ent ~= 0 then
        tp_into_vehicle(ent)
    end
end)

menu.divider(Contact_Mission.Lester, "大逃脱")
menu.action(Contact_Mission.Lester, "目标NPC(友好) 传送到我", {}, "", function()
    local ent = get_entity_from_blip(HUD.GET_NEXT_BLIP_INFO_ID(270))
    if ent ~= 0 then
        set_entity_godmode(ent, true)
        tp_entity_to_me(ent, 0.0, 2.0, 0.0)
    end
end)


---------------
-- 马丁
---------------
Contact_Mission.Martin = menu.list(Contact_Mission.Root, "马丁", {}, "")

menu.divider(Contact_Mission.Martin, "通用")
menu.action(Contact_Mission.Martin, "目标NPC(敌对) 传送到我并击杀", {},
    "任务: 退房时间, 死神天降, 编辑和小偷, 引渡有赏", function()
        local ent = 0

        local entity_list = get_entities_by_hash("ped", true, -912318012)
        if next(entity_list) ~= nil then
            local ent = entity_list[1]
        else
            ent = get_entity_from_blip(HUD.GET_NEXT_BLIP_INFO_ID(1))
        end

        if ENTITY.DOES_ENTITY_EXIST(ent) then
            tp_entity_to_me(ent, 0.0, 2.0, 0.0)
            ENTITY.SET_ENTITY_HEALTH(ent, 0, 0)
        end
    end)
menu.action(Contact_Mission.Martin, "摧毁 敌对载具", {},
    "任务: 人为的稀缺性, 引渡有赏", function()
        kill_hostile_vehicle_engine()
    end)

menu.divider(Contact_Mission.Martin, "夺妓大作战")
menu.action(Contact_Mission.Martin, "目标NPC(友好) 传送到我", {}, "", function()
    local ent = get_entity_from_blip(HUD.GET_NEXT_BLIP_INFO_ID(270))
    if ent ~= 0 then
        set_entity_godmode(ent, true)
        tp_entity_to_me(ent, 0.0, 2.0, 0.0)
    end
end)

menu.divider(Contact_Mission.Martin, "保镖护卫")
menu.action(Contact_Mission.Martin, "传送进 直升机", {}, "", function()
    local ent = get_entity_from_blip(HUD.GET_NEXT_BLIP_INFO_ID(64))
    if ent ~= 0 then
        tp_into_vehicle(ent)
    end
end)
menu.action(Contact_Mission.Martin, "目标直升机 传送到目的地", {}, "", function()
    local ent = get_entity_from_blip(HUD.GET_NEXT_BLIP_INFO_ID(270))
    if ent ~= 0 then
        set_entity_godmode(ent, true)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ent, false)
        tp_entity(vehicle, v3(1743.330932, 3273.591796, 41.999106750), 272.07516479)
    end
end)

menu.divider(Contact_Mission.Martin, "干船坞")
menu.action(Contact_Mission.Martin, "摧毁 保险箱", {}, "跳过破解过程", function()
    local ent = get_entity_from_blip(HUD.GET_NEXT_BLIP_INFO_ID(1))
    if ent ~= 0 then
        ENTITY.SET_ENTITY_HEALTH(ent, 0, 0)
    end
end)
menu.action(Contact_Mission.Martin, "传送进 船", {}, "", function()
    local ent = get_entity_from_blip(HUD.GET_NEXT_BLIP_INFO_ID(427))
    if ent ~= 0 then
        tp_into_vehicle(ent)
    end
end)

--#endregion Contact Mission



--#region Contact Mission Series

----------------------------------------------
--------    Contact Mission Series    --------
----------------------------------------------

Contact_Mission.Series.Root = menu.list(Menu_Root, "联系人系列差事", {}, "")


-----------------------
-- 杰拉德 - 最后一搏
-----------------------
Contact_Mission.Series.LastPlay = menu.list(Contact_Mission.Series.Root, "杰拉德 - 最后一搏", {}, "")


--------------------
-- 西米恩 - 回收
--------------------
Contact_Mission.Series.Repo = menu.list(Contact_Mission.Series.Root, "西米恩 - 回收", {}, "")


------------------
-- 马丁 - 暗杀
------------------
Contact_Mission.Series.Dispatch = menu.list(Contact_Mission.Series.Root, "马丁 - 暗杀", {}, "")


------------------
-- ULP
------------------
Contact_Mission.Series.ULP = menu.list(Contact_Mission.Series.Root, "ULP", {}, "")


------------------
-- 第一剂
------------------
Contact_Mission.Series.FirstDose = menu.list(Contact_Mission.Series.Root, "第一剂", {}, "")

menu.divider(Contact_Mission.Series.FirstDose, "欢迎加入家人团")
menu.action(Contact_Mission.Series.FirstDose, "达克斯 传送到我/我的载具", {}, "", function()
    local entity_list = get_entities_by_hash("ped", true, -244824852)
    if next(entity_list) ~= nil then
        local ent = entity_list[1]

        local veh = entities.get_user_vehicle_as_handle(false)
        if veh ~= INVALID_GUID then
            PED.SET_PED_INTO_VEHICLE(ent, veh, -2)
        else
            tp_entity_to_me(ent, 0.0, 2.0, 0.0)
        end
    end
end)
menu.action(Contact_Mission.Series.FirstDose, "传送进 安旅者", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, -1627077503)
    if next(entity_list) ~= nil then
        local ent = entity_list[1]
        tp_into_vehicle(ent)
    end
end)

menu.divider(Contact_Mission.Series.FirstDose, "指定司机")
menu.action(Contact_Mission.Series.FirstDose, "传送进 卡车", {}, "同时与拖车相连", function()
    local packer, trflat = 0, 0
    local entity_list = get_entities_by_hash("vehicle", true, 569305213)
    if next(entity_list) ~= nil then
        packer = entity_list[1]
    end

    entity_list = get_entities_by_hash("vehicle", true, -1352468814)
    if next(entity_list) ~= nil then
        trflat = entity_list[1]
    end

    if ENTITY.DOES_ENTITY_EXIST(packer) and ENTITY.DOES_ENTITY_EXIST(trflat) then
        entity_heading(packer, entity_heading(trflat))
        tp_entity_to_entity(packer, trflat, 0.0, 9.0, 0.0)
        tp_into_vehicle(packer)
    end
end)

menu.divider(Contact_Mission.Series.FirstDose, "要战不要爱")
menu.action(Contact_Mission.Series.FirstDose, "摧毁 实验室设备", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, 1536058492, 148360438)
    if next(entity_list) ~= nil then
        for _, ent in pairs(entity_list) do
            local coords = ENTITY.GET_ENTITY_COORDS(ent)
            coords.z = coords.z + math.random(-1, 1)
            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), coords.x, coords.y, coords.z,
                4, 100.0, false, false, 0.0)
        end
    end
end)
menu.action(Contact_Mission.Series.FirstDose, "摧毁 敌对载具", {}, "", function()
    kill_hostile_vehicle_engine()
end)

menu.divider(Contact_Mission.Series.FirstDose, "脱轨")
menu.action(Contact_Mission.Series.FirstDose, "箱子 传送到我", {}, "会堆在一起", function()
    local entity_list = get_entities_by_hash("object", true, 2082893870)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            entity_heading(ent, player_heading())
            tp_entity_to_me(ent, 0.0, 1.0, -1.0)
        end
    end
end)
menu.click_slider(Contact_Mission.Series.FirstDose, "传送到 集装箱", {}, "", 1, 5, 1, 1, function(value)
    local pos_list = {
        { 2611.6291503906, 1606.3566894531, 29.999958755493, 46.53882598877 },
        { 2610.18359375,   1576.4083251953, 30.999494049072, 0.92708724737167 },
        { 2611.5793457031, 1531.6030273438, 31.999804855347, 353.03784179688 },
        { 2611.2270507812, 1528.0213623047, 31.999783874512, 176.99578857422 },
        { 2612.4489746094, 1506.3836669922, 32.999629272461, 165.02543640137 }
    }
    teleport2(table.unpack(pos_list[value]))
end)


------------------
-- 最后一剂
------------------
Contact_Mission.Series.LastDose = menu.list(Contact_Mission.Series.Root, "最后一剂", {}, "")

menu.divider(Contact_Mission.Series.LastDose, "不寻常的嫌疑人")
menu.action(Contact_Mission.Series.LastDose, "杀死 敌对NPC", {}, "避免误杀首领", function()
    for k, ped in pairs(entities.get_all_peds_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped) then
            local blip = HUD.GET_BLIP_FROM_ENTITY(ped)
            if HUD.GET_BLIP_COLOUR(blip) == 1 then
                ENTITY.SET_ENTITY_HEALTH(ped, 0, 0)
            end
        end
    end
end)
menu.action(Contact_Mission.Series.LastDose, "传送到 首领", {}, "", function()
    local ent = get_entity_from_blip(HUD.GET_CLOSEST_BLIP_INFO_ID(855))
    if ent ~= 0 then
        tp_to_entity(ent, 0.0, 1.0, 0.0)
    end
end)

menu.divider(Contact_Mission.Series.LastDose, "费神")
menu.action(Contact_Mission.Series.LastDose, "传送到 线索", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, -830685166)
    if next(entity_list) ~= nil then
        local ent = entity_list[1]
        tp_to_entity(ent, 0.0, 0.0, 0.5)
    end
end)
menu.action(Contact_Mission.Series.LastDose, "传送到 钥匙", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, -1423372530)
    if next(entity_list) ~= nil then
        local ent = entity_list[1]
        tp_to_entity(ent, 0.0, 0.0, 0.5)
    end
end)

menu.divider(Contact_Mission.Series.LastDose, "梆梆梆")
menu.action(Contact_Mission.Series.LastDose, "货机 传送到我并冻结", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, -1958189855)
    if next(entity_list) ~= nil then
        local ent = entity_list[1]
        ENTITY.FREEZE_ENTITY_POSITION(ent, true)
        entity_heading(ent, player_heading())
        tp_entity_to_me(ent, 0.0, 40.0, 10.0)
    end
end)
menu.action(Contact_Mission.Series.LastDose, "厢型车 无敌", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, 1945374990)
    if next(entity_list) ~= nil then
        local ent = entity_list[1]
        set_entity_godmode(ent, true)
        VEHICLE.SET_VEHICLE_ENGINE_ON(ent, true, true, false)
    end
end)


--#endregion Contact Mission Series



--#region Cayo Perico Heist

-----------------------------------------
--------    Cayo Perico Heist    --------
-----------------------------------------

local Cayo_Perico = {}

Cayo_Perico.Root = menu.list(Menu_Root, "佩里科岛抢劫", {}, "")

Cayo_Perico.help_text = "要求: 单人,非首次上岛\n侦查完主要目标后,设置次要目标为全黄金\n进行任务时,需要拿满背包"
menu.action(Cayo_Perico.Root, "说明", {}, Cayo_Perico.help_text, function()
end)
---------------
-- Presets
---------------
Cayo_Perico.Presets = {
    primary_values = {
        [0] = 630000,  -- Tequila
        [1] = 700000,  -- Ruby
        [2] = 770000,  -- Bearer Bonds
        [3] = 1300000, -- Pink Diamond
        [4] = 1100000, -- Madrazo Files
        [5] = 1900000, -- Panther
    }
}

Cayo_Perico.Presets.Root = menu.list(Cayo_Perico.Root, "前置", {}, "")

Cayo_Perico.Presets.TargetValue = menu.slider(Cayo_Perico.Presets.Root, "目标到账金额", { "rs_cp_target" }, "",
    0, 2550000, 2400000, 10000, function(value)
    end)

menu.divider(Cayo_Perico.Presets.Root, "次要目标")
menu.action(Cayo_Perico.Presets.Root, "计算 黄金价格", {}, "", function()
    -- Primary
    local primary = STAT_GET_INT("H4CNF_TARGET")
    local primary_value = Cayo_Perico.Presets.primary_values[primary]
    if primary_value == nil then
        util.toast("请先侦查完主要目标")
        return
    end

    -- Difficulty
    local difficulty_multiplier = 1.0
    if STAT_GET_INT("H4_PROGRESS") == 131055 then
        difficulty_multiplier = 1.1
    end

    primary_value = primary_value * difficulty_multiplier

    local target_value = menu.get_value(Cayo_Perico.Presets.TargetValue) / 0.88
    local take_value = target_value - primary_value
    local gold_value = math.floor(take_value * 0.6666666)

    menu.set_value(Cayo_Perico.Presets.GoldValue, gold_value)
end)

Cayo_Perico.Presets.GoldValue = menu.slider(Cayo_Perico.Presets.Root, "黄金价格", { "rs_cp_gold_value" }, "",
    0, 3000000, 333333, 10000, function(value)
    end)

menu.action(Cayo_Perico.Presets.Root, "设置为 全黄金", {}, "", function()
    STAT_SET_INT("H4LOOT_CASH_I", 0)
    STAT_SET_INT("H4LOOT_CASH_C", 0)
    STAT_SET_INT("H4LOOT_CASH_V", 0)
    STAT_SET_INT("H4LOOT_WEED_I", 0)
    STAT_SET_INT("H4LOOT_WEED_C", 0)
    STAT_SET_INT("H4LOOT_WEED_V", 0)
    STAT_SET_INT("H4LOOT_COKE_I", 0)
    STAT_SET_INT("H4LOOT_COKE_C", 0)
    STAT_SET_INT("H4LOOT_COKE_V", 0)
    STAT_SET_INT("H4LOOT_PAINT", 0)
    STAT_SET_INT("H4LOOT_PAINT_V", 0)
    STAT_SET_INT("H4LOOT_GOLD_I", 0)
    STAT_SET_INT("H4LOOT_GOLD_C", -1)
    STAT_SET_INT("H4LOOT_GOLD_V", menu.get_value(Cayo_Perico.Presets.GoldValue))

    STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 0)
    STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
    STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
    STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
    STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 0)
    STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
    STAT_SET_INT("H4LOOT_PAINT_SCOPED", 0)
    STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
    STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", -1)

    util.toast("完成!")
end)
---------------
-- Main
---------------
menu.toggle_loop(Cayo_Perico.Root, "NPC署名爆炸", {}, "", function()
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if not entities.is_player_ped(ped) and not ENTITY.IS_ENTITY_DEAD(ped) then
            local coords = ENTITY.GET_ENTITY_COORDS(ped)
            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), coords.x, coords.y, coords.z, 4, 1.0, false, false, 0.0)
        end
    end
    util.yield(800)
end)
menu.action(Cayo_Perico.Root, "密码副本 传送到我", {}, "接近才会生成", function()
    for _, ent in pairs(entities.get_all_pickups_as_handles()) do
        if ENTITY.GET_ENTITY_MODEL(ent) == -832966178 then
            tp_entity_to_me(ent)
        end
    end
end)
menu.action(Cayo_Perico.Root, "传送到 侧门", {}, "", function()
    teleport2(4955.961914, -5784.6044921, 20.999599868, 257.22689819)
end)
menu.action(Cayo_Perico.Root, "主要目标 传送到我", {}, "", function()
    local blip = HUD.GET_CLOSEST_BLIP_INFO_ID(765)
    if not HUD.DOES_BLIP_EXIST(blip) then
        for _, ent in pairs(entities.get_all_objects_as_handles()) do
            local hash = ENTITY.GET_ENTITY_MODEL(ent)
            if hash == -1714533217 or hash == 1098122770 then
                ENTITY.SET_ENTITY_HEALTH(ent, 0, 0)
            end
        end
        util.yield(1000)
    end

    local ent = get_entity_from_blip(HUD.GET_CLOSEST_BLIP_INFO_ID(765))
    if ent ~= 0 then
        tp_entity_to_me(ent)
    else
        util.toast("未找到主要目标")
    end
end)
menu.toggle_loop(Cayo_Perico.Root, "自动收集财物", {}, "", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 135) then
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 237, 1)
        util.yield(30)
    end
end)
menu.click_slider(Cayo_Perico.Root, "传送到 黄金", {}, "", 1, 2, 1, 1, function(value)
    if value == 1 then
        teleport2(5028.7109, -5734.5815429, 17.999480712, 322.03887939)
    elseif value == 2 then
        teleport2(5030.251953, -5737.185546, 17.999486755, 141.66778564)
    end
end)
menu.action(Cayo_Perico.Root, "传送到 正门", {}, "", function()
    teleport2(4990.0385742, -5717.689453, 19.999203857, 50)
end)
menu.action(Cayo_Perico.Root, "传送到 海洋撤离点", {}, "", function()
    teleport2(4771.479, -6165.737, -38.079613)
end)

--#endregion Cayo Perico Heist



--#region Union Depository

----------------------------------------
--------    Union Depository    --------
----------------------------------------
local Union_Depository = menu.list(Menu_Root, "联合储蓄", {}, "")

menu.action(Union_Depository, "说明", {}, "无", function()
end)

menu.toggle_loop(Union_Depository, "低通缉难度模式", {}, "",
    function()
        PLAYER.SET_DISPATCH_COPS_FOR_PLAYER(players.user(), false)
        PLAYER.SET_WANTED_LEVEL_MULTIPLIER(0.0)
        PLAYER.SET_WANTED_LEVEL_DIFFICULTY(players.user(), 0.0)
        PLAYER.SET_POLICE_IGNORE_PLAYER(players.user(), true)
    end, function()
        PLAYER.SET_DISPATCH_COPS_FOR_PLAYER(players.user(), true)
        PLAYER.RESET_WANTED_LEVEL_DIFFICULTY(players.user())
        PLAYER.SET_POLICE_IGNORE_PLAYER(players.user(), false)
    end)
menu.action(Union_Depository, "传送进 保安车", {}, "", function()
    for _, veh in pairs(entities.get_all_vehicles_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(veh) and ENTITY.GET_ENTITY_MODEL(veh) == 470404958 then
            tp_into_vehicle(veh)
        end
    end
end)
menu.action(Union_Depository, "传送到 刷卡位置", {}, "", function()
    teleport2(11.844631195, -669.22845458, 33.433494567, 9.2269992828)
end)
menu.toggle_loop(Union_Depository, "自动收集财物", {}, "", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 135) then
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 237, 1)
        util.yield(30)
    end
end)
menu.click_slider(Union_Depository, "传送到 黄金", {}, "", 1, 2, 1, 1, function(value)
    if value == 1 then
        teleport2(-1.0207999944, -658.67407226, 16.114368438, 57.365200042)
    elseif value == 2 then
        teleport2(11.32310009, -663.40380859, 16.1140213, 246.14199829)
    end
end)
menu.toggle_loop(Union_Depository, "删除 警察和特警", {}, "", function()
    for _, ped_ptr in pairs(entities.get_all_peds_as_pointers()) do
        local hash = entities.get_model_hash(ped_ptr)
        if hash == 1581098148 or hash == -1320879687 or hash == -1920001264 then
            entities.delete(ped_ptr)
        end
    end
end)
menu.action(Union_Depository, "传送进 脱身车", {}, "", function()
    local ent = get_entity_from_blip(HUD.GET_NEXT_BLIP_INFO_ID(326))
    if ent ~= 0 then
        tp_into_vehicle(ent, -1)
    end
end)

--#endregion Union Depository




-----------------------------
--------    About    --------
-----------------------------

local Menu_About <const> = menu.list(Menu_Root, "关于", {}, "")

menu.readonly(Menu_About, "Author", "Rostal")
menu.hyperlink(Menu_About, "Github", "https://github.com/TCRoid/Stand-_-Lua-_-Scripts")
menu.readonly(Menu_About, "Version", SCRIPT_VERSION)
menu.readonly(Menu_About, "Support GTAO Version", SUPPORT_GTAO)
menu.readonly(Menu_About, "Current GTAO Version", NETWORK.GET_ONLINE_VERSION())
