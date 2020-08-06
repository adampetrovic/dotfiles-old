#!/bin/bash

# check cli tool is installed
[[ ! -f $(which op) ]] && echo "Unable to find 1password-cli binary (op)" && exit 1

# set up 1password cli tool
check_login="$(op get account)"

if [[ $? -ne 0 ]] ; then
    export OP_SESSION_my="$(eval op signin my adam@petrovic.com.au --output=raw)"
fi
