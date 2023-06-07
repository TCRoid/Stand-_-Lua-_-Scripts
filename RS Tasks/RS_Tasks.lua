-------------------------------
--- Author: Rostal
-------------------------------

util.keep_running()
util.require_natives("1681379138")

local SCRIPT_VERSION <const> = "2023/6/7"

local SUPPORT_GTAO <const> = 1.66




-------------------------
-- Functions
-------------------------

local function SET_ENTITY_COORDS(entity, coords)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entity, coords.x, coords.y, coords.z, true, false, false)
end

local function GET_VEHICLE_PED_IS_IN(ped)
    if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        return PED.GET_VEHICLE_PED_IS_IN(ped, false)
    end
    return false
end

local function IS_PED_PLAYER(ped)
    if ENTITY.IS_ENTITY_A_PED(ped) then
        if PED.GET_PED_TYPE(ped) >= 4 then
            return false
        else
            return true
        end
    end
    return false
end

local function ADD_MP_INDEX(stat)
    local Exceptions = {
        "MP_CHAR_STAT_RALLY_ANIM",
        "MP_CHAR_ARMOUR_1_COUNT",
        "MP_CHAR_ARMOUR_2_COUNT",
        "MP_CHAR_ARMOUR_3_COUNT",
        "MP_CHAR_ARMOUR_4_COUNT",
        "MP_CHAR_ARMOUR_5_COUNT",
    }
    for _, exception in pairs(Exceptions) do
        if stat == exception then
            return "MP" .. util.get_char_slot() .. "_" .. stat
        end
    end

    if not string.contains(stat, "MP_") and not string.contains(stat, "MPPLY_") then
        return "MP" .. util.get_char_slot() .. "_" .. stat
    end
    return stat
end

local function STAT_SET_INT(stat, value)
    STATS.STAT_SET_INT(util.joaat(ADD_MP_INDEX(stat)), value, true)
end

local function STAT_GET_INT(stat)
    local IntPTR = memory.alloc_int()
    STATS.STAT_GET_INT(util.joaat(ADD_MP_INDEX(stat)), IntPTR, -1)
    return memory.read_int(IntPTR)
end

local function teleport(x, y, z, heading)
    PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), x, y, z)

    if heading ~= nil then
        ENTITY.SET_ENTITY_HEADING(players.user_ped(), heading)
    end
end

local function tp_ent_to_me(ent, offsetX, offsetY, offsetZ)
    offsetX = offsetX or 0.0
    offsetY = offsetY or 0.0
    offsetZ = offsetZ or 0.0
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), offsetX, offsetY, offsetZ)
    SET_ENTITY_COORDS(ent, coords)
end

local function tp_into_vehicle(vehicle, seat)
    if ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(vehicle, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_TEAMS(vehicle, false)
        VEHICLE.SET_DONT_ALLOW_PLAYER_TO_ENTER_VEHICLE_IF_LOCKED_FOR_PLAYER(vehicle, false)

        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, false)
        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 0, true) -- left front door

        seat = seat or -1
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, seat)
    end
end

local function delete_ped(ped, hash)
    if PED.IS_PED_MODEL(ped, hash) then
        entities.delete(ped)
    end
end

local function delete_vehicle(vehicle, hash)
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        entities.delete(vehicle)
    end
end

local function auto_collect()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 135) then
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 237, 1)
        util.yield(30)
    end
end




-------------------------
-- Menu
-------------------------
local menu_root = menu.my_root()

menu.divider(menu_root, "RS Tasks")




-------------------------
-- Cayo Perico
-------------------------
local Cayo_Perico = menu.list(menu_root, "佩里科岛", {}, "")

local cayo_perico_help = "要求: 单人,非首次上岛\n侦查完主要目标后,设置次要目标为全黄金\n进行任务时,需要拿满背包\n开启任务时,若是两人则分红比例为50%平分"
menu.action(Cayo_Perico, "说明", {}, cayo_perico_help, function()
end)

----- Presets -----
local Cayo_Perico_Presets = menu.list(Cayo_Perico, "前置", {}, "")

local cayo_perico_presets = {
    menu_target_value = nil,
    target_value = 2400000,

    menu_gold_value = nil,
    gold_value = 333333,
}

