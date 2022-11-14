--- Author: Rostal
--- Last edit date: 2022/11/10

util.require_natives("natives-1663599433")
util.keep_running()

local Support_GTAO = 1.63

-- Globals 原生数据
--  ["menu name"] = {
--     { name, global_adress, value_type, default_value },
-- }
local Globals_Raw_Data = {
    {
        menu = "Multiplier",
        items = {
            { "XP", 262145 + 1, "float", 1.0 },
            { "最大生命值", 262145 + 106, "float", 1.0 },
            { "最低生命值", 262145 + 107, "float", 1.0 },
            { "生命恢复速度", 262145 + 108, "float", 1.0 },
            { "生命恢复最大程度", 262145 + 109, "float", 1.0 },
            { "最大护甲值", 262145 + 111, "float", 1.0 },
        }
    },

    {
        menu = "车友会声望倍数",
        items = {
            { "改装铺合约 前置", 262145 + 31669, "float", 1.0 },
            { "改装铺合约 终章", 262145 + 31670, "float", 1.0 },
            { "Auto Shop Car Delivery", 262145 + 31671, "float", 1.0 },
            { "每日载具出口", 262145 + 31672, "float", 1.0 },
        }
    },

    {
        menu = "CEO 技能",
        items = {
            { menu = "空投弹药", items = {
                { "费用", 262145 + 12844, "int", 1000 },
                { "冷却时间", 262145 + 12831, "int", 30000 },
            } },
            { menu = "空投防弹衣", items = {
                { "费用", 262145 + 12845, "int", 1500 },
                { "冷却时间", 262145 + 12832, "int", 30000 },
            } },
            { menu = "空投牛鲨睾酮", items = {
                { "费用", 262145 + 12846, "int", 1000 },
                { "冷却时间", 262145 + 12833, "int", 30000 },
            } },
            { menu = "幽灵组织", items = {
                { "费用", 262145 + 12847, "int", 12000 },
                { "冷却时间", 262145 + 12834, "int", 600000 },
                { "时间", 262145 + 13146, "int", 180000 },
            } },
            { menu = "贿赂当局", items = {
                { "费用", 262145 + 12848, "int", 15000 },
                { "冷却时间", 262145 + 12835, "int", 600000 },
                { "时间", 262145 + 13147, "int", 120000 },
            } },
            { menu = "请求豪华直升机", items = {
                { "费用", 262145 + 15945, "int", 5000 },
            } },
            { menu = "更改组织名称", items = {
                { "费用", 262145 + 15946, "int", 50000 },
            } },
        }
    },

    {
        menu = "CEO 载具",
        items = {
            { menu = "费用", items = {
                { "武装礼车", 262145 + 12839, "int", 20000 },
                { "秃鹰攻击直升机", 262145 + 12843, "int", 25000 },
            } },
        }
    },

    {
        menu = "VIP/CEO 工作",
        items = {
            { menu = "猎杀专员", items = {
                { "冷却时间", 262145 + 15523, "int", 600000 },
                { "任务时间", 262145 + 15528, "int", 900000 },
                { "Bonus Cash", 262145 + 15541, "int", 500 },
            } },
            { menu = "观光客", items = {
                { "冷却时间", 262145 + 12975, "int", 600000 },
                { "任务时间", 262145 + 12974, "int", 900000 },
                { "Bonus Cash", 262145 + 12980, "int", 500 },
                { "Base Cash", 262145 + 12978, "int", 20000 },
            } },
        }
    },

    {
        menu = "富兰克林合约任务",
        items = {
            { menu = "电话暗杀", items = {
                { "Payphone Hit Cooldown", 262145 + 31769, "int", 1200000 },
                { "Payphone Hit Payment", 262145 + 31715, "int", 15000 },
            } },
            { menu = "安保合约", items = {
                { "Security Hit Cooldown", 262145 + 31689, "int", 300000 },
                { "Professional Min Payment", 262145 + 31722 + 1, "int", 31000 },
                { "Specialist Min Payment", 262145 + 31722 + 2, "int", 44000 },
                { "Specialist+ Min Payment", 262145 + 31722 + 3, "int", 60000 },
                { "Professional Max Payment", 262145 + 31726 + 1, "int", 42000 },
                { "Specialist Max Payment", 262145 + 31726 + 2, "int", 56000 },
                { "Specialist+ Max Payment", 262145 + 31726 + 3, "int", 70000 },
            } },
        }
    },

    {
        menu = "恐霸客户差事",
        items = {
            { menu = "冷却时间", items = {
                { "Between Jobs", 262145 + 24664, "int", 300000 },
                { "Robbery In Progress", 262145 + 24665, "int", 1800000 },
                { "Data Sweep", 262145 + 24666, "int", 1800000 },
                { "Targeted Data", 262145 + 24667, "int", 1800000 },
                { "Diamond Shopping", 262145 + 24668, "int", 1800000 },
                { "Collectors Pieces", 262145 + 24670, "int", 600000 },
                { "Deal Breaker", 262145 + 24671, "int", 600000 },
            } },
        }
    },

    {
        menu = "石斧",
        items = {
            { "Weapon Defense Multiplier", 262145 + 25325, "float", 0.5 },
            { "Health Recharge Multiplier", 262145 + 25328, "float", 2.0 },
            { "Health Recharge Limit", 262145 + 25329, "float", 1.0 },
            { "Duration", 262145 + 25330, "int", 12000 },
            { "Added Duration Per Kill", 262145 + 25331, "int", 6000 },
            { "Cooldown", 262145 + 25332, "int", 60000 },
        }
    },

    {
        menu = "其它",
        items = {
            { "AI 血量倍数", 262145 + 164, "float", 1.0 },
            { "PED_DROP_CASH_MULTIPLIER", 262145 + 172, "float", 1.0 },
            { "CASH_DROP_MULTIPLIER", 262145 + 4737, "float", 5.0 },
            { "WANTED_LEVEL_BAIL_MULTIPLIER", 262145 + 4738, "float", 1.0 },
            { "战局雪天", 262145 + 4751, "int", 0 },
            { "情人节 活动", 262145 + 7058, "int", 1 },
            { "万圣节 活动", 262145 + 11993, "int", 0 },
            { "良好奖励需要等待的时间", 262145 + 144, "int", 18000000 },
            { "良好奖励金额", 262145 + 85, "int", 2000 },
        }
    },

    {
        menu = "生存战",
        items = {
            { "XP_TUNABLE_SURVIVAL_WAVE_REACHED", 262145 + 4287, "float", 1.0 },
            { "XP_TUNABLE_SURVIVAL_ENEMY_KILL", 262145 + 4288, "float", 1.0 },
            { "XP_TUNABLE_SURVIVAL_VEHICLE_DESTROYED", 262145 + 4289, "float", 1.0 },

            { "ON_CALL_TIMEOUT_SURVIVAL_STAGE_1", 262145 + 4610, "int", 600000 },
            { "ON_CALL_TIMEOUT_SURVIVAL_STAGE_2", 262145 + 4622, "int", 600000 },
            { "ON_CALL_TIMEOUT_SURVIVAL_STAGE_3", 262145 + 4634, "int", 600000 },

            { "ENTRANCE_FEE_SURVIVAL_EXPENDITURE_TUNABLE", 262145 + 4448, "int", 200 },
            { "SURVIVAL_CASH_REWARD", 262145 + 7072, "int", 200 },
            { "SURVIVAL_RP_CAP_PER_WAVE", 262145 + 7699, "int", 1000 },
            { "SURVIVAL_COMPLETE_BONUS", 262145 + 8262, "float", 1.5 },
        }
    },
}

