---
--- Created by Rostal.
--- DateTime: 2022/10/24
---

util.require_natives("natives-1663599433")
util.keep_running()

--沙漠
--[国安局特工] Model Hash: -1920001264   Entity Type: Ped
--[国安局特工 SUV车] Model Hash: 1922257928  Entity Type: Vehicle
--[警察] Model Hash: -1320879687   Entity Type: Ped
--[警车 白色] Model Hash: -1683328900   Entity Type: Vehicle
--[直升机] Model Hash: 353883353   Entity Type: Vehicle 坐里面的是国安局特工
--
--市区
--[警察] Model Hash: 1581098148   Entity Type: Ped
--[警车 黑色] Model Hash: 1912215274   Entity Type: Vehicle
--[特警 SUV车] Model Hash: -1647941228   Entity Type: Vehicle 坐里面的是国安局特工

local no_police = false
local no_swat = false
local no_police_car = false
local no_police_heli = false
local no_swat_suv = false
local remove_police_weapon = false

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

local function remove_ped_weapon(ped, hash)
    if PED.IS_PED_MODEL(ped, hash) then
        WEAPON.REMOVE_ALL_PED_WEAPONS(ped)
        PED.SET_PED_CAN_SWITCH_WEAPON(ped, false)
    end
end

menu.toggle_loop(menu.my_root(), "Enable", {}, "", function()
    
    --- ped
    if no_police or no_swat or remove_police_weapon then
        local peds = entities.get_all_peds_as_handles()
        for _, ped in ipairs(peds) do
            if remove_police_weapon then
                remove_ped_weapon(ped, 1581098148)
                remove_ped_weapon(ped, -1320879687)
                remove_ped_weapon(ped, -1920001264)
            end

            if no_police then
                delete_ped(ped, 1581098148)
                delete_ped(ped, -1320879687)
            end

            if no_swat then
                delete_ped(ped, -1920001264)
            end

        end
    end

    --- vehicle
    if no_police_car or no_police_heli or no_swat_suv then
        local vehicles = entities.get_all_vehicles_as_handles()
        for _, veh in ipairs(vehicles) do
            if no_police_car then
                delete_vehicle(veh, 1912215274)
                delete_vehicle(veh, -1683328900)
            end

            if no_police_heli then
                delete_vehicle(veh, 353883353)
            end

            if no_swat_suv then
                delete_vehicle(veh, 1922257928)
                delete_vehicle(veh, -1647941228)
            end
        end
    end

end)

menu.divider(menu.my_root(), "")

menu.toggle(menu.my_root(), "No Police", {}, "Delete police", function(toggle)
    no_police = toggle
end)

menu.toggle(menu.my_root(), "No Swat", {}, "Delete swat", function(toggle)
    no_swat = toggle
end)

menu.toggle(menu.my_root(), "No Police Car", {}, "Only delete vehicle", function(toggle)
    no_police_car = toggle
end)

menu.toggle(menu.my_root(), "No Police Helicopters", {}, "Only delete vehicle", function(toggle)
    no_police_heli = toggle
end)

menu.toggle(menu.my_root(), "No Swat SUV", {}, "Only delete vehicle", function(toggle)
    no_swat_suv = toggle
end)

menu.toggle(menu.my_root(), "Remove Police Weapon", {}, "", function(toggle)
    remove_police_weapon = toggle
end)
