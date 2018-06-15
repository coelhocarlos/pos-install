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
        
#tput setb 3 #Green in xterm and brown in linux terminal
tput clear
#paint menu onto the screen
echo ""

echo ""

echo "TEST MENU"

echo "1 ..... ECHO 1"

echo "2 ..... ECHO 2"

echo "3 ..... ECHO 3"

echo "4 ..... QUIT"

echo ""

echo "Select item: "

#loop around gathering input until QUIT is more than 0

QUIT=0

while [ $QUIT -lt 1 ]

do

   #Move cursor to after select message

   tput cup 8 13

   #Delete from cursor to end of line

   tput el

   read SEL

   if [ ${#SEL} -lt 1 ]

   then

      continue

   fi

   if [ $SEL -eq 4 ]

   then

      QUIT=1

      continue

   fi

   #put message in middle of screen

   tput cup 15 20

   #Delete from cursor to end of line

   tput el

   case $SEL in

      *) echo "You selected $SEL";;

   esac

done

#reset the screen

#Find out if this is a "linux" virtual terminal

if [ $TERM ~ "linux" ]

then

     tput setb 0 #reset background to black

fi

tput reset

tput clear
    else
        echo "Not running an Ubuntu distribution. ID=$ID, VERSION=$VERSION"
    fi
else
    echo "Not running a distribution with /etc/os-release available"
fi



