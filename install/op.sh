#!/bin/bash

# set up 1password cli tool
check_login="$(op get account)"

if [[ $? -ne 0 ]] ; then
    export OP_SESSION_my="$(eval op signin my adam@petrovic.com.au --output=raw)"
fi
