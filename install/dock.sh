#!/usr/bin/env bash
##############
# setup dock
##############

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/Fantastical.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/Obsidian.app"
dockutil --no-restart --add "/Applications/Things3.app"
dockutil --no-restart --add "/Applications/Telegram.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/Reeder.app"
if [ -d "/Applications/Slack.app" ]; then
    dockutil --no-restart --add "/Applications/Slack.app"
fi
if [ -d "/Applications/Cisco/Cisco AnyConnect Secure Mobility Client.app" ]; then
    dockutil --no-restart --add "/Applications/Cisco/Cisco AnyConnect Secure Mobility Client.app"
fi
if [ -d "/Applications/System Preferences.app" ]; then
    dockutil --no-restart --add "/Applications/System Preferences.app"
else
    dockutil --no-restart --add "/System/Applications/System Preferences.app"
fi
dockutil --add '/Applications' --view grid --display folder --sort name
dockutil --add '~/Downloads' --view grid --display folder --sort dateadded
