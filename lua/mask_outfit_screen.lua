Hooks:PostHook(MenuSceneManager, "_set_up_templates", "unhide_mask_umu", function(self)
	if SYSHUD._settings.mask_outfit_screen then
		self._scene_templates.blackmarket_armor.hide_mask = false
	end
end)