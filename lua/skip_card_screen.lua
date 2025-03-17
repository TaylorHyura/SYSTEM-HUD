local update_original = LootDropScreenGui.update

function LootDropScreenGui:update(t, ...)
    update_original(self, t, ...)

    if not self._card_chosen then
        self:_set_selected_and_sync(math.abs(2))
        self:confirm_pressed()
    end
    
    if not self._button_not_clickable and SYSHUD._settings.skip_card_screen then
        self._auto_continue_t = self._auto_continue_t or (t + SYSHUD._settings.skip_card_screen_delay)
        if t >= self._auto_continue_t then
            self:continue_to_lobby()
        end
    end
end