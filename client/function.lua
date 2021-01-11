function readyCutHair()
    disableUI = true
    TriggerEvent('barbershop:disableUI')
    TaskPedSlideToCoord(PlayerPedId(), -816.68, -184.0, 37.56, 29.616914749146, 1.0)
    DoScreenFadeOut(1000)
    
    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end
    SetEntityCoords(PlayerPedId(), -816.44, -182.52, 36.8)
    SetEntityHeading(PlayerPedId(), 33.285522460938)
    ClearPedTasks(GetPlayerPed(-1))
    BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);
    TaskStartScenarioAtPosition(GetPlayerPed(-1), "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", BehindPlayer['x'], BehindPlayer['y'], BehindPlayer['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)
    Citizen.Wait(1300)
    ExecuteCommand('coiffeur')
    createcambarbe(true)
    DoScreenFadeIn(5000)
end

function destorycam() 	
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    TriggerServerEvent('barbershop:removeposition')
end
function DrawSub(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, 1)
end
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(vector3(-820.16, -186.72, 37.56))
    SetBlipSprite(blip, 71)
    SetBlipColour(blip, 66)
    SetBlipScale(blip, 0.5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName("Bob Mulé Barber")
    EndTextCommandSetBlipName(blip)
end)
local posbarbe = {
    {x = -821.76, y= -184.84,z =  37.56}
}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k, v in pairs(posbarbe) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posbarbe[k].x, posbarbe[k].y, posbarbe[k].z)
            if dist <= 10.0  then
                DrawMarker(2, posbarbe[k].x, posbarbe[k].y, posbarbe[k].z+0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 204, 204, 204, 200, true, false, 2, true, false, false, false)
            end
            if dist <= 1.8  then
                DrawSub("~g~Bonjour~w~, voulez-vous prendre place ?")
            end
        if (GetDistanceBetweenCoords(coords, -821.76, -184.84, 37.56, true) < 1.8) then

            --AddTextEntry(GetCurrentResourceName(), _U('started'))
            DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
            if IsControlJustReleased(1, 51) then
                --ESX.TriggerServerCallback('barbershop:checkposition', function(result)
                        readyCutHair()
                --end)
            end
        end
    end
    end
end)


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
        Citizen.Wait(0)
    end
    barber = GetHashKey("s_f_m_fembarber")
    if not HasModelLoaded(barber) then
        RequestModel(barber)
        Citizen.Wait(200)
    end
end)

RegisterNetEvent('barbershop:disableUI')
AddEventHandler('barbershop:disableUI', function()
    Citizen.CreateThread(function()
        while disableUI do
            Citizen.Wait(0)
            HideHudComponentThisFrame(19)
            DisableControlAction(2, 37, true)
            DisablePlayerFiring(GetPlayerPed(-1), true)
            DisableControlAction(0, 106, true)
            if IsDisabledControlJustPressed(2, 37) or IsDisabledControlJustPressed(0, 106) then
                SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
            end
        end
    end)
end)

function createcam(default)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', -816.80, -182.00, 37.8, 0.0, 0.0, 208.0, 85.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', -816.88, -183.32, 37.9, 0.0, 0.0, 299.4, 85.0, false, 0)
        end 
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function createcambarbe(default)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', -816.80, -182.00, 37.8, 0.0, 0.0, 208.0, 75.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', -816.88, -183.32, 37.9, 0.0, 0.0, 299.4, 75.0, false, 0)
        end 
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end