#!/bin/bash

LIST="apt-get install mysql apt-get install php7-dev "             #Note that there is a different when we 
INT=1                                          #use (),"",'' .Maybe Ill explain in diff. post  
CNT=0                

for NIM in ${LIST}                         #For function  as controlling loop
do
    
    len=$(echo ${LIST} | wc -w)             #"wc"command is used print new line
    echo -en "\b\b\b$(($NIM*100/$len))%" 
    sleep $INT
    

done
