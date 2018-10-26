 --[[
 Commands

 Salute: 		/isalute 	: Salute your commrads!
 Bird 1: 		/ibird 	: One hand middle Finger
 Bird 2: 		/ibird2 	: 2 hands middle finger
 Facepalm: 		/ipalm	: Facepalm
 BongRip:		/ibong	: Press E to take a fat rip!
 Cell Record:	/photo : Press E to take a picture! 
 Notepad:		/iticket : Press E to check your watch
 Crowd Control:	/cc		: Press E to control the crowd!
 Slow Clap:		/iclap		: Slow Clap
 Umbrella:		/iumb	: Pull out an umbrella on those rainy days!
 Bag:			/ibag	: Get your suitcase out.
 Suicide:		/idie	: Commit suicide with a pistol. (WIP)
 Coffee:		/icoffee: Gets a coffee...
 Smoke:			/ismoke	: Gets a cigarette...
 Cross Hands:		/icross	: Cross your hands while upset!
]]--


-------Props-------
local holdingbong = false
local bongmodel = "hei_heist_sh_bong_01"
local bong_net = nil

local holdingphoneR = false
local phoneRmodel = "prop_amb_phone"
local phoneR_net = nil

local holdingpad = false
local padmodel = "prop_notepad_02"
local pad_net = nil

local holdingumb = false
local umbmodel = "p_amb_brolly_01"
local umb_net = nil

local holdingpistol = false
local pistolmodel = "w_pi_pistol"
local pistol_net = nil

local holdingcoffee = false
local coffeemodel = "p_amb_coffeecup_01"
local coffee_net = nil

local holdingsmoke = false
local smokemodel = "p_cs_ciggy_01b_s"
local smoke_net = nil

local handsup = false

------------- create chat message

RegisterCommand("iemotes",function(source, args)
	    TriggerEvent("chatMessage", "INTERACTIVE EMOTES", {20,255,75}, "USAGE - /i[emote] | (EXAMPLE: /iclap)") -- Saying "EMOTES:" in green
		TriggerEvent("chatMessage", "", {190,190,190}, "salute,  photos,  bird,  bird2,  palm,  bong,  ticket,  clap,  crowd,  umbrella,  bag,  coffee,  smoke,  cross,  die") -- Displaying the emotes in grey
		TriggerEvent("chatMessage", "", {255,0,0}, "Repeat the same command to cancel emote.")
end, false)

-------------------------------- Cross Hands

RegisterCommand("icross",function(source, args)

	local ad = "amb@world_human_hang_out_street@female_arms_crossed@base"
	local player = GetPlayerPed( -1 )
	
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (100)
			ClearPedSecondaryTask(GetPlayerPed(-1))
		else
			TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (500)
		end     
	end
end, false)

------------- hands up

