#!/usr/bin/env bash
##############
# setup dock
##############

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/Fantastical 2.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Things3.app"
dockutil --no-restart --add "/Applications/Workflowy.app"
dockutil --no-restart --add "/Applications/Telegram.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/Reeder.app"
dockutil --no-restart --add "/Applications/System Preferences.app"
dockutil --add '/Applications' --view grid --display folder --sort name
dockutil --add '~/Downloads' --view grid --display folder --sort dateadded
