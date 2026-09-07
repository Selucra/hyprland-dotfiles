#!/bin/bash

mapfile -t REAL_PATHS < <(fd --type f --hidden . "$HOME")
[[ ${#REAL_PATHS[@]} -eq 0 ]] && exit 0

SELECTION_INDEX=$(
    for path in "${REAL_PATHS[@]}"; do
        printf "%s <span weight=\"light\" alpha=\"40%%\">  (%s)</span>\n" "${path##*/}" "${path/#$HOME/\~}"
    done | rofi -dmenu -markup-rows -p " " \
                -i -matching fuzzy -format i \
                -theme dmenu
)

if [[ -n "$SELECTION_INDEX" ]]; then
    REAL_PATH="${REAL_PATHS[$SELECTION_INDEX]}"
    MIME_TYPE=$(file --brief --mime-type "$REAL_PATH")

    SET_EDITOR="${EDITOR:-vscodium}"
    
    if [[ "$MIME_TYPE" =~ ^(text/|application/(json|x-shellscript|x-python|xml)) ]]; then
        "$SET_EDITOR" "$REAL_PATH" > /dev/null 2>&1 &
    else
        xdg-open "$REAL_PATH" > /dev/null 2>&1 &
    fi
fi
