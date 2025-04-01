local Is_Synched = true
local sysColor = Color(1, 0.8313725490196078, 0) 

if Network:is_server() and not Utils:IsInHeist() and Utils:IsInGameState() and not in_chat then

	for k, peer in pairs(managers.network:session():peers()) do
		if not peer:synched() then
			Is_Synched = false
			break
		end
	end
	
	if Is_Synched == true then
		for i=2,4 do
			DelayedCalls:Add("ForceStart_" .. tostring(i), 1, function()
				local peer2 = managers.network:session() and managers.network:session():peer(i)
				if peer2 then
					peer2:send("send_chat_message", ChatManager.GAME, "syshud_chat_force_ready_success") -- Print to all clients
				end
			end)
		end
		managers.chat:_receive_message(1, "SYSTEM", managers.localization:text("syshud_chat_force_ready_success"), sysColor) -- Print to self
		--managers.network:session():spawn_players() -- Spawn
		game_state_machine:current_state():start_game_intro() -- Spawn
	else
		managers.chat:_receive_message(1, "SYSTEM", managers.localization:text("syshud_chat_force_ready_fail"), sysColor) -- Not all synced
	end
end