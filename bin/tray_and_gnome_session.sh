sleep 2s

feh --bg-fill  /usr/share/backgrounds/mate/nature/Aqua.jpg
trayer --edge top --align right --SetDockType true --SetPartialStrut true  --expand true --width 10 --transparent true --tint 0x191970 --height 18 &
# gnome-session &
# mate-session &
mate-settings-daemon &

sleep 1

nm-applet --sm-disable &

mate-power-manager &

mate-screensaver &

dropbox start &
