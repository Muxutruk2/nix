local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Window

local mux = wezterm.mux

wezterm.on("gui-attached", function(_)
	-- maximize all displayed windows on startup
	local workspace = mux.get_active_workspace()
	for _, window in ipairs(mux.all_windows()) do
		if window:get_workspace() == workspace then
			window:gui_window():maximize()
		end
	end
end)

config.window_close_confirmation = "AlwaysPrompt"

config.max_fps = 75

-- Program
config.default_prog = { "fish" }

-- Font
config.font = wezterm.font("CaskaydiaCove Nerd Font Mono")

-- Color Scheme
config.color_scheme = "Gruvbox Dark (Gogh)"
config.window_background_gradient = {
	orientation = "Vertical",
	colors = {
		"#32302F",
		"#1D2021",
	},
	interpolation = "Linear",
	blend = "Oklab",
	noise = 20,
}

config.window_background_opacity = 0.2

-- Lauch Menu
local launch_menu = {}

table.insert(launch_menu, {
	label = "TMUX",
	args = { "tmux", "new", "-As0" },
})

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})
end

config.launch_menu = launch_menu

-- Tab Bar
config.enable_tab_bar = false

-- Keybindings
config.keys = {
	{ key = "a", mods = "ALT", action = wezterm.action.ShowLauncher },
}

return config
