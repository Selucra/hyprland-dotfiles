#!/bin/bash

wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ "$1"

PERCENT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')

qs ipc call osd setVolume "$PERCENT"
