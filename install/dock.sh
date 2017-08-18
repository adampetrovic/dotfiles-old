#!/usr/bin/env bash
##############
# setup dock
##############

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/Google Chrome Canary.app"
dockutil --no-restart --add "/Applications/Calendar.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/Things3.app"
dockutil --no-restart --add "/Applications/Telegram.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/System Preferences.app"
dockutil --add '/Applications' --view grid --display folder --sort name
dockutil --add '~/Downloads' --view grid --display folder --sort dateadded
dockutil --add '~/Atlassian' --view grid --display folder --sort name
