-----------------------------------------------------------------------------------------
-- Jan 29, 2019 By HaoJun0823
-- This script comes from https://forums.civfanatics.com/threads/tutorial-adding-music-to-your-mod-civilization.621830/
-- Thanks FurionHuang,Gedemon,HerdByFate,raen.
-- Today, there is still no perfect way to add music.
-- If someone can know how to do it, please reply at the address above, thank you!
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- Gedemon's Script
-- Override the restart button

--2019/01/05
--If you click the Cancel button, the menu will be transparent and cannot be closed.
--So I canceled this menu and if it was triggered incorrectly, the auto save can still be called back.

-----------------------------------------------------------------------------------------
--HaoJun0823 (Randerion)
--2019/01/29
--So i try to fix all bugs which anythings can effect with playing fell.
--I maybe change something UI action like restart button (Just only this currently).
--This script just only change local machine,So you can use random things and don't need to worry other player.
--But you must to be know if you not equal local player is target leader all machine will be play audio or sound!
-----------------------------------------------------------------------------------------


local LEADER_NAME = "LEADER_FATE_QIN" --Set your Leader
--local isWar  = 0;
--local isPeace = 0;

-- OLD CODE --
--function OnReallyRestart() -- Gedemon's Project copy the game lua and add a event.
    -- Start a fresh game using the existing game configuration.

--	LuaEvents.RestartGame() -- add the function(s) you want to call before restarting a game to this lua event : LuaEvents.RestartGame.Add(myFunction)
--    Network.RestartGame()
--end

--function OnEnterGame()   -- override the default callback once all the files are loaded...
--We need it to replace the restart button.



   
--       ContextPtr:LookUpControl("/InGame/TopOptionsMenu/RestartButton"):RegisterCallback( Mouse.eLClick, OnReallyRestart )  
--	   print("replace restart button!")


--end

print("HaoJun0823 Audio Lua loaded:"..LEADER_NAME.." Pass Lua Check.")

-----------------------------------------------------------------------------------------
-- FurionHuang's Script
-- Stop the music when exit game.
-----------------------------------------------------------------------------------------


--function OnUIExitGame() --easily to know.
--	stopMusic()
--end

--function OnPlayerDefeatStopMusic( player, defeat, eventID) -- it's well done.
--    --print("Defeat Event Activated.");
--	stopMusic()

--end

--function OnTeamVictoryStopMusic(team, victory, eventID) -- same as the last.
    --print("Victory Event Activated.");
--	stopMusic()
   
--end

--function OnOpenDiplomacyActionView(otherPlayerID) -- The diplomacuy panel open when your access target leader.
	--play some music use anyway for your want.
--	local playerConfig:table = PlayerConfigurations[otherPlayerID]
--	local leaderName = playerConfig:GetLeaderTypeName()
--	local localPlayerID:number = Game.GetLocalPlayer();

--	pauseWarPeaceMusic();
--	if leaderName == LEADER_NAME and otherPlayerID == localPlayerID then
	
		
--		local time = randomNumber(99)
--		if(time <33) then
--		UI.PlaySound("Play_Leader_Music_FATE_QIN_Other");
--			else if (time >=33 and time <=66) then
--			UI.PlaySound("Play_Leader_Music_FATE_QIN_Self");
--				else if (time >66) then
--				UI.PlaySound("Play_Leader_Music_FATE_QIN_War");
--				end
--			end
--		end
--	end


--end

--function OnDiplomacySessionClosed(sessionID) -- The diplomacuy panel close when your close target leader diplomacuy.
--	print("Close Diplomacy Panel!!!")
--	stopDiplomacyMusic();
--	resumeWarPeaceMusic();
	--Stop music with target leader so you can ignore session.
--end


--function OnGamePauseStateChanged(bNewState)
--	stopDiplomacyMusic();
--	resumeWarPeaceMusic();
--end

--function DiplomacyActionView_ShowIngameUI()	
--	--Now you need stop your played music.
--	stopDiplomacyMusic();
--	resumeWarPeaceMusic();
--end

--function DiplomacyActionView_ShowIngameUI_OtherPlayer()	
--	stopMusic();
--end

--function OnOpenDiplomacyActionView_OtherPlayer(otherPlayerID)
--	stopMusic();
--end

----------Events----------

