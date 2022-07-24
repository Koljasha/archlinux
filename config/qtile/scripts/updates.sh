#!/usr/bin/env bash

#
# system updates
#

terminator -x yay -Su --removemake --cleanafter
qtile cmd-obj -o cmd -f reload_config

