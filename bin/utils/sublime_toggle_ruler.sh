#!/bin/bash

CONFIG=~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
PROG='
if .rulers | index(72) then
    .rulers |= . - [72]
else
    .rulers |= . + [72]
end'

jq "$PROG" "$CONFIG" | sponge "$CONFIG"
