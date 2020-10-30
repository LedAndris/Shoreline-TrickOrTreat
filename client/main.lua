local HasAlreadyEnteredMarker = false
local LastHouse, LastPart

ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local isInMarker, hasExited = false, false
		local currentHouse, currentPart


		for k,v in pairs(Config.Houses) do 
			for i=1, #v.LargeHouses, 1 do
				local distance = #(playerCoords - v.LargeHouses[i])

				if distance < Config.DrawDistance then
					if not HasStreamedTextureDictLoaded("halloween") then
						RequestStreamedTextureDict("halloween", true)
						while not HasStreamedTextureDictLoaded("halloween") do
							Wait(1)
						end
					else
						DrawMarker(9, v.LargeHouses[i], 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 0.5, 0.5, 0.5, 500, 500, 500, 500, false, false, 2, false, "halloween", "halloween", false)

						if distance < 1.0 then
							isInMarker, currentHouse, currentPart = true, k, 'LargeHouses'
						end 
					end
				end
			end
		
			for i=1, #v.MediumHouses, 1 do
				local distance = #(playerCoords - v.MediumHouses[i])

				if distance < Config.DrawDistance then
					if not HasStreamedTextureDictLoaded("halloween") then
						RequestStreamedTextureDict("halloween", true)
						while not HasStreamedTextureDictLoaded("halloween") do
							Wait(1)
						end
					else
						DrawMarker(9, v.MediumHouses[i], 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 0.5, 0.5, 0.5, 500, 500, 500, 500, false, false, 2, false, "halloween", "halloween", false)

						if distance < 1.0 then
							isInMarker, currentHouse, currentPart = true, k, 'MediumHouses'
						end 
					end
				end
			end

			for i=1, #v.SmallHouses, 1 do
				local distance = #(playerCoords - v.SmallHouses[i])

				if distance < Config.DrawDistance then
					if not HasStreamedTextureDictLoaded("halloween") then
						RequestStreamedTextureDict("halloween", true)
						while not HasStreamedTextureDictLoaded("halloween") do
							Wait(1)
						end
					else
						DrawMarker(9, v.SmallHouses[i], 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 0.5, 0.5, 0.5, 500, 500, 500, 500, false, false, 2, false, "halloween", "halloween", false)

						if distance < 1.0 then
							isInMarker, currentHouse, currentPart = true, k, 'SmallHouses'
						end 
					end
				end
			end
		end

		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHouse ~= currentHouse or LastPart ~= currentPart)) then
			if
				(LastHouse and LastPart) and
				(LastHouse ~= currentHouse or LastPart ~= currentPart)
			then
				TriggerEvent('TrickOrTreat:hasExitedMarker')
				hasExited = true
			end

			HasAlreadyEnteredMarker = true
			LastHouse             	= currentHouse
			LastPart                = currentPart

			TriggerEvent('TrickOrTreat:hasEnteredMarker', currentHouse, currentPart)
		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('TrickOrTreat:hasExitedMarker')
		end

	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then

			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'trick_large' then
					TrickOrTreatLarge(CurrentAction)
					print('large')
				elseif CurrentAction == 'trick_medium' then
					TrickOrTreatMedium(CurrentAction)
					print('medium')
				elseif CurrentAction == 'trick_small' then
					TrickOrTreatSmall(CurrentAction)
					print('small')
				end

				CurrentAction = nil
			end
		end
	end
end)

AddEventHandler('TrickOrTreat:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

AddEventHandler('TrickOrTreat:hasEnteredMarker', function(house, part)
	if part == 'LargeHouses' then
		CurrentAction     = 'trick_large'
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to Trick or Treat'
	elseif part == 'MediumHouses' then
		CurrentAction     = 'trick_medium'
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to Trick or Treat'
	elseif part == 'SmallHouses' then
		CurrentAction     = 'trick_small'
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to Trick or Treat'
	end
end)

--
-- Functions
--

function TrickOrTreatLarge(house)

	local playerPed = PlayerPedId()
	local lib, anim = 'timetable@jimmy@doorknock@', 'knockdoor_idle'
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 32, 0, false, false, false)

		Citizen.Wait(500)
		while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end
		
		TriggerServerEvent('TrickOrTreat:giveItems', house)
	end)
end

function TrickOrTreatMedium(house)

	local playerPed = PlayerPedId()
	local lib, anim = 'timetable@jimmy@doorknock@', 'knockdoor_idle'
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 32, 0, false, false, false)

		Citizen.Wait(500)
		while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end

		print(house)
		TriggerServerEvent('TrickOrTreat:giveItems', house)
	end)
end

function TrickOrTreatSmall(house)

	local playerPed = PlayerPedId()
	local lib, anim = 'timetable@jimmy@doorknock@', 'knockdoor_idle'
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 32, 0, false, false, false)

		Citizen.Wait(500)
		while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end

		TriggerServerEvent('TrickOrTreat:giveItems', house)
	end)
end

-- Candy Effect
RegisterNetEvent('TrickOrTreat:useCandy')
AddEventHandler('TrickOrTreat:useCandy', function()

	local playerPed = GetPlayerPed(-1)

    RequestAnimSet("move_m@hurry_butch@a")
    while not HasAnimSetLoaded("move_m@hurry_butch@a") do
        Citizen.Wait(0)
	end
	
	Citizen.Wait(1000)
	TriggerEvent('esx_status:add', source, 'hunger', 50000)
    SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
	SetRunSprintMultiplierForPlayer(playerPed, 2.5)
	Citizen.Wait(35000)
	ResetPedMovementClipset(playerPed, 0)
    SetRunSprintMultiplierForPlayer(playerPed, 1.0)
end)
