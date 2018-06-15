   #!/bin/bash

cmd=(dialog --clear --backtitle "Get You Online Commander" --title "Get You Online Commander" --menu "What would you like to do?" 20 40 11)

options=(0 "Install/Update the Commander"
         1 "Create a New Site"
         2 "Install a Wordpress Site"
         3 "Account Backup"
         4 "Account Restore"
         5 "Terminate an Account"
         6 "Generate SSL Certificates"
         7 "Optimize Images"
         8 "Restart Commander Services"
         9 "Clear Server Cache"
         10 "Prime Websites Caches")

while true; do

    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    # If cancelled, drop the dialog
    if [ $? -ne 0 ]; then
        clear;
        exit;
    fi;

    for choice in $choices; do
        case $choice in
            0) 
                echo ""
                echo "Installing/Updating the Commander"
                echo "Please pay attention, this may not be an un-attended install"
                echo "Are you sure you want to do this? (y/n)"
                read IUGYOC
                if [[ -z $IUGYOC ]] || [[ $IUGYOC == 'n' ]]; then
                    echo "Please decide y/n if you would like to do this."
                    sleep 2
                elif [[ $IUGYOC == 'y' ]]; then
                    git pull origin master;
                    mv usr/installer $DIR;
                    bash installer;
                    mv $DIR/installer $DIR/usr/
                    echo "I would recommend you close out this script, and then re-run it..."
                    echo "Just in case I've updated it..."
                    sleep 2
                fi;
                ;; 
            1) 
                echo ""
                echo "Creating a New Site"
                echo "Please pay attention, this may not be an un-attended install"
                sleep 1;
                new-site;
                ;;
            2)
                echo ""
                echo "Installing Wordpress"
                echo "Please pay attention, this may not be an un-attended install"
                sleep 1;
                echo "Please type in an existing account name:"
                read WPAN;
                if [[ -z $WPAN ]]; then
                    echo "This cannot be completed without the account name.  Please try again."
                    sleep 2;
                else
                    install-wordpress $WPAN;
                fi;
                ;;
            3)
                echo ""
                echo "Running a Backup"
                echo "Please type in an existing account name to backup that account. (just hit enter to back them all up)"
                read MBU;
                if [[ -z $MBU ]]; then
                    account-backup >/dev/null 2>&1;
                else
                    account-backup $MBU >/dev/null 2>&1;
                fi;
                echo "Backup Completed"
                sleep 1;
                ;;
            4)
                echo ""
                echo "Restoring an Account"
                echo "Please note, this requires the backup to be in the /home directory."
                echo "If it is not, please hit enter to exit, otherwise:"
                echo "Please type the account name: "
                read RAN;
                echo "Please type the backup date: (YYYY-MM-DD)"
                read RAD
                if [[ -z $RAN ]] || [[ -z $RAD ]]; then
                    echo "You will need to pass the Account Name, and the Date before you can do this."
                    sleep 2;
                else
                    account-restore $RAN $RAD >/dev/null 2>&1;
                fi;
                ;;
            5)
                echo ""
                echo "Terminating an Account"
                echo "Please type in the account name to terminate:"
                read TERMA
                if [[ -z $TERMA ]]; then
                    echo "This cannot be completed without the account name.  Please try again."
                    sleep 2;
                else
                    terminate-account $TERMA >/dev/null 2>&1;
                fi;
                ;;
            6)
                #generate SSL certs
                echo ""
                echo "Generating SSL Certificate"
                echo "Please enter the account name for this certificate:"
                read CAN;
                echo "Please enter a comma-delimited list of domains, that should be associated with the certificate:"
                echo "For example: getyou.onl,www.getyou.onl,getme.onl,www.getme.onl"
                echo "Also note, these domains MUST already be pointing at this server."
                read CADs;
                if [[ -z $CAN ]] || [[ -z $CADs ]]; then
                    echo "You will need to pass the Account Name, and a comma-delimited list of domains."
                    sleep 2;
                else
                    gen-cert $CAN "$CADs"; # Let's see the errors if any, that way we know if the domain is pointed here, etc...
                fi;         
                ;;
            7) 
                #optimize images
                echo ""
                echo "Optimizing Images"
                echo "Please type in an existing account name to optimize that account. (just hit enter to optimize them all up)"
                echo "Please note, this will take awhile, do not interrupt this process, or you will end up with corrupt images."
                read OPTIMG
                if [[ -z $OPTIMG ]]; then
                    optimages >/dev/null 2>&1;
                else
                    optimages $OPTIMG >/dev/null 2>&1;
                fi;
                ;;
            8)
                #restart commander
                echo ""
                echo "Restarting the Commander"
                echo "Are you sure you want to do this? (y/n)"
                read RSC
                if [[ -z $RSC ]] || [[ $RSC == 'n' ]]; then
                    echo "Please decide y/n if you would like to do this."
                    sleep 2
                elif [[ $RSC == 'y' ]]; then
                    restart-commander >/dev/null 2>&1;
                    echo "Commander Restarted"
                    sleep 2
                fi;
                ;;
            9)
                #clear cache
                echo ""
                echo "Clearing Server caches"
                echo "Are you sure you want to do this? (y/n)"
                read CCSC
                if [[ -z $CCSC ]] || [[ $CCSC == 'n' ]]; then
                    echo "Please decide y/n if you would like to do this."
                    sleep 2
                elif [[ $CCSC == 'y' ]]; then
                    clear-cache >/dev/null 2>&1;
                    echo "Cache Cleared"
                    sleep 2
                fi;
                ;;
            10) 
                #prime caches
                echo ""
                echo "Priming (or Warming Up) Site Caches"
                echo "Please type in an existing account name to prime that account. (just hit enter to prime them all up)"
                echo "Please note, this will take awhile, please have some patience."
                read PSC
                if [[ -z $PSC ]]; then
                    site-primer >/dev/null 2>&1;
                else
                    site-primer $PSC >/dev/null 2>&1;
                fi;
                echo "Sites Primed"
                sleep 2
                ;;
            *)
                exit 
                ;;
        esac        
    done

done