cayo_perico_presets.menu_target_value = menu.slider(Cayo_Perico_Presets, "到账金额", { "rs_cp_target" }, "",
    0, 3000000, 2400000, 10000, function(value)
        cayo_perico_presets.target_value = value
    end)

menu.divider(Cayo_Perico_Presets, "次要目标")
menu.action(Cayo_Perico_Presets, "计算 黄金价格[单人]", {}, "", function()
    --Primary
    local primary_value = 900000
    local primary = STAT_GET_INT("H4CNF_TARGET")
    if primary == 1 then
        primary_value = 1000000
    elseif primary == 2 then
        primary_value = 1100000
    elseif primary == 3 then
        primary_value = 1300000
    elseif primary == 4 then
        primary_value = 1100000
    elseif primary == 5 then
        primary_value = 1900000
    end

    --Difficulty
    local difficulty_multiplier = 1.0
    if STAT_GET_INT("H4_PROGRESS") == 131055 then
        difficulty_multiplier = 1.1
    end

    primary_value = primary_value * difficulty_multiplier
    local target_value = cayo_perico_presets.target_value / 0.88
    local take_value = target_value - primary_value
    local gold_value = math.floor(take_value * 0.6666666)

    menu.set_value(cayo_perico_presets.menu_gold_value, gold_value)
end)
menu.action(Cayo_Perico_Presets, "计算 黄金价格[两人][UNTEST]", {}, "", function()
    --Primary
    local primary_value = 900000
    local primary = STAT_GET_INT("H4CNF_TARGET")
    if primary == 1 then
        primary_value = 1000000
    elseif primary == 2 then
        primary_value = 1100000
    elseif primary == 3 then
        primary_value = 1300000
    elseif primary == 4 then
        primary_value = 1100000
    elseif primary == 5 then
        primary_value = 1900000
    end

    --Difficulty
    local difficulty_multiplier = 1.0
    if STAT_GET_INT("H4_PROGRESS") == 131055 then
        difficulty_multiplier = 1.1
    end

    primary_value = primary_value * difficulty_multiplier
    local target_value = cayo_perico_presets.target_value / 0.88 / 0.5
    local take_value = target_value - primary_value
    local gold_value = math.floor(take_value * 0.6666666)

    menu.set_value(cayo_perico_presets.menu_gold_value, gold_value)
end)
cayo_perico_presets.menu_gold_value = menu.slider(Cayo_Perico_Presets, "黄金价格", { "rs_cp_gold_value" }, "",
    0, 3000000, 333333, 10000, function(value)
        cayo_perico_presets.gold_value = value
    end)
menu.action(Cayo_Perico_Presets, "设置为 全黄金", {}, "", function()
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
    STAT_SET_INT("H4LOOT_GOLD_I", -1)
    STAT_SET_INT("H4LOOT_GOLD_C", -1)
    STAT_SET_INT("H4LOOT_GOLD_V", cayo_perico_presets.gold_value)

    STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 0)
    STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
    STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
    STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
    STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 0)
    STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
    STAT_SET_INT("H4LOOT_PAINT_SCOPED", 0)
    STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", -1)
    STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", -1)

    util.toast("完成")
end)


----- Main -----
menu.toggle_loop(Cayo_Perico, "NPC署名爆炸", {}, "", function()
    for k, ped in pairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ped) and not ENTITY.IS_ENTITY_DEAD(ped) then
            local coords = ENTITY.GET_ENTITY_COORDS(ped)
            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), coords.x, coords.y, coords.z, 4, 1.0, false, false, 0.0)
        end
    end
    util.yield(500)
