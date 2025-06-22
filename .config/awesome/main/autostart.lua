local spawn = require("awful").spawn

spawn.with_shell([[
if (xrdb -query | grep -q "^awesome\.started:\s*true$"); then exit; fi;
echo "awesome.started:true" | xrdb -merge;
dex --environment Awesome --autostart
]])
spawn("cbatticon")
spawn.with_shell("pkill norduserd && /usr/lib/nordvpn/norduserd")
spawn("xfce4-power-manager")