RegisterCommand("hu",function(source, args)
	local ad1 = "mp_am_hold_up"
	local ad1a = "guard_handsup_loop"
	local player = GetPlayerPed(-1)
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	
	if (DoesEntityExist(player) and not IsEntityDead(player)) then 
		loadAnimDict(ad1)
		if handsup then
			Wait(100)
			ClearPedSecondaryTask(GetPlayerPed(-1))
			handsup = false
		else
			TaskPlayAnim(player, ad1, ad1a, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
			Wait(500)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			Wait(120)
			handsup = true
		end
	end
end, false)

------------- smoke

RegisterCommand("ismoke",function(source, args)
	local ad1 = "amb@world_human_aa_smoke@male@idle_a"
	local ad1a = "idle_c"
	local player = GetPlayerPed(-1)
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	local smokespawned = CreateObject(GetHashKey(smokemodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	local netid = ObjToNet(smokespawned)

	if (DoesEntityExist(player) and not IsEntityDead(player)) then 
		loadAnimDict(ad1)
		RequestModel(GetHashKey(smokemodel))
		if holdingsmoke then
			Wait(100)
			ClearPedSecondaryTask(GetPlayerPed(-1))
			DetachEntity(NetToObj(smoke_net), 1, 1)
			DeleteEntity(NetToObj(smoke_net))
			smoke_net = nil
			holdingsmoke = false
		else
			TaskPlayAnim(player, ad1, ad1a, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
			Wait(500)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			AttachEntityToEntity(smokespawned,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.0,0.0,0.0,0.0,0.0,0.0,1,1,0,1,0,1)
			Wait(120)
			smoke_net = netid
			holdingsmoke = true
		end
	end
end, false)

------------- coffee

RegisterCommand("icoffee",function(source, args)
	local ad1 = "amb@world_human_drinking@coffee@male@idle_a"
	local ad1a = "idle_c"
	local player = GetPlayerPed(-1)
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	local coffeespawned = CreateObject(GetHashKey(coffeemodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	local netid = ObjToNet(coffeespawned)

	if (DoesEntityExist(player) and not IsEntityDead(player)) then 
		loadAnimDict(ad1)
		RequestModel(GetHashKey(coffeemodel))
		if holdingcoffee then
			Wait(100)
			ClearPedSecondaryTask(GetPlayerPed(-1))
			DetachEntity(NetToObj(coffee_net), 1, 1)
			DeleteEntity(NetToObj(coffee_net))
			coffee_net = nil
			holdingcoffee = false
		else
			TaskPlayAnim(player, ad1, ad1a, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
			Wait(500)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			AttachEntityToEntity(coffeespawned,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.0,0.0,0.0,0.0,0.0,0.0,1,1,0,1,0,1)
			Wait(120)
			coffee_net = netid
			holdingcoffee = true
		end
	end
end, false)

------------- suicide

RegisterCommand("idie",function(source, args)
	local ad1 = "mp_suicide"
	local ad1a = "pistol"
	local player = GetPlayerPed(-1)
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	local pistolspawned = CreateObject(GetHashKey(pistolmodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	local netid = ObjToNet(pistolspawned)
	local co = GetEntityCoords(GetPlayerPed(-1))
	local he = GetEntityHeading(GetPlayerPed(-1))

	if (DoesEntityExist(player) and not IsEntityDead(player)) then 
		loadAnimDict(ad1)
		RequestModel(GetHashKey(pistolmodel))
		if holdingpistol then
			Wait(100)
			ClearPedSecondaryTask(GetPlayerPed(-1))
			DetachEntity(NetToObj(pistol_net), 1, 1)
			DeleteEntity(NetToObj(pistol_net))
			pistol_net = nil
			holdingpistol = false
		else
			TaskPlayAnimAdvanced(GetPlayerPed(-1), "mp_suicide", "pistol", co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 50, 0.0, 0, 0)
			Wait(500)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			AttachEntityToEntity(pistolspawned,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.0,0.0,0.0,0.0,0.0,0.0,1,1,0,1,0,1)
			Wait(120)
			pistol_net = netid
			holdingpistol = true
		end
	end
end, false)

------------- umbrella

RegisterCommand("iumbrella",function(source, args)
	local ad1 = "amb@code_human_wander_drinking@beer@male@base"
	local ad1a = "static"
	local player = GetPlayerPed(-1)
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	local umbspawned = CreateObject(GetHashKey(umbmodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	local netid = ObjToNet(umbspawned)

	if (DoesEntityExist(player) and not IsEntityDead(player)) then 
		loadAnimDict(ad1)
		RequestModel(GetHashKey(umbmodel))
		if holdingumb then
			Wait(100)
			ClearPedSecondaryTask(GetPlayerPed(-1))
			DetachEntity(NetToObj(umb_net), 1, 1)
			DeleteEntity(NetToObj(umb_net))
			umb_net = nil
			holdingumb = false
		else
			TaskPlayAnim(player, ad1, ad1a, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
			Wait(500)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			AttachEntityToEntity(umbspawned,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.0,0.0,0.0,0.0,0.0,0.0,1,1,0,1,0,1)
			Wait(120)
			umb_net = netid
			holdingumb = true
		end
	end
end, false)


------------- slowclap


RegisterCommand("iclap",function(source, args)
	local clapping = false
	local ad = "anim@mp_player_intupperslow_clap"
	local ad2 = "amb@world_human_drinking@beer@male@exit"
	local ad2a = "exit"
	local player = GetPlayerPed( -1 )
	
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
		loadAnimDict( ad )
		if clapping then 
			Wait (0)
		else
			TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, 5000, 49, 0, 0, 0, 0 )
			clapping = true
			Wait (5000)
			clapping = false
		end     
	end

	
end, false)



------------- ticket

RegisterCommand("iticket",function(source, args)
	local player = GetPlayerPed(-1)
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	local padspawned = CreateObject(GetHashKey(padmodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	local netid = ObjToNet(padspawned)
	local ad = "amb@medic@standing@timeofdeath@enter"
	local ad2 = "amb@medic@standing@timeofdeath@base"
	local ad3 = "amb@medic@standing@timeofdeath@exit"
	local ad4 = "amb@medic@standing@timeofdeath@idle_a" -- use idle_b for anim(check watch)

	if (DoesEntityExist(player) and not IsEntityDead(player)) then ---------------------If playing then cancel
		loadAnimDict(ad)
		loadAnimDict(ad2)
		loadAnimDict(ad3)
		loadAnimDict(ad4)
		if holdingpad then
			TaskPlayAnim(player, ad3, "exit", 8.0, 1.0, -1, 50, 0, 0, 0, 0)
			Wait(5330)
			DetachEntity(NetToObj(pad_net), 1, 1)
			DeleteEntity(NetToObj(pad_net))
			Wait(2500)
			ClearPedSecondaryTask(GetPlayerPed(-1))
			pad_net = nil
			holdingpad = false
		else
			Wait(500) ---------------------if not playing, then play
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			TaskPlayAnim( player, ad, "enter", 8.0, 1.0, -1, 50, 0, 0, 0, 0 )
			Wait (3000)																							--28422
			AttachEntityToEntity(padspawned,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.0,0.0,0.0,0.0,360.0,0.0,1,1,0,1,0,1)
			Wait(1310)
			DetachEntity(NetToObj(pad_net), 1, 1)
			DeleteEntity(NetToObj(pad_net))
 			AttachEntityToEntity(padspawned,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 18905),0.1,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
			-- Wait(120)
			Notification("Press ~r~[E]~w~ check the time.")
			pad_net = netid
			holdingpad = true
		end
	end

	while holdingpad do
		Wait(0)
		if IsControlJustPressed(0, 38) then
			Wait(500)
			TaskPlayAnim( player, ad4, "idle_b", 8.0, 1.0, -1, 50, 0, 0, 0, 0 )
		end
	end
end, false)


------------- mobile phone record

RegisterCommand("iphotos",function(source, args)

	local player = GetPlayerPed(-1)
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	local phoneRspawned = CreateObject(GetHashKey(phoneRmodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	local netid = ObjToNet(phoneRspawned)
	local ad = "amb@world_human_mobile_film_shocking@male@enter"
	local ad2 = "amb@world_human_mobile_film_shocking@male@base"
	local ad3 = "amb@world_human_mobile_film_shocking@male@exit"
	local pd = "core" 
	local pn = "ent_anim_paparazzi_flash"

	if (DoesEntityExist(player) and not IsEntityDead(player)) then ---------------------If playing then cancel
		loadAnimDict(ad)
		loadAnimDict(ad2)
		loadAnimDict(ad3)
		RequestPtfxAsset(pd)
		RequestModel(GetHashKey(phoneRmodel))
		if holdingphoneR then
			TaskPlayAnim(player, ad3, "exit", 8.0, 1.0, -1, 50, 0, 0, 0, 0)
			Wait(1840)
			DetachEntity(NetToObj(phoneR_net), 1, 1)
			DeleteEntity(NetToObj(phoneR_net))
			Wait(750)
			ClearPedSecondaryTask(GetPlayerPed(-1))
			phoneR_net = nil
			holdingphoneR = false
		else
			Wait(500) ---------------------if not playing, then play
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			TaskPlayAnim( player, ad, "enter", 8.0, 1.0, -1, 50, 0, 0, 0, 0 )
			Wait (1260)
			AttachEntityToEntity(phoneRspawned,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
			-- Wait(1310)
 			-- TaskPlayAnim( player, ad2, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			-- Wait(120)
			phoneR_net = netid
			holdingphoneR = true
		end
	end

	while holdingphoneR do
		Wait(0)
		if IsControlJustPressed(0, 38) then
			Wait(500)
			UseParticleFxAssetNextCall(pd)
			StartParticleFxNonLoopedOnEntity(pn, phoneRspawned, 0.0	, 0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
		end
	end
end, false)

-----------  BongRips

RegisterCommand("ibong",function(source, args)
	local ad1 = "anim@safehouse@bong"
	local ad1a = "bong_stage1"
	local player = GetPlayerPed(-1)
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	local bongspawned = CreateObject(GetHashKey(bongmodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	local netid = ObjToNet(bongspawned)

	if (DoesEntityExist(player) and not IsEntityDead(player)) then 
		loadAnimDict(ad1)
		RequestModel(GetHashKey(bongmodel))
		if holdingbong then
			Wait(100)
			ClearPedSecondaryTask(GetPlayerPed(-1))
			DetachEntity(NetToObj(bong_net), 1, 1)
			DeleteEntity(NetToObj(bong_net))
			bong_net = nil
			holdingbong = false
		else
			Wait(500)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			AttachEntityToEntity(bongspawned,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 18905),0.10,-0.25,0.0,95.0,190.0,180.0,1,1,0,1,0,1)
			Wait(120)
			Notification("Press ~r~[E]~w~ to take a hit.")
			bong_net = netid
			holdingbong = true
		end
	end

	while holdingbong do
		Wait(0)
		local plyCoords2 = GetEntityCoords(player, true)
		local head = GetEntityHeading(player)
		if IsControlJustPressed(0, 38) then
			TaskPlayAnimAdvanced(player, ad1, ad1a, plyCoords2.x, plyCoords2.y, plyCoords2.z, 0.0, 0.0, head, 8.0, 1.0, 4000, 49, 0.25, 0, 0)
			Wait(100)
			Wait(7250)
			TaskPlayAnim(player, ad2, ad2a, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
		end
	end
end, false)

---------------------------------------Salute Anim 



RegisterCommand("isalute",function(source, args)

	local ad = "anim@mp_player_intuppersalute"
	local player = GetPlayerPed( -1 )
	
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (600)
			ClearPedSecondaryTask(GetPlayerPed(-1))
		else
			TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (500)
		end     
	end
end, false)

--------------------------------2 Middle Fingers

RegisterCommand("ibird2",function(source, args)

	local ad = "anim@mp_player_intupperfinger"
	local player = GetPlayerPed( -1 )
	
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (100)
			ClearPedSecondaryTask(GetPlayerPed(-1))
		else
			TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (500)
		end     
	end
end, false)

------------------------Facepalm

RegisterCommand("ipalm",function(source, args)

	local ad = "anim@mp_player_intupperface_palm"
	local player = GetPlayerPed( -1 )
	
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (100)
			ClearPedSecondaryTask(GetPlayerPed(-1))
		else
			TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (500)
		end     
	end
end, false)

----------------------- One middle Finger


RegisterCommand("ibird",function(source, args)

	local ad = "anim@mp_player_intselfiethe_bird"
	local player = GetPlayerPed( -1 )
	
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (100)
			ClearPedSecondaryTask(GetPlayerPed(-1))
		else
			TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (500)
		end     
	end
end, false)


--------------------Crowd Control
local control = false
local control2 = false
RegisterCommand("icrowd",function(source, args)


	local ad1 = "amb@code_human_police_crowd_control@base" -- only anim in ad -> "base"

	local ad2 = "amb@code_human_police_crowd_control@idle_a"
	local ad2a = "idle_a"
	local ad2b = "idle_b"
	local ad2c = "idle_c"

	local ad3 = "amb@code_human_police_crowd_control@idle_b"
	local ad3d = "idle_d"
	local ad3e = "idle_e"
	local ad3f = "idle_f"

	local adex = "anim@mp_player_intselfiethe_bird" --what im using to exit the anim

	local player = GetPlayerPed(-1)

	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
		loadAnimDict( ad1 )
		loadAnimDict( ad2 )
		loadAnimDict( ad3 )
		loadAnimDict( adex )
		if ( IsEntityPlayingAnim( player, ad1, "base", 3 ) ) then 
			--TaskPlayAnim( player, adex, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (100)
			ClearPedSecondaryTask(GetPlayerPed(-1))
			control = false
		else
			TaskPlayAnim( player, ad1, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (500)
			Notification("Press ~r~[E]~w~ to control the crowd!")
			control = true
		end     
	end


	local conAnimRnd = math.random(1, 3)
	local conAnim2Rnd = math.random(1, 3)
	local connotiRnd = math.random(1, 1)

	local conAnim = {
		ad2a,
		ad2b,
		ad2c
	}

	local conAnim2 = {
		ad3d,
		ad3e,
		ad3f
	}

	local connoti = {
		"Controlling Situation..."
	}

	local fin = false
	while control do
		Wait(0)
		if IsControlJustPressed(0, 38) then
			Wait(100)
			Notification(connoti[connotiRnd])
			Wait(100)

			if connotiRnd <= 3 then
				TaskPlayAnim(player, ad2, conAnim[conAnimRnd], 8.0, -8.0, -1, 50, 0, 0, 0, 0)
			elseif connotiRnd >= 4 then
				TaskPlayAnim(player, ad3, conAnim2[conAnim2Rnd], 8.0, -8.0, -1, 50, 0, 0, 0, 0)
				if IsEntityPlayingAnim(player, ad2, ad2a, 3) then
					Wait(11000)
					fin = true
				elseif IsEntityPlayingAnim(player, ad2, ad2b, 3) then
					Wait(13000)
					fin = true
				elseif IsEntityPlayingAnim(player, ad2, ad2c, 3) then
					Wait(5050)
					fin = true
				elseif IsEntityPlayingAnim(player, ad3, ad3d, 3) then
					Wait(10900)
					fin = true
				elseif	IsEntityPlayingAnim(player, ad3, ad3e, 3) then
					Wait(9750)
					fin = true
				elseif IsEntityPlayingAnim(player, ad3, ad3f, 3) then
					Wait(8000)
					fin = true
				end
				if fin then
					TaskPlayAnim(player, ad1, "base", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1000)
					fin = false
				end
			end
		end
	end
end, false)


----------------------------------------------------------------------------------------------------------------------------
------------------------------------------------ functions -----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
function Notification(message)  --- default gta notification
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0, 0)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do 
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function DrawMissionText2(m_text, showtime) --subtitles
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function GetCoords()
	GetEntityCoords(GetPlayerPed(-1))
end

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/iemotes', 'Displays a list of interactive animations.')
end)
