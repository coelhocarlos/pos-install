 #!/bin/bash
declare PACKAGES=("apt-get install mysql"  "apt-get install php7")
 show_dialog()
{
    p=$PACKAGES             # percentage
    date1=`date +%s`
    while [ "$p" != 100 ]; do
        read -t 1 tmp && p=$tmp
        elapsed="$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)"
        echo $p | dialog --title "File upgrade" --gauge "Please wait...\n\n\n\n$elapsed" 10 70 0
    done
}

task()              # fake task
{ for p in `seq 1 100`; do echo $p; sleep 2; done; }

task | show_dialog
