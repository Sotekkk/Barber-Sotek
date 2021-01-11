
ESX = nil
position = {}

TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)



RegisterServerEvent('::{[bngfujqio}}:::pay')
AddEventHandler('::{[bngfujqio}}:::pay', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(20)
end)


ESX.RegisterServerCallback('::{[bngfujqio}}:::checkposition', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    if #position > 0 then
        cb(false)
    else
        table.insert(position, identifier)
        cb(true)
    end
end)

AddEventHandler('esx:playerDropped', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    if #position > 0 then
        if identifier == position[1] then
            table.remove(position, 1)
        end
    end
end)

RegisterServerEvent('::{[bngfujqio}}:::removeposition')
AddEventHandler('::{[bngfujqio}}:::removeposition', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    if #position > 0 then
        if identifier == position[1] then
            table.remove(position, 1)
        end
    end
end)