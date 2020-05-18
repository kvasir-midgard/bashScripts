#!/bin/sh

# List of possible pannel commands
# xfconf-query -c xfce4-panel -p /panels/panel-1 -l

# xfce 4.12
PANEL1=$(cat /$HOME/.config/xfce4/panel/panel-hide)

if test $PANEL1 = 0; then
	xfconf-query -c xfce4-panel -p /panels/panel-1/autohide-behavior -s 2
	echo "2" > /$HOME/.config/xfce4/panel/panel-hide

	# xfce 4.10
	# xfconf-query -c xfce4-panel -p /panels/panel-1/autohide -s true
else
	xfconf-query -c xfce4-panel -p /panels/panel-1/autohide-behavior -s 0
	echo "0" > /$HOME/.config/xfce4/panel/panel-hide

	# xfce 4.10
	# xfconf-query -c xfce4-panel -p /panels/panel-1/autohide -s false
fi