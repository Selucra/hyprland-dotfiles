#!/bin/bash

if pkill -x rofi; then
    exit 0
fi

case "$1" in
    drun)
        rofi -show drun ;;
    file)
        ~/.config/rofi/scripts/filepicker.sh ;;
    clip)
        cliphist list | rofi -dmenu -p " " -theme dmenu | cliphist decode | wl-copy ;;
    emoji)
        rofimoji --max-recent 0 --action clipboard --selector-args="-theme dmenu" ;;
esac
