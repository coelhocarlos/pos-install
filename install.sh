#!/bin/bash
#
#     INSTALL SOFTWARE UNUNTU 18.04
#     
#
# Set a foreground colour using ANSI escape
# clear the screen

############################################
#          Check Compatbility
############################################
if [[ -r /etc/os-release ]]; then
    . /etc/os-release
    if [[ $ID = ubuntu ]]; then
        read _ UBUNTU_VERSION_NAME <<< "$VERSION"
        echo "Running Ubuntu $UBUNTU_VERSION_NAME"

    else
        echo "Not running an Ubuntu distribution. ID=$ID, VERSION=$VERSION"
    fi
else
    echo "Not running a distribution with /etc/os-release available"
fi



