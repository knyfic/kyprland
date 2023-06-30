#!/usr/bin/env bash

# Current Theme
dir="$HOME/.config/hyprlandscripts"
theme='menutheme'

# CMDs
lastlogin="`last $USER | head -n1 | tr -s ' ' | cut -d' ' -f5,6,7`"
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
hibernate='󰱝'
shutdown=''
reboot='󰉋'
lock='󰆍'
suspend='󰹑'
logout='󰟃'
yes=''
no=''

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "󰣇 $USER" \
		-mesg " Uptime: $uptime" \
		-theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
		-theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${dir}/${theme}.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$hibernate\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
    selected="yes"  # Change this line to set the default selection to "yes"
    if [[ $1 == '--shutdown' ]]; then
        $HOME/.config/hyprlandscripts/powermenu
    elif [[ $1 == '--reboot' ]]; then
        thunar
    elif [[ $1 == '--hibernate' ]]; then
        hyprctl kill
    elif [[ $1 == '--suspend' ]]; then
            slurp | grim -g - ~/Pictures/Screenshots/$(date +'%Y%m%d%H%M%S_1.png') && notify-send 'Screenshot Saved'
    elif [[ $1 == '--logout' ]]; then
            $HOME/.config/hyprlandscripts/launcher.sh
    fi
}


# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $hibernate)
		run_cmd --hibernate
        ;;
    $lock)
			kitty
        ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
esac
