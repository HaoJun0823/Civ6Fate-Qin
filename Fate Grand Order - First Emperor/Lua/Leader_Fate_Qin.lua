-- Leader_Fate_Qin
-- Author: HaoJun0823
-- DateCreated: 12/15/2018 1:09:14 PM
-- Version:2
--------------------------------------------------------------
print("QIN LA Activated!");


			
function QinFind(playerId, findId, unk, sourse)
	local pPlayer = Players[playerId];
	local playerConfig = PlayerConfigurations[playerId];

	if pPlayer:IsMajor() and pPlayer:IsAlive() then
		if playerConfig:GetLeaderTypeName() == "LEADER_FATE_QIN" then
			if pPlayer:IsAlive() then
			--print("Tech or Civic Boost Activated!");
				local pCities :table = pPlayer:GetCities();
				for _, pCity in pCities:Members() do
					local pBuildQueue :table  = pCity:GetBuildQueue();
					if (pBuildQueue ~= nil) then
						local currentBuild :string = pBuildQueue:CurrentlyBuilding();
						--print("Currently Building:"..currentBuild);
						local r = string.sub(currentBuild,0,5);
						if r == 'BUILD' then
								local BuildingProg :number = GameInfo.Buildings[currentBuild].Cost;
								if BuildingProg ~= nil then
								--print("get Global Progress:"..BuildingProg);
								--print("add Build:"..currentBuild);
								pBuildQueue:AddProgress(0.25*((BuildingProg * GameInfo.GameSpeeds[GameConfiguration.GetGameSpeedType()].CostMultiplier / 100) - 1));
								else
								--print("Error:Qin nil object:"..currentBuild);
								end
						end
						if r == 'DISTR' then
								local DistirctProg :number = GameInfo.Districts[currentBuild].Cost;
								if DistirctProg ~= nil then	
								--print("get Global Progress:"..DistirctProg);
								--print("add District:"..currentBuild);
								pBuildQueue:AddProgress(0.25*((DistirctProg * GameInfo.GameSpeeds[GameConfiguration.GetGameSpeedType()].CostMultiplier / 100) - 1));
								else
								--print("Error:Qin nil object:"..currentBuild);
								end					
						end
						if r == 'PROJE' then
								local ProjectProg :number = GameInfo.Projects[currentBuild].Cost;
								if ProjectProg == nil then
								--print("Try XP1");
								local ProjectProg :number = GameInfo.Projects_XP1[currentBuild].Cost;
								end
								if ProjectProg ~= nil then
								--print("get Global Progress:"..ProjectProg);
								--print("add Project:"..currentBuild);
								pBuildQueue:AddProgress(0.5*((ProjectProg * GameInfo.GameSpeeds[GameConfiguration.GetGameSpeedType()].CostMultiplier / 100) - 1));
								else
								--print("Error:Qin nil object:"..currentBuild);
								end
						end
						if r == 'UNIT_' then
								local UnitProg :number = GameInfo.Units[currentBuild].Cost;
								if UnitProg ~= nil then
								--print("get Global Progress:"..UnitProg);
								--print("add Unit:"..currentBuild);
								pBuildQueue:AddProgress(0.5*((UnitProg * GameInfo.GameSpeeds[GameConfiguration.GetGameSpeedType()].CostMultiplier / 100) - 1));
								else
								--print("Error:Qin nil object:"..currentBuild);
								end
						end
					end
				end
			end
		end
	end
end
			
Events.TechBoostTriggered.Add(QinFind);
Events.CivicBoostTriggered.Add(QinFind);

