#!/bin/bash

brightnessctl -n2 set "$1"

PERCENT=$(brightnessctl -m | cut -d, -f4 | tr -d '%')

qs ipc call osd setBrightness "$PERCENT"