function init() -- I can write this to optimize the event.

	
  print("Initialization event loading.")

  local localPlayerID:number = Game.GetLocalPlayer();
  local playerConfig:table = PlayerConfigurations[localPlayerID]
  local leaderName = playerConfig:GetLeaderTypeName()
 
	-- 2019/02/16 Maybe need stop for all players.
	-- OLD CODE
 	--Events.LeaveGameComplete.Add(OnUIExitGame);
	--Events.PlayerDefeat.Add(OnPlayerDefeatStopMusic);
	--Events.TeamVictory.Add(OnTeamVictoryStopMusic);
	--LuaEvents.RestartGame.Add(OnUIExitGame);

  if leaderName == LEADER_NAME  then -- Consistent with the above variables
	-- There are local machine things.

	
	--Events.LoadScreenClose.Add(OnEnterGame);
	print(LEADER_NAME.." is local player, add event finished!")
	else
	print(LEADER_NAME.." not local player, don't need add event!")
	
	--LuaEvents.DiplomacyActionView_ShowIngameUI.Add(DiplomacyActionView_ShowIngameUI_OtherPlayer);
	--LuaEvents.DiplomacyRibbon_OpenDiplomacyActionView.Add(OnOpenDiplomacyActionView_OtherPlayer);

  end

	--There are global game things(Other player need listen diplomacuy music)
	--So you need add a stop Diplomacy Music event for Play_Music event.
	--LuaEvents.DiplomacyRibbon_OpenDiplomacyActionView.Add(OnOpenDiplomacyActionView);
	--Events.GamePauseStateChanged.Add(OnGamePauseStateChanged);
	--LuaEvents.DiplomacyActionView_ShowIngameUI.Add(DiplomacyActionView_ShowIngameUI);
	--LuaEvents.TopPanel_OpenDiplomacyActionView.Add(OnOpenDiplomacyActionView);	
	--LuaEvents.DiploScene_SceneClosed.Add(stopDiplomacyMusic);
	--Events.UserRequestClose.Add( stopDiplomacyMusic );


	print("Event loaded.")
end

--init()
-----------------------------------------------------------------------------------------
-- Done.
-----------------------------------------------------------------------------------------

function stopMusic() -- Use this method to stop music to fix something or you can write to other methods.

 UI.PlaySound("Stop_Music_FATE_QIN");
  --UI.PlaySound("Stop_Leader_Music_FATE_QIN_War");
   UI.PlaySound("Stop_Music_War_FATE_QIN");
    --UI.PlaySound("Stop_Leader_Music_FATE_QIN_Other");
	 --UI.PlaySound("Stop_Leader_Music_FATE_QIN_Self");
	  UI.PlaySound("Stop_Music_Peace_FATE_QIN");
	  
	  stopDiplomacyMusic()

end

function stopDiplomacyMusic()
  UI.PlaySound("Stop_Leader_Music_FATE_QIN_War");
    UI.PlaySound("Stop_Leader_Music_FATE_QIN_Other");
	 UI.PlaySound("Stop_Leader_Music_FATE_QIN_Self");
end

function pauseWarPeaceMusic()
	--if(isWar==1) then
	--print("Pause war music!")
	 UI.PlaySound("Pause_Music_War_FATE_QIN");
	--end
	--if(isPeace==1) then
	--print("Pause peace music!")
	 UI.PlaySound("Pause_Music_Peace_FATE_QIN");
	--end
end


function resumeWarPeaceMusic()
	--if(isWar==1) then
	--print("Resume war music!")
	 UI.PlaySound("Resume_Music_War_FATE_QIN");
	--end
	--if(isPeace==1) then
	--print("Resume peace music!")
	 UI.PlaySound("Resume_Music_Peace_FATE_QIN");
	--end
end


-----------------------------------------------------------------------------------------
-- Really Done.
-----------------------------------------------------------------------------------------

function isLeaderQin(iPlayer)

  local playerConfig:table = PlayerConfigurations[iPlayer]
  local leaderName = playerConfig:GetLeaderTypeName()
  local localPlayerID:number = Game.GetLocalPlayer();


  if leaderName ~= LEADER_NAME  then
    return false
  end
  if iPlayer ~= localPlayerID then
	return false
  end

  return true
end

--function randomNumber() -- maybe you need.
--	randomSeed()
--	return math.random()
--end

