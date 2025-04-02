if not SYSHUD._settings.side_jobs_menus then return end

function MenuHelper:GetMenuItem(parent_menu, child_menu_name)
	for i, item in pairs(parent_menu._items) do
		if item._parameters.name == child_menu_name then
			return i, item
		end
	end
end

function MenuHelper:SetIcon(parent_menu, child_menu_name, icon, callback_name)
	local _, item = self:GetMenuItem(parent_menu, child_menu_name)
	if item then
		item._parameters.icon = icon
		item._parameters.icon_visible_callback = { callback_name }
		item._icon_visible_callback_name_list  = { callback_name }
		item:set_callback_handler(item._callback_handler)
	end
end

function MenuHelper:ChangeVisibleCallback(parent_menu, child_menu_name, operation, callback_name)
	local _, item = self:GetMenuItem(parent_menu, child_menu_name)
	if not item then
		return false
	end

	if operation == 'clear' or type(item._visible_callback_name_list) ~= 'table' then
		item._visible_callback_name_list = {}
	end

	clbk_present = table.contains(item._visible_callback_name_list, callback_name)
	if operation == 'add' then
		if clbk_present then
			return false
		end
		table.insert(item._visible_callback_name_list, callback_name)

	elseif operation == 'remove' then
		if not clbk_present then
			return false
		end
		table.delete(item._visible_callback_name_list, callback_name)
	end

	item._visible_callback_list = {}
	item._parameters.visible_callback = table.concat(item._visible_callback_name_list, ' ')
	item:set_callback_handler(item._callback_handler)

	return true
end

Hooks:Add("MenuManagerBuildCustomMenus", "MenuManagerBuildCustomMenus_SYSHUD_side_jobs_menus", function(menu_manager, nodes)
    if nodes.side_jobs then
		nodes.side_jobs:parameters().sync_state = "blackmarket"
	end

    MenuHelper:AddMenuItem(nodes.main, 'side_jobs', 'menu_cn_challenge', 'menu_cn_challenge_desc', 'steam_inventory', 'before')
	MenuHelper:SetIcon(nodes.main, 'side_jobs', 'guis/textures/pd2/icon_reward', 'show_side_job_menu_icon')

    MenuHelper:SetIcon(nodes.lobby, 'side_jobs', 'guis/textures/pd2/icon_reward', 'show_side_job_menu_icon')
	MenuHelper:ChangeVisibleCallback(nodes.lobby, 'side_jobs', 'clear')

    MenuHelper:AddMenuItem(nodes.crime_spree_lobby, 'side_jobs', 'menu_cn_challenge', 'menu_cn_challenge_desc', 'inventory', 'before')
	MenuHelper:SetIcon(nodes.crime_spree_lobby, 'side_jobs', 'guis/textures/pd2/icon_reward', 'show_side_job_menu_icon')
end)