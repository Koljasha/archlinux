#!/usr/bin/env bash

# Show all active i3wm binding

grep bindsym ~/.config/i3/config | grep -E -v "^#" | grep -E -v "^ "\
    | sed 's/bindsym //' | sed 's/--no-startup-id //' | sed 's/exec //' | sed 's/ / -> /'\
    | sed -r 's/^(.*) -> /\x1b[34m\1\x1b[0m -> /'\
    | sed -r 's/ -> (.*)$/ -> \x1b[31m\1\x1b[0m/'

