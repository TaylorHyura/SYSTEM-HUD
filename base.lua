if SYSHUD then return end

_G.SYSHUD = _G.SYSHUD or {}
SYSHUD._mod_path = ModPath
SYSHUD._save_path = SavePath .. 'syshud.json'
SYSHUD._settings = {
	interaction = true,
	min_timer_duration = 0,
	equipment = true,
	empty_lobby = true
}

function SYSHUD:load()
	local file = io.open(self._save_path, 'r')
	if file then
		for k, v in pairs(json.decode(file:read('*all')) or {}) do
			self._settings[k] = v
		end
		file:close()
	end
end

SYSHUD:load()

function SYSHUD:save()
	local file = io.open(self._save_path, 'w')
	if file then
		file:write(json.encode(self._settings))
		file:close()
	end
end

Hooks:Add('LocalizationManagerPostInit', 'LocalizationManagerPostInit_SYSHUD', function(loc)
	loc:load_localization_file(SYSHUD._mod_path .. 'loc/english.json')
end)

Hooks:Add('MenuManagerInitialize', 'MenuManageInitialize_SYSHUD', function(menu_manager)
	MenuCallbackHandler.SYSHUDSave = function(this, item)
		SYSHUD:save()
	end
	MenuCallbackHandler.SYSHUDToggleOption = function(this, item)
		SYSHUD._settings[item:name()] = (item:value() == 'on')
	end
	MenuCallbackHandler.SYSHUDGenericOption = function(this, item)
		SYSHUD._settings[item:name()] = item:value()
	end
	MenuHelper:LoadFromJsonFile(SYSHUD._mod_path .. 'options.json', SYSHUD, SYSHUD._settings)
end)