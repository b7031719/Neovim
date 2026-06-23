local editor = "kitty -e nvim"
local fileManager = "kitty -e yazi"
local menu = "wofi --show drun"
local terminal = "kitty"
local browser = "zen-twilight.desktop"
local screenshot_dir = "/mnt/data/Pictures/Screenshots"
local screen_recording_filename = nil

-- function for sending notifications
local function notify(title, text)
	hl.exec_cmd(string.format('dunstify "%s" "%s"', title, text))
end

-- function to run wf-recorder to record the screen (runs in toggle mode)
local function screen_record(opts)
	opts = opts or {}

	-- Check if wf-recorder is running
	local handle = io.popen("pgrep -x wf-recorder 2>/dev/null")
	local output = handle and handle:read("*a") or "" -- check handle is not nil then read the output (pid) or empty string to prevent match error
	if handle then
		handle:close() -- close the handle if valid
	end

	local is_running = output:match("%d") ~= nil -- check for a valid integer pid for running status

	-- Stop the recording process if already running, else start recording
	if is_running then
		hl.exec_cmd("pkill -INT wf-recorder 2>/dev/null")
		notify("Recording saved", screen_recording_filename)
		screen_recording_filename = nil
	else
		local timestamp = os.date("%Y-%m-%d_%H-%M-%S")
		screen_recording_filename = screenshot_dir .. "/recording-full-" .. timestamp .. ".mp4"

		if opts.mode == "full" then
			hl.exec_cmd("wf-recorder -f " .. screen_recording_filename)
		elseif opts.mode == "region" then
			hl.exec_cmd("wf-recorder -g \"$(slurp)\" -f " .. screen_recording_filename)
		else
			notify("Recording failed", "mode not specified")
		end
	end
end

hl.config({
	general = {

		border_size = 1,
		col = {
			active_border = { colors = { "rgb(168,153,132)", "rgb(168,153,132)" } },
		},
	},

	decoration = {
		rounding = 10,
		blur = {
			enabled = true,
			size = 3,
			passes = 3,
			ignore_opacity = true,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		default_split_ratio = 1,
		force_split = 0,
		preserve_split = true,
		smart_resizing = true,
		smart_split = true,
	},

	input = {
		kb_layout = "gb",
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		disable_watchdog_warning = true,
	},
})

-- Curves
hl.curve("custom", { type = "bezier", points = { { 0.2, 0.3 }, { 0, 1 } } })

-- Animations
hl.animation({ leaf = "windows", enabled = true, speed = 8, bezier = "custom", style = "slide" })
hl.animation({ leaf = "layers", enabled = true, speed = 8, bezier = "custom", style = "slide" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 8, bezier = "custom", style = "slidefadevert" })

-- Keybinds
hl.bind("SUPER + Q", hl.dsp.exec_raw("uwsm app -- " .. terminal))
hl.bind("SUPER + M", hl.dsp.exec_raw("uwsm app -- " .. menu))
hl.bind("SUPER + C", hl.dsp.window.close())
hl.bind("SUPER + B", hl.dsp.exec_raw("uwsm app -- " .. browser))
hl.bind("SUPER + T", hl.dsp.window.float())
hl.bind("SUPER + E", hl.dsp.exec_raw("uwsm app -- " .. fileManager))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("SUPER + N", hl.dsp.exec_raw("uwsm app -- " .. editor))
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + P", hl.dsp.exec_cmd("mirror-toggle"))
hl.bind("SUPER + CTRL + s", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + " .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind("SUPER + SHIFT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))
hl.bind("SUPER + CTRL + left", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + CTRL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + CTRL + up", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + CTRL + down", hl.dsp.window.move({ direction = "down" }))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("lid-toggle close"))
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("lid_toggle open"))
hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("ALT + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshot and screen recording keybinds
hl.bind("SUPER + S", function()
	notify("called", "called")
	local timestamp = os.date("%Y-%m-%d_%H-%M-%S")
	local filepath = screenshot_dir .. "/screenshot-" .. timestamp .. ".png"

	local cmd = string.format(
		'grim -g "$(slurp -d)" -t ppm - | satty --filename - --fullscreen --output-filename %s && wl-copy < %s',
		filepath,
		filepath
	)
	hl.exec_cmd(cmd)
end, { description = "Region screenshot to Satty then save as file then copy to clipboard" })

hl.bind("SUPER + SHIFT + S", function()
	local timestamp = os.date("%Y-%m-%d_%H-%M-%S")
	local filepath = screenshot_dir .. "/screenshot-full-" .. timestamp .. ".png"

	local cmd = string.format(
		"grim -t ppm - | satty --filename - --fullscreen --output-filename %s && wl-copy < %s",
		filepath,
		filepath
	)
	hl.exec_cmd(cmd)
end, { description = "Full screen screenshot to Satty then save as file then copy to clipboard " })

hl.bind("SUPER + R", function()
	screen_record({ mode = "region" })
end, { description = "Region recording" })

hl.bind("SUPER + SHIFT + R", function()
	screen_record({ mode = "full" })
end, { description = "Full screen recording" })

-- Startup apps
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprlock")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("uwsm app -- waybar")
end)

-- Monitor configs
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

hl.monitor({
	output = "desc:Dell Inc. DELL U2725QE CPXTD84",
	mode = "preferred",
	position = "auto",
	scale = 1.5,
})
