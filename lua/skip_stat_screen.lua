local update_original = StageEndScreenGui.update

function StageEndScreenGui:update(t, ...)
    update_original(self, t, ...)
    if not self._button_not_clickable and SYSHUD._settings.skip_stat_screen then
        self._auto_continue_t = self._auto_continue_t or (t + SYSHUD._settings.skip_stat_screen_delay)
        if t >= self._auto_continue_t then
            managers.menu_component:post_event("menu_enter")
            game_state_machine:current_state()._continue_cb()
        end
    end
end