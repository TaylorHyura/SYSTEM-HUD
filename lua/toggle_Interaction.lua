local PlayerStandard__check_action_interact_original = PlayerStandard._check_action_interact
local PlayerStandard__check_use_item_original = PlayerStandard._check_use_item

function PlayerStandard:_check_action_interact(t, input)
    if SYSHUD._settings.toggleable_interaction then
        if input.btn_interact_press and self:_interacting() then
            self:_interupt_action_interact()
            return false
        elseif input.btn_interact_release and self._interact_params and self._interact_params.timer >= SYSHUD._settings.toggleable_min_interaction_duration then
            return false
        end
    end

    return PlayerStandard__check_action_interact_original(self, t, input)
end

function PlayerStandard:_check_use_item(t, input)
    if SYSHUD._settings.toggleable_equipment then
        if input.btn_use_item_press and self:is_deploying() then
            self:_interupt_action_use_item()
            return false
        elseif input.btn_use_item_release then
            return false
        end
    end

    return PlayerStandard__check_use_item_original(self, t, input)
end