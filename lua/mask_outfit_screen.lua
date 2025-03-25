if not SYSHUD._settings.mask_outfit_screen then return end

Hooks:PostHook(MenuSceneManager, "_set_up_templates", "unhide_mask_umu", function(self)
	self._scene_templates.blackmarket_armor.hide_mask = false
end)