function randomNumber(n) -- 0 to n
-- use clock to sim game random seed.
-- when you in online game, every machine has different random result, so game maybe will crash,
-- maybe it better than random.
-- Some platform maybe have something bugs.

local time = os.time()+os.clock()*1000000;
local offset = tostring(os.clock()):reverse():sub(1, 3)
local result = time/offset%(n+1)
--print("HAOJUN0823(RANDERION) RANDOM START:")
--print("TIME:"..time)
--print("OFFSET:"..offset)
--print("RESULT::"..result)
--print("HAOJUN0823(RANDERION) RANDOM END")
return result
end


--function randomSeed()  -- i have other ways to use random seed for online game.(You can use this beacause ui action don't effect gameplay)
--	math.randomseed(tostring(os.time()):reverse():sub(1, 6))
--end

--------------------------
-- Really Really Done.
--------------------------

function onUnitsMove(PlayerID, UnitID, x, y, locallyVisible, stateChange)
	--print("Unit Move!")
	if isLeaderQin(PlayerID) and randomNumber(100)<=5  then
		--randomSeed()
		local time = randomNumber(99)
		--print("Random:"..time)
		if(time >=0 and time <=25) then
		UI.PlaySound("Play_Do_1");
			else if (time >25 and time <=50) then
			UI.PlaySound("Play_Do_2");
				else if (time >50 and time <=75) then
				UI.PlaySound("Play_Do_3");
					else if (time >75) then
					UI.PlaySound("Play_Do_4");
					end
				end
			end
		end
	end
end

function onDistrictAddedToMap(player,district,city,x,y,type,unk,unk2,progress,yield,unk3)
	if isLeaderQin(player) and randomNumber(100)<=10  then
		--randomSeed()
		local time = randomNumber(100)
		if(time <50) then
		UI.PlaySound("Play_Skill_1");
			else if (time >=50) then
			UI.PlaySound("Play_Skill_2");
			end
		end
	end
end


function onDiplomacyDeclareWar(iPlayer,tPlayer)
	--print(LEADER_NAME.."Under Attack!")
	if isLeaderQin(iPlayer) then
	--stopMusic()
	--isWar = 1
	--isPeace = 0
	--print(LEADER_NAME.."Play War Music!")
	UI.PlaySound("Play_War_Music_FATE_QIN");
	end


end

function onDiplomacyMakePeace(iPlayer,tPlayer)
	--print(LEADER_NAME.."Under Peace!")
	if isLeaderQin(iPlayer) then
	--stopMusic()
	--isWar = 0
	--isPeace = 1
	--print(LEADER_NAME.."Play Peace Music!")
	UI.PlaySound("Play_Peace_Music_FATE_QIN");
	end	
end

function onUnitKilledInCombat(player,unit,owner,unit)
	if owner == nil then
		return false
	end
	if isLeaderQin(owner) and randomNumber(100)<=25  then
		--randomSeed()
		local time = randomNumber(100)
		if(time <25) then
		UI.PlaySound("Play_Attack_1");
			else if (time >=25 and time <=50) then
			UI.PlaySound("Play_Attack_2");
				else if (time >=50 and time <=75) then
				UI.PlaySound("Play_Attack_3");
					else if (time >=75 and time <=1) then
					UI.PlaySound("Play_Attack_4");
					end
				end
			end
		end
	end
end

function OnGreatWorkCreated(iPlayer)
  if (isLeaderQin(iPlayer) == playerID ) then
    UI.PlaySound("Play_Wonder");
  end
end

function OnTurnBegin()
	if isLeaderQin(Game.GetLocalPlayer()) and randomNumber(100)<=10  then
		--randomSeed()
		local time = randomNumber(100)
		if(time <50) then
		UI.PlaySound("Play_Start_1");
			else if (time >=50) then
			UI.PlaySound("Play_Start_2");
			end
		end
	end
end


----------Events----------
Events.UnitMoved.Add( onUnitsMove );
Events.DistrictAddedToMap.Add( onDistrictAddedToMap );
Events.DiplomacyDeclareWar.Add( onDiplomacyDeclareWar );
Events.DiplomacyMakePeace.Add( onDiplomacyMakePeace );
Events.UnitKilledInCombat.Add( onUnitKilledInCombat );
Events.GreatWorkCreated.Add( OnGreatWorkCreated );
Events.TurnBegin.Add( OnTurnBegin );
