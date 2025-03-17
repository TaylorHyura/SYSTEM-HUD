local update_original = IngameWaitingForPlayersState.update

function IngameWaitingForPlayersState:update(...)
    update_original(self, ...)
    
    if self._skip_promt_shown and SYSHUD._settings.skip_black_screen then
        self:_skip()
    end
end