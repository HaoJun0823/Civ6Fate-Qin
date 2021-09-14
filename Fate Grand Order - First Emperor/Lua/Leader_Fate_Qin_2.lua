-- Leader_Fate_Qin_2
-- Author: HaoJun0823
-- DateCreated: 9/7/2021 3:42:19 PM
--------------------------------------------------------------
print("QIN LA 2 Activated!");
function Improvements_Fix_QIN()
	local playerIDS = PlayerManager.GetAliveIDs();
	for i, playerId in ipairs(playerIDS) do
		local pPlayer = Players[playerId];
		local playerConfig:table = PlayerConfigurations[playerId];
		local leaderName = playerConfig:GetLeaderTypeName();
		if pPlayer:IsMajor() and pPlayer:IsAlive() and leaderName  == "LEADER_FATE_QIN" then
			local group:table = pPlayer:GetImprovements():GetImprovementPlots();
			if group.count > 0 then
				print("Count:"..group.count);
				for k,plotID in ipairs(group) do
					local pPlot = Map.GetPlotByIndex(plotID);
					if(pPlot ~= nil and pPlot:IsImprovementPillaged()) then
						local Improvement = pPlot:GetImrpovementType();
						local target = GameInfo.Improvements["IMPROVEMENT_FATE_QIN_GREAT_WALL"];
						if(Improvement == target.Index) then
							ImprovementBuilder.SetImprovementType(pPlot, -1);
							ImprovementBuilder.SetImprovementType(pPlot, iImprovement);
						end
					end
				end
			end
		end
	end
end

Events.TurnBegin.Add( Improvements_Fix_QIN );