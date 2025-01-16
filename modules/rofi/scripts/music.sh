#!/usr/bin/env bash


choice=$(printf "Previous\nPlay/Pause\nNext\nSpotify" | rofi -dmenu -i )
if [[ $choice == "Previous" ]];then
    playerctl -a previous
elif [[ $choice == "Play/Pause" ]];then
    playerctl -a play-pause
elif [[ $choice == "Next" ]];then
    playerctl -a next
elif [[ $choice == "Spotify" ]];then
    spotify-launcher
fi
