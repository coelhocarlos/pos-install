
#!/bin/bash
# dvdcopy.sh - A sample shell script to display a progress bar
# set counter to 0 
set -eu -o pipefail # fail on error , debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo priveledge to run this script"

echo installing the must-have pre-requisites
counter=0
(
# set infinite while loop
while :
do
while read -r p ; do sudo apt-get install -y $p ; done < <( cat <<"EOF"
$counter
perl
    zip unzip
    exuberant-ctags
    mutt
    libxml-atom-perl
    postgresql-9.6
    libdbd-pgsql
    curl
    wget
    libwww-curl-perl
    EOF
 ( $counter%):
XXX
EOF
# increase counter by 10
(( counter+=10 ))
[ $counter -eq 100 ] && break
# delay it a specified amount of time i.e 1 sec
sleep 1
done
) |
dialog --title "File Copy" --gauge "Please wait" 7 70 0
