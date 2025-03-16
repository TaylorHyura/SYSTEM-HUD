if SYSHUD._settings.empty_lobby then
	Hooks:Add("MenuManagerBuildCustomMenus", "BuildCreateEmptyLobbyMenu", function(menu_manager, nodes)
	local mainmenu = nodes.main
	
	if mainmenu == nil then
		log("[CreateEmptyLobby] Fatal Error: Failed to locate main menu, aborting")
		return
	end
	if mainmenu._items == nil then
		log("[CreateEmptyLobby] Fatal Error: Main menu node is empty, aborting")
		return
	end
	
	local data = {
		type = "CoreMenuItem.Item",
	}
	local params = {
		font = tweak_data.menu.pd2_large_font,
		font_size = 35,
		name = "syshud_empty_lobby_btn",
		text_id = "syshud_empty_lobby_title",
		help_id = "syshud_empty_lobby_description",
		callback = "syshud_empty_lobby"
	}
	
	local new_item = mainmenu:create_item(data, params)
	
	new_item.dirty_callback = callback(mainmenu, mainmenu, "item_dirty")
	if mainmenu.callback_handler then
		new_item:set_callback_handler(mainmenu.callback_handler)
	end
	
	local position = 2
	for index, item in pairs(mainmenu._items) do
		if item:name() == "crimenet_offline" then
			position = index
			break
		end
	end
	
	table.insert(mainmenu._items, position, new_item)
	end)
end

function MenuCallbackHandler:syshud_empty_lobby()
    Global.game_settings.permission = "friends_only"
    
    local level_data = Global.level_data
    managers.job:deactivate_current_job()
	managers.gage_assignment:deactivate_assignments()
    
    Global.load_level = false
	Global.level_data.level = nil
	Global.level_data.mission = nil
	Global.level_data.world_setting = nil
	Global.level_data.level_class_name = nil
	Global.level_data.level_id = nil
    
    self:create_lobby()
end