#!/bin/bash

#-------------------------------------------------------------
# Color definitions
#-------------------------------------------------------------

# Taken from Color Bash Prompt HowTo).

# Normal Colors
Black='\x1B[0;30m'        # Black
Red='\x1B[0;31m'          # Red
Green='\x1B[0;32m'        # Green
Yellow='\x1B[0;33m'       # Yellow
Blue='\x1B[0;34m'         # Blue
Purple='\x1B[0;35m'       # Purple
Cyan='\x1B[0;36m'         # Cyan
White='\x1B[0;37m'        # White

# Bold
BBlack='\x1B[1;30m'       # Black
BRed='\x1B[1;31m'         # Red
BGreen='\x1B[1;32m'       # Green
BYellow='\x1B[1;33m'      # Yellow
BBlue='\x1B[1;34m'        # Blue
BPurple='\x1B[1;35m'      # Purple
BCyan='\x1B[1;36m'        # Cyan
BWhite='\x1B[1;37m'       # White

# Background
On_Black='\x1B[40m'       # Black
On_Red='\x1B[41m'         # Red
On_Green='\x1B[42m'       # Green
On_Yellow='\x1B[43m'      # Yellow
On_Blue='\x1B[44m'        # Blue
On_Purple='\x1B[45m'      # Purple
On_Cyan='\x1B[46m'        # Cyan
On_White='\x1B[47m'       # White

NC="\x1B[m"               # Color Reset

function getIP() {
    echo "`ip route get 8.8.8.8 | awk '{print $NF; exit}'`"
}

function test() {
    echo -e "\nYou are logged on ${BRed}`getIP`"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
}

#test
