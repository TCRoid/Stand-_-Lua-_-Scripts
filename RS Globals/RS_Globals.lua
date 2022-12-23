---------------------------
--- Author: Rostal
---------------------------

util.require_natives("natives-1663599433")
util.keep_running()

-- 脚本版本
local Script_Version <const> = "2022/12/17"

-- 支持的GTA线上版本
local Support_GTAO <const> = 1.64


-- Globals 原生数据
local Globals_Raw_Data = {
    {
        menu = "Multiplier",
        items = {
            { "XP Multiplier", 262145 + 1, "float", 1 },
            { "Max Health Multiplier", 262145 + 107, "float", 1 },
            { "Min Health Multiplier", 262145 + 108, "float", 1 },
            { "Health Regen Rate Multiplier", 262145 + 109, "float", 1 },
            { "Health Regen Max Multiplier", 262145 + 110, "float", 1 },
            { "Max Armour Multiplier", 262145 + 112, "float", 1 },
            { "Ped Drop Cash Multiplier", 262145 + 173, "float", 0 },
            { "Cash Drop Multiplier", 262145 + 4738, "float", 5 },
            { "Wanted Level Multiplier", 262145 + 9387, "float", 1000 },
            { "Wanted Level Time Multiplier", 262145 + 9388, "float", 10 },
        }
    },

    {
        menu = "车友会声望倍数",
        items = {
            { "Street Race", 262145 + 31648, "float", 1 },
            { "Pursuit Race", 262145 + 31649, "float", 1 },
            { "Scramble", 262145 + 31650, "float", 1 },
            { "Head 2 Head", 262145 + 31651, "float", 1 },
            { "LS Car Meet", 262145 + 31653, "float", 1 },
            { "LS Car Meet Track", 262145 + 31654, "float", 1 },
            { "LS Car Meet Cloth Shop", 262145 + 31655, "float", 1 },
            { "Auto Shop Contract Setup", 262145 + 31681, "float", 1 },
            { "Auto Shop Contract Finale", 262145 + 31682, "float", 1 },
            { "Auto Shop Car Delivery", 262145 + 31683, "float", 1 },
            { "Exotic Export Delivery", 262145 + 31684, "float", 1 },
        }
    },

    {
        menu = "CEO 技能",
        items = {
            { menu = "费用", items = {
                { "Drop Ammo Cost", 262145 + 12847, "int", 1000 },
                { "Drop Armor Cost", 262145 + 12848, "int", 1500 },
                { "Drop Bull Shark Cost", 262145 + 12849, "int", 1000 },
                { "Ghost Organization Cost", 262145 + 12850, "int", 12000 },
                { "Bribe Authorities Cost", 262145 + 12851, "int", 15000 },
                { "Request Luxury Helicopter", 262145 + 15890, "int", 5000 },
                { "securoServCeo Change Organization Name", 262145 + 15891, "int", 50000 },
                { "HELI_PICKUP", 262145 + 15887, "int", 10000 },
            } },
            { menu = "冷却时间", items = {
                { "Drop Ammo Cooldown", 262145 + 12834, "int", 30000 },
                { "Drop Armor Cooldown", 262145 + 12835, "int", 30000 },
                { "Drop Bullshark Cooldown", 262145 + 12836, "int", 30000 },
                { "Ghost Organization Cooldown", 262145 + 12837, "int", 600000 },
                { "Bribe Authorities Cooldown", 262145 + 12838, "int", 600000 },
            } },
            { menu = "技能时间", items = {
                { "Ghost Organization Duration", 262145 + 13149, "int", 180000 },
                { "Bribe Authorities Duration", 262145 + 13150, "int", 120000 },
            } },
        }
    },

    {
        menu = "CEO 载具",
        items = {
            { menu = "费用", items = {
                { "Turreted Limo", 262145 + 12842, "int", 20000 },
                { "Cognoscenti (Armored)", 262145 + 12843, "int", 5000 },
                { "Schafter LWB (Armored)", 262145 + 12844, "int", 5000 },
                { "Baller LE LWB (Armored)", 262145 + 12845, "int", 5000 },
                { "Buzzard Attack Chopper", 262145 + 12846, "int", 25000 },
                { "Enduro", 262145 + 15959, "int", 5000 },
                { "Dune Buggy", 262145 + 15960, "int", 5000 },
                { "Mesa", 262145 + 15961, "int", 5000 },
                { "Volatus", 262145 + 15968, "int", 10000 },
                { "Rumpo Custom", 262145 + 15969, "int", 7000 },
                { "Brickade", 262145 + 15970, "int", 9000 },
                { "Dinghy", 262145 + 15971, "int", 5000 },
                { "XLS", 262145 + 15972, "int", 5000 },
                { "Havok", 262145 + 15973, "int", 5000 },
                { "Super Diamond", 262145 + 19302, "int", 5000 },
                { "Supervolito", 262145 + 19304, "int", 10000 },
            } },
        }
    },

    {
        menu = "VIP/CEO 工作",
        items = {
            { menu = "冷却时间", items = {
                { "Vip Ceo Work Cooldown", 262145 + 13081, "int", 300000 },
                { "Vip Ceo Challenge Cooldown", 262145 + 13082, "int", 180000 },
            } },
            { menu = "猎杀专员", items = {
                { "Mission Time", 262145 + 15473, "int", 900000 },
                { "1st Target Wanted", 262145 + 15474, "int", 0 },
                { "2nd Target Wanted", 262145 + 15475, "int", 1 },
                { "3rd Target Wanted", 262145 + 15476, "int", 2 },
                { "Wanted Persists Death", 262145 + 15477, "int", 1 },
                { "Target Health", 262145 + 15478, "int", 220 },
                { "Target Accuracy", 262145 + 15479, "float", 30 },
                { "Security Health", 262145 + 15480, "int", 300 },
                { "Security Accuracy", 262145 + 15481, "float", 30 },
                { "Req Players", 262145 + 15482, "int", 1 },
                { "Cooldown", 262145 + 15483, "int", 600000 },
                { "Cash Per Target", 262145 + 15484, "int", 5000 },
                { "RP Per Target", 262145 + 15485, "int", 500 },
                { "Bonus Cash", 262145 + 15486, "int", 500 },
                { "Bonus RP", 262145 + 15487, "int", 100 },
            } },
            { menu = "观光客", items = {
                { "Mission Time", 262145 + 12977, "int", 900000 },
                { "Cooldown", 262145 + 12978, "int", 600000 },
                { "Number of Packages", 262145 + 12979, "int", 3 },
                { "Minimun Distance to Next Package", 262145 + 12980, "int", 1000 },
                { "Default Cash Reward", 262145 + 12981, "int", 20000 },
                { "Default RP Reward", 262145 + 12982, "int", 2000 },
                { "Bonus Cash", 262145 + 12983, "int", 500 },
                { "Bonus RP", 262145 + 12984, "int", 100 },
                { "Participation Threshold Distance", 262145 + 12985, "int", 100 },
                { "Cash Multiplier", 262145 + 12986, "float", 1 },
                { "RP Multiplier", 262145 + 12987, "float", 1 },
            } },
        }
    },

    {
        menu = "富兰克林合约任务",
        items = {
            { menu = "电话暗杀", items = {
                { "Payphone Hit Cooldown", 262145 + 31781, "int", 1200000 },
                { "Standard Kill Method Cash Reward", 262145 + 31727, "int", 15000 },
                { "Bonus Kill Method Cash Reward", 262145 + 31728, "int", 70000 },
                { "Goon Bonus Kill Method Cash Reward", 262145 + 31730, "int", 30000 },
                { "Goon Participation RP Reward", 262145 + 31732, "int", 400 },
                { "Target Elimination RP Reward", 262145 + 31733, "int", 250 },
                { "RP Reward", 262145 + 31731, "int", 1000 },
            } },
            { menu = "安保合约", items = {
                { "Security Contract Refresh Time", 262145 + 31700, "int", 3600000 },
                { "Security Contract Cooldown", 262145 + 31701, "int", 300000 },
                { "Professional Min", 262145 + 31734 + 1, "int", 15000 },
                { "Specialist Min", 262145 + 31738 + 1, "int", 21000 },
                { "Specialist+ Min", 262145 + 31734 + 2, "int", 22000 },
                { "Professional Max", 262145 + 31738 + 2, "int", 28000 },
                { "Specialist Max", 262145 + 31734 + 3, "int", 30000 },
                { "Specialist+ Max", 262145 + 31738 + 3, "int", 35000 },
            } },
        }
    },

    {
        menu = "恐霸客户差事",
        items = {
            { menu = "冷却时间", items = {
                { "Between Jobs Cooldown", 262145 + 24636, "int", 300000 },
                { "Robbery In Progress Cooldown", 262145 + 24637, "int", 1800000 },
                { "Data Sweep Cooldown", 262145 + 24638, "int", 1800000 },
                { "Targeted Data Cooldown", 262145 + 24639, "int", 1800000 },
                { "Diamond Shopping Cooldown", 262145 + 24640, "int", 1800000 },
                { "Collectors Pieces Cooldown", 262145 + 24642, "int", 600000 },
                { "Deal Breaker Cooldown", 262145 + 24643, "int", 600000 },
            } },
        }
    },

    {
        menu = "改装铺客户改车",
        items = {
            { "Vehicle Cooldown", 262145 + 31126, "int", 2880 },
            { "% Chance", 262145 + 31127, "int", 50 },
            { "2 Lifts Cooldown Multiplier", 262145 + 31128, "float", 0.5 },
            { "Extra Time", 262145 + 31132, "int", 600 },
            { "Low Tier Delivery Payout", 262145 + 31136, "int", 20000 },
            { "Mid Tier Delivery Payout", 262145 + 31137, "int", 25000 },
            { "High Tier Delivery Payout", 262145 + 31138, "int", 30000 },
        }
    },

    {
        menu = "石斧",
        items = {
            { "Weapon Defense Multiplier", 262145 + 25297, "float", 0.5 },
            { "Health Recharge Multiplier", 262145 + 25300, "float", 2 },
            { "Health Recharge Limit", 262145 + 25301, "float", 1 },
            { "Duration", 262145 + 25302, "int", 12000 },
            { "Added Duration Per Kill", 262145 + 25303, "int", 6000 },
            { "Cooldown", 262145 + 25304, "int", 60000 },
        }
    },

    {
        menu = "佩里科岛抢劫",
        items = {
            { menu = "主要目标价值", items = {
                { "Tequilla", 262145 + 29982, "int", 900000 },
                { "Ruby Necklace", 262145 + 29983, "int", 1000000 },
                { "Bearer Bonds", 262145 + 29984, "int", 1100000 },
                { "Pink Diamond", 262145 + 29985, "int", 1300000 },
                { "Madrazo Files", 262145 + 29986, "int", 1100000 },
                { "Black Panther", 262145 + 29987, "int", 1900000 },
            } },
            { menu = "次要目标价值", items = {
                { "Cash Min", 262145 + 29754, "int", 87500 },
                { "Cash Max", 262145 + 29755, "int", 92500 },
                { "Weed Min", 262145 + 29756, "int", 145000 },
                { "Weed Max", 262145 + 29757, "int", 150000 },
                { "Cocaine Min", 262145 + 29758, "int", 220000 },
                { "Cocaine Max", 262145 + 29759, "int", 225000 },
                { "Gold Min", 262145 + 29760, "int", 328333 },
                { "Gold Max", 262145 + 29761, "int", 333333 },
                { "Artwork Min", 262145 + 29762, "int", 175000 },
                { "Artwork Max", 262145 + 29763, "int", 200000 },
            } },
            { menu = "次要目标每单位占用背包空间", items = {
                { "Cash - 45 units", 262145 + 29733, "float", 10 },
                { "Cocaine - 45 units", 262145 + 29734, "float", 20 },
                { "Weed - 45 units", 262145 + 29735, "float", 15 },
                { "Gold - 24 units", 262145 + 29736, "float", 50 },
                { "Artwork", 262145 + 29737, "float", 900 },
            } },
            { menu = "其它", items = {
                { "Normal Difficulty Multiplier", 262145 + 29988, "float", 1 },
                { "Hard Difficulty Multiplier", 262145 + 29989, "float", 1 },
                { "Fencing Fee", 262145 + 29991, "float", -0.1 },
                { "Pavel Cut", 262145 + 29992, "float", -0.02 },
                { "Office Safe Cash Min", 262145 + 29764, "int", 50000 },
                { "Office Safe Cash Max", 262145 + 29765, "int", 99000 },
            } },
        }
    },

    {
        menu = "其它",
        items = {
            { "AI Health", 262145 + 165, "float", 1 },
            { "Turn Snow on/off", 262145 + 4752, "int", 0 },
            { "Time Needed For Good Boy Cash Award (Don't set too low it will cause transaction errors)", 262145 + 145,
                "int", 18000000 },
            { "Boy Cash Award (Transaction Max is 2.5k i think)", 262145 + 85, "int", 2000 },
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

local function SET_INT_LOCAL(Script, Local, Value)
    if memory.script_local(Script, Local) ~= 0 then
        memory.write_int(memory.script_local(Script, Local), Value)
    end
end

local function SET_FLOAT_LOCAL(Script, Local, Value)
    if memory.script_local(Script, Local) ~= 0 then
        memory.write_float(memory.script_local(Script, Local), Value)
    end
end

local function GET_INT_LOCAL(Script, Local)
    if memory.script_local(Script, Local) ~= 0 then
        local Value = memory.read_int(memory.script_local(Script, Local))
        if Value ~= nil then
            return Value
        end
    end
end

local function GET_FLOAT_LOCAL(Script, Local)
    if memory.script_local(Script, Local) ~= 0 then
        local Value = memory.read_float(memory.script_local(Script, Local))
        if Value ~= nil then
            return Value
        end
    end
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

local function generate_global_comands(command_parent, data)
    local global = data[2]
    local value_type = data[3]
    local default_value = tonumber(data[4])

    menu.readonly(command_parent, "Global", global)

    local global_value = default_value
    if value_type == "int" then
        menu.slider(command_parent, "值", { global .. "value" }, "", -16777216, 16777216, default_value, 1,
            function(value)
                global_value = value
            end)
    elseif value_type == "float" then
        menu.slider_float(command_parent, "值", { global .. "value" }, "", -1000000, 1000000,
            default_value * 100,
            10, function(value)
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

local function generate_global_menu(tbl, menu_parent, menu_name)
    if menu_name ~= nil then
        menu_parent = menu.list(menu_parent, menu_name, {}, "")
    end

    local is_menu = true
    for key, value in pairs(tbl) do
        if value.menu ~= nil then
            generate_global_menu(value.items, menu_parent, value.menu)
        else
            is_menu = false
        end
    end

    if not is_menu then
        for k, v in pairs(tbl) do
            local command_parent = menu.list(menu_parent, v[1], {}, "")
            generate_global_comands(command_parent, v)
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

generate_global_menu(Globals_Raw_Data, menu_root)

local tool_options = menu.list(menu_root, "工具", {}, "")
menu.toggle_loop(tool_options, "显示锁定的Globals", {}, "", function()
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
menu.action(tool_options, "取消锁定所有Globals", {}, "", function()
    for k, v in pairs(lock_global_toggle_list) do
        if menu.is_ref_valid(v) then
            menu.set_value(v, false)
        end
    end
end)



-----------------
menu.divider(menu_root, "")
local about_options = menu.list(menu_root, "关于", {}, "")
menu.readonly(about_options, "Author", "Rostal")
menu.hyperlink(about_options, "Github", "https://github.com/TCRoid/Stand-_-Lua-_-Scripts")
menu.readonly(about_options, "Version", Script_Version)
menu.readonly(about_options, "Support GTAO Version", Support_GTAO)
