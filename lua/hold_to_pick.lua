local update_targeted_original = ObjectInteractionManager._update_targeted

function ObjectInteractionManager:_update_targeted(...)
	update_targeted_original(self, ...)

	if alive(self._active_unit) then
		local t = Application:time()

		if SYSHUD._settings.hold_to_pick and self._active_unit:base() and self._active_unit:base().small_loot and managers.menu:get_controller():get_input_bool("interact") and (t >= (self._next_auto_pickup_t or 0)) then
			self._next_auto_pickup_t = t + 0.1
			self:interact(managers.player:player_unit())
		end
	end
end