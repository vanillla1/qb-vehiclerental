local RentedVehicles = {}
local VehiclePlate = 0

RegisterServerEvent('qb-vehiclerental:server:SetVehicleRented')
AddEventHandler('qb-vehiclerental:server:SetVehicleRented', function(bool, vehicleData)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    local plyCid = ply.PlayerData.citizenid

    if bool then
        if ply.PlayerData.money.cash >= vehicleData.price then
            VehiclePlate = VehiclePlate + 1
            ply.Functions.RemoveMoney('cash', vehicleData.price, "vehicle-rentail-bail") 
            RentedVehicles[plyCid] = "RENT-" .. VehiclePlate
            TriggerClientEvent('QBCore:Notify', src, 'You paid the deposit of € '.. vehicleData.price ..' in cash.', 'success', 3500)
            TriggerClientEvent('qb-vehiclerental:server:SpawnRentedVehicle', src, "RENT-" .. VehiclePlate, vehicleData) 
        elseif ply.PlayerData.money.bank >= vehicleData.price then 
            VehiclePlate = VehiclePlate + 1
            ply.Functions.RemoveMoney('bank', vehicleData.price, "vehicle-rentail-bail") 
            RentedVehicles[plyCid] = "RENT-" .. VehiclePlate
            TriggerClientEvent('QBCore:Notify', src, 'You paid the deposit of € '.. vehicleData.price ..' through the bank.', 'success', 3500)
            TriggerClientEvent('qb-vehiclerental:server:SpawnRentedVehicle', src, "RENT-" .. VehiclePlate, vehicleData) 
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have enough money.', 'error', 3500)
        end
        return
    end
    TriggerClientEvent('QBCore:Notify', src, 'You have received your deposit of € '.. vehicleData.price ..' back.', 'success', 3500)
    ply.Functions.AddMoney('cash', vehicleData.price, "vehicle-rentail-bail")
    RentedVehicles[plyCid] = nil
end)