end)
menu.action(Cayo_Perico, "密码副本 传送到我", {}, "接近才会生成", function()
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local hash = ENTITY.GET_ENTITY_MODEL(ent)
        if hash == -832966178 then
            tp_ent_to_me(ent)
        end
    end
end)
menu.action(Cayo_Perico, "传送到 侧门", {}, "", function()
    teleport(4955.9624, -5784.6049, 20.5587, 257.2269)
end)
menu.action(Cayo_Perico, "主要目标 传送到我", {}, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(765)
    if not HUD.DOES_BLIP_EXIST(blip) then
        for k, ent in pairs(entities.get_all_objects_as_handles()) do
            local hash = ENTITY.GET_ENTITY_MODEL(ent)
            if hash == -1714533217 or hash == 1098122770 then
                ENTITY.SET_ENTITY_HEALTH(ent, 0)
            end
        end
        util.yield(1000)
    end

    blip = HUD.GET_NEXT_BLIP_INFO_ID(765)
    if HUD.DOES_BLIP_EXIST(blip) then
        local ent = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(blip)
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            tp_ent_to_me(ent)
        end
    else
        util.toast("未找到")
    end
end)
menu.toggle_loop(Cayo_Perico, "模拟鼠标左键收集财物", {}, "", function()
    auto_collect()
end)
menu.click_slider(Cayo_Perico, "传送到 黄金", {}, "", 1, 2, 1, 1, function(value)
    if value == 1 then
        teleport(5028.7109, -5734.5815, 17.5656, 322.0389)
    elseif value == 2 then
        teleport(5030.2519, -5737.1855, 17.5656, 141.6678)
    end
end)
menu.action(Cayo_Perico, "传送到 正门", {}, "", function()
    teleport(4990.0386, -5717.6895, 19.380217, 50)
end)
menu.action(Cayo_Perico, "传送到 海洋撤离点", {}, "", function()
    teleport(4771.479, -6165.737, -38.079613)
end)





-------------------------
-- Union Depository
-------------------------
local Union_Depository = menu.list(menu_root, "联合储蓄", {}, "")

menu.action(Union_Depository, "说明", {}, "无", function()
end)

----- Main -----
menu.toggle_loop(Union_Depository, "禁止为玩家调度警察", {}, "不会一直刷出新的警察，最好在被通缉前开启"
, function()
    PLAYER.SET_DISPATCH_COPS_FOR_PLAYER(PLAYER.PLAYER_ID(), false)
end, function()
    PLAYER.SET_DISPATCH_COPS_FOR_PLAYER(PLAYER.PLAYER_ID(), true)
end)
menu.action(Union_Depository, "传送进 保安车", {}, "", function()
    for k, veh in pairs(entities.get_all_vehicles_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(veh) then
            local hash = ENTITY.GET_ENTITY_MODEL(veh)
            if hash == 470404958 then
                tp_into_vehicle(veh)
            end
        end
    end
end)
menu.action(Union_Depository, "传送到 刷卡位置", {}, "", function()
    teleport(11.8479, -669.2319, 33.049, 9.227)
end)
menu.toggle_loop(Union_Depository, "模拟鼠标左键收集财物", {}, "", function()
    auto_collect()
end)
menu.click_slider(Union_Depository, "传送到 黄金", {}, "", 1, 2, 1, 1, function(value)
    if value == 1 then
        teleport(-1.0208, -658.6741, 15.8306, 57.3652)
    elseif value == 2 then
        teleport(11.3231, -663.4038, 15.8306, 246.1420)
    end
end)
menu.toggle_loop(Union_Depository, "删除警察", {}, "删除警察和特警", function()
    for k, ped in pairs(entities.get_all_peds_as_handles()) do
        delete_ped(ped, 1581098148)
        delete_ped(ped, -1320879687)
        delete_ped(ped, -1920001264)
    end
end)
menu.action(Union_Depository, "传送进 脱身车", {}, "", function()
    for k, veh in pairs(entities.get_all_vehicles_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(veh) then
            local blip = HUD.GET_BLIP_FROM_ENTITY(veh)
            if HUD.DOES_BLIP_EXIST(blip) and HUD.GET_BLIP_SPRITE(blip) == 326 then
                tp_into_vehicle(veh)
            end
        end
    end
end)










-------------------------
-- 关于
-------------------------
local About_options = menu.list(menu_root, "关于", {}, "")

menu.readonly(About_options, "Author", "Rostal")
menu.hyperlink(About_options, "Github", "https://github.com/TCRoid/Stand-Lua-RScript")
menu.readonly(About_options, "Version", SCRIPT_VERSION)
menu.readonly(About_options, "Support GTAO Version", SUPPORT_GTAO)
