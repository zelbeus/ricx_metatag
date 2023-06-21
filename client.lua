
local menuOpen = false 

local prompts = {}
local albedo_t 
local normal_t
local material_t

--------------------------------------------------------------------------------------------------------------------------------------------
local function AlbedoCreate()
    albedo_t = "<div class='albedos listing'>"
    albedo_t = albedo_t.."<input type='text' class='search-bar1 sbar' placeholder='Search Albedos'>"
    local t = nil 
    for i,v in pairs(Config.albedos) do 
        if t then 
            local startPos, endPos = string.find(v, "_vest_")
            if startPos then 
                t = t + 1
                TriggerEvent('chatMessage',"", {255, 17, 1}, v)
                Wait(1)
                if t == 300 then 
                    t = 0
                    
                    Wait(5000)
                    ExecuteCommand("clear")
                end
            end
        end
        albedo_t = albedo_t.."<div class='menu-items1 items'>"..v.."</div>"
    end
    if t then 
        Wait(30000000)
    end
    albedo_t = albedo_t.."</div>"
end
--------------------------------------------------------------------------------------------------------------------------------------------
local function NormalCreate()
    normal_t = "<div class='normals listing'>"
    normal_t = normal_t.."<input type='text' class='search-bar2 sbar' placeholder='Search Normals'>"

    for i,v in pairs(Config.normals) do 
        normal_t = normal_t.."<div class='menu-items2 items'>"..v.."</div>"
    end
    normal_t = normal_t.."</div>"
end
--------------------------------------------------------------------------------------------------------------------------------------------
local function MaterialsCreate()
    material_t = "<div class='materials listing'>"
    material_t = material_t.."<input type='text' class='search-bar3 sbar' placeholder='Search Materials'>"

    for i,v in pairs(Config.materials) do 
        material_t = material_t.."<div class='menu-items3 items'>"..v.."</div>"
    end
    material_t = material_t.."</div>"
end
--------------------------------------------------------------------------------------------------------------------------------------------
local metas = false
RegisterCommand("metatagui", function(source, args, raw)
    if not albedo_t then 
        AlbedoCreate()
    end
    if not normal_t then 
        NormalCreate()
    end
    if not material_t then 
        MaterialsCreate()
    end
    SetNuiFocus(1, 1)
    local data = [[
        <div id="ped-form">
        <div class="form-group">
          <label for="ped-id">Ped:</label>
          <input type="text" class="form-control" id="ped-id" placeholder="Enter Ped ID">
        </div>
        <div class="form-group">
          <label for="drawable-name">Drawable:</label>
          <input type="text" class="form-control" id="drawable-name" placeholder="Enter Drawable Name">
        </div>
        <div class="form-group">
          <label for="albedo-name">Albedo:</label>
          <input type="text" class="form-control" id="albedo-name" placeholder="Enter Albedo Name">
        </div>
        <div class="form-group">
          <label for="normal-name">Normal:</label>
          <input type="text" class="form-control" id="normal-name" placeholder="Enter Normal Name">
        </div>
        <div class="form-group">
          <label for="material-name">Material:</label>
          <input type="text" class="form-control" id="material-name" placeholder="Enter Material Name">
        </div>
        <div class="form-group">
            <label for="palette">Palette:</label>
            <input type="text" class="form-control" id="p1-name" placeholder="Enter Palette"> 
            <input type="range" class="form-control picker" id="p2-name" min="0" max="255" value="0">
            <input type="range" class="form-control picker" id="p3-name" min="0" max="255" value="0">
            <input type="range" class="form-control picker" id="p4-name" min="0" max="255" value="0">
        </div>
        <button type="button" class="btn btn-primary" id="submit-btn">Submit</button>
      </div>
    ]]..albedo_t..normal_t..material_t

    
    SendNUIMessage({action = "metatagui", data = data})
end)
--------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ricx_metatags:set_nui", function(data)
    local ped = tonumber(data.ped) or PlayerPedId()
    local draw = nil 
    if tonumber(data.drawable) then 
        draw = tonumber(data.drawable)
    else
        draw = GetHashKey(data.drawable)
    end
    local alb, norm, mati = GetHashKey(data.albedo), GetHashKey(data.normal), GetHashKey(data.material) 
    local texture = Citizen.InvokeNative(0xC5E7204F322E49EB, alb, norm)
    Citizen.InvokeNative(0x92DAABA2C1C10B0E, texture)
    local palette = {0,0,0,0}
    if data.p1 then 
        palette[1] = tonumber(data.p1)
    end
    if data.p2 then 
        palette[2] = tonumber(data.p2)
    end
    if data.p3 then 
        palette[3] = tonumber(data.p3)
    end
    if data.p4 then 
        palette[4] = tonumber(data.p4)
    end
    Citizen.InvokeNative(0xBC6DF00D7A4A6819, ped, draw, alb, norm, mati, palette[1], palette[2], palette[3], palette[4])
    Citizen.InvokeNative(0xCC8CA3E88256E58F,ped, 0, 1, 1, 1, false)
end)
--------------------------------------------------------------------------------------------------------------------------------------------
local focus = false 
RegisterNUICallback("ricx_metatags:close", function()
    SetNuiFocus(0,0)
    focus = false 
end)
--------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ricx_metatags:focus", function()
    SetNuiFocus(0,0)
    focus = true 
    Wait(1000)
    while focus do 
        Wait(5)
        if IsControlPressed(0, 0x5734A944) then 
            SetNuiFocus(1,1)
            focus = false 
        end
    end 
end)

--------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
end)