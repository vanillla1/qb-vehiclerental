MenuEnable = false

CreateThread(function()
    for k,v in pairs(Config.RentelLocations) do
        local RentalPoint = AddBlipForCoord(v["coords"][1], v["coords"][2], v["coords"][3])
        SetBlipSprite (RentalPoint, 379)
        SetBlipDisplay(RentalPoint, 4)
        SetBlipScale  (RentalPoint, 0.65)
        SetBlipAsShortRange(RentalPoint, true)
        SetBlipColour(RentalPoint, 3)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Rental")
        EndTextCommandSetBlipName(RentalPoint)
    end

    while true do
        local sleep = 500
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)
        local plyID = PlayerId()

        for k,v in pairs(Config.RentelLocations) do
            local distance = GetDistanceBetweenCoords(plyCoords, v['coords'][1], v['coords'][2], v['coords'][3])
            if distance < 1.5 then
                sleep = 1
                DrawMarker(20,v['coords'][1], v['coords'][2], v['coords'][3],0,0,0,0,0,0,0.701,1.0001,0.3001,222,50, 50,distance,0,0,0,0)
                DrawText3Ds(v['coords'][1], v['coords'][2], v['coords'][3], '[E] - Rent a Vehicle')
                if IsControlJustPressed(0, 38) then
                    ClearMenu()
                    MenuTitle = "Vehicle Rental"
                    MenuEnable = true

                    local coords = { x = v['coords'][1], y = v['coords'][2], z = v['coords'][3], h = v['coords'][4] }
                    for model, data in pairs(Config.RentelVehicles) do
                        if data.stored then
                            Menu.addButton(data.label .. ' - Stored',"SpawnVehicle", { model = model, price = 0, coords = coords }) 
                        else
                            Menu.addButton(data.label .. ' - $' .. data.price,"SpawnVehicle", { model = model, price = data.price, coords = coords }) 
                        end
                    end

                    Menu.addButton('Close Menu',"CloseMenu") 
                    Menu.hidden = false

                    while MenuEnable do
                        distance = GetDistanceBetweenCoords(plyCoords, v['coords'][1], v['coords'][2], v['coords'][3])
                        if distance > 2 then
                            CloseMenu()
                        end
                        Wait(1)
                        Menu.renderGUI()
                    end
                end
            elseif distance < 4 then
                sleep = 1
                DrawText3Ds(v['coords'][1], v['coords'][2], v['coords'][3], 'Rental')
                DrawMarker(20,v['coords'][1], v['coords'][2], v['coords'][3],0,0,0,0,0,0,0.701,1.0001,0.3001,222,50, 50,distance,0,0,0,0)
            elseif distance < 50 then
                sleep = 1
                DrawMarker(20,v['coords'][1], v['coords'][2], v['coords'][3],0,0,0,0,0,0,0.701,1.0001,0.3001,222,50, 50,distance,0,0,0,0)
            end
        end

        Wait(sleep)
    end
end)
