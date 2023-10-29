local spawn = require("awful").spawn

spawn.with_shell(
	'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
	-- 'xrdb -merge <<< "awesome.started:true";' ..
	'echo "awesome.started:true" | xrdb -merge;' ..
	-- list each of your autostart commands, followed by ; inside single quotes, followed by ..
	'dex --environment Awesome --autostart'
)
spawn("picom --daemon")
spawn("nm-applet")
spawn("cbatticon")
spawn("xfce4-power-manager")