-- 锁定 menu.toggle_loop list
local lock_global_toggle_list = {}


----- Functions -----
local function SET_INT_GLOBAL(Global, Value)
    memory.write_int(memory.script_global(Global), Value)
end

local function SET_FLOAT_GLOBAL(Global, Value)
    memory.write_float(memory.script_global(Global), Value)
end

local function GET_INT_GLOBAL(Global)
    return memory.read_int(memory.script_global(Global))
end

local function GET_FLOAT_GLOBAL(Global)
    return memory.read_float(memory.script_global(Global))
end

local function draw_text(text)
    local scale = 0.5
    local background = {
        r = 0.0,
        g = 0.0,
        b = 0.0,
        a = 0.6
    }
    local color = {
        r = 1.0,
        g = 1.0,
        b = 1.0,
        a = 1.0
    }
    local text_width, text_height = directx.get_text_size(text, scale)

    directx.draw_rect(0.5 - 0.01, 0.0, text_width + 0.02, text_height + 0.02, background)
    directx.draw_text(0.5, 0.01, text, ALIGN_TOP_LEFT, scale, color)
end


local function generate_menu(tbl, menu_parent, menu_name)
    if menu_name ~= nil then
        menu_parent = menu.list(menu_parent, menu_name, {}, "")
    end

    local is_menu = true
    for key, value in pairs(tbl) do
        if value.menu ~= nil then
            generate_menu(value.items, menu_parent, value.menu)
        else
            is_menu = false
        end
    end

    if not is_menu then
        for k, v in pairs(tbl) do
            local command_parent = menu.list(menu_parent, v[1], {}, "")

            local global = v[2]
            local value_type = v[3]
            local default_value = v[4]
            menu.readonly(command_parent, "Global: ", global)

            local global_value = default_value
            if value_type == "int" then
                menu.slider(command_parent, "Value", { global .. "value" }, "", -16777216, 16777216, default_value, 1,
                    function(value)
                        global_value = value
                    end)
            elseif value_type == "float" then
                menu.slider_float(command_parent, "值", { global .. "value" }, "", -1000000, 1000000,
                    default_value * 100,
                    100, function(value)
                    global_value = value * 0.01
                end)
            end

            menu.action(command_parent, "读取", {}, "", function()
                if value_type == "int" then
                    util.toast(GET_INT_GLOBAL(global))
                elseif value_type == "float" then
                    util.toast(GET_FLOAT_GLOBAL(global))
                end
            end)

            menu.action(command_parent, "写入", {}, "", function()
                if value_type == "int" then
                    SET_INT_GLOBAL(global, global_value)
                elseif value_type == "float" then
                    SET_FLOAT_GLOBAL(global, global_value)
                end
            end)

            local toggle_loop = menu.toggle_loop(command_parent, "锁定", {}, "", function()
                if value_type == "int" then
                    SET_INT_GLOBAL(global, global_value)
                elseif value_type == "float" then
                    SET_FLOAT_GLOBAL(global, global_value)
                end
            end)
            table.insert(lock_global_toggle_list, toggle_loop)

            menu.action(command_parent, "恢复默认值", {}, "", function()
                if value_type == "int" then
                    SET_INT_GLOBAL(global, default_value)
                elseif value_type == "float" then
                    SET_FLOAT_GLOBAL(global, default_value)
                end
            end)

        end
    end

end


----- SCRIPT START -----
if SCRIPT_MANUAL_START then
    local GTAO = tonumber(NETWORK.GET_ONLINE_VERSION())
    if Support_GTAO ~= GTAO then
        util.toast("支持的GTA线上版本: " .. Support_GTAO .. "\n当前GTA线上版本: " .. GTAO)
    end
end


local menu_root = menu.my_root()

menu.divider(menu_root, "RS Globals")

generate_menu(Globals_Raw_Data, menu_root)

local tool_options = menu.list(menu_root, "工具", {}, "")
menu.toggle_loop(tool_options, "显示锁定的Globals", {},"",function()
    local text = ""
    for k, v in pairs(lock_global_toggle_list) do
        if menu.is_ref_valid(v) then
            if menu.get_value(v) then
                local name = menu.get_menu_name(menu.get_parent(v))
                text = text .. name .. "\n"
            end
        end
    end
    draw_text(text)
end)
menu.action(tool_options, "取消锁定所有Globals", {},"",function()
    for k, v in pairs(lock_global_toggle_list) do
        if menu.is_ref_valid(v) then
            menu.set_value(v, false)
        end
    end
end)
