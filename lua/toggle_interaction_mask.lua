local PlayerMaskOff__check_use_item_original = PlayerMaskOff._check_use_item

function PlayerMaskOff:_check_use_item( t, input )
    if SYSHUD._settings.toggleable_mask then
        if input.btn_use_item_press and self._start_standard_expire_t then
            self:_interupt_action_start_standard()
            return false
        elseif input.btn_use_item_release then
            return false
        end
    end

    return PlayerMaskOff__check_use_item_original(self, t, input)
end
