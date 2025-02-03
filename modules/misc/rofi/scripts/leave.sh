#!/usr/bin/env bash

choice=$(printf "Lock\nLogout\nSuspend\nReboot\nShutdown" | rofi -dmenu -i )
if [[ $choice == "Lock" ]];then
    sleep 0.3
    swaylock-fancy -e -f Iosevka-NF-Bold -t "$(whoami)@$(hostname)"
elif [[ $choice == "Logout" ]];then
    sleep 0.1 
    hyprctl dispatch exit
elif [[ $choice == "Suspend" ]];then
    systemctl suspend
elif [[ $choice == "Reboot" ]];then
    systemctl reboot
elif [[ $choice == "Shutdown" ]];then
    systemctl poweroff
fi
