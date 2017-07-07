#!/bin/bash

# resolve currentDirectory even if symlink
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
    currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
    source="$(readlink "$source")"
    [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
workingDir="$( cd -P "$( dirname "$source" )" && pwd )"

# Variables
servers_lists_file="$workingDir/.ssh-copy/rtp_servers_list.txt"

# Colors
NC="\x1B[m"               # Color Reset
BWhite='\x1B[1;37m'       # White
BRed='\x1B[1;31m'         # Red
BGreen='\x1B[1;32m'       # Green
BYellow='\x1B[1;33m'      # Yellow

# ========================
# =        Main          =
# ========================

i=0
while read line
do
    user=$(echo ${line} | cut -d ";" -f1)
    password=$(echo ${line} | cut -d ";" -f2)
    server=$(echo ${line} | cut -d ";" -f3)

    echo -e "> ${BYellow}Adding${NC} ssh key to:\n\tuser= '${BWhite}$user${NC}', server= '${BWhite}$server${NC}'\n"
    ping -c1 ${server}
    if [ $? -eq 0 ] ; then
        sshpass -p "${password}" ssh-copy-id ${user}@${server}
        echo -e "...${BGreen}done${NC} !\n\n"
    else
        echo -e "...${BRed}ERR: Server not responding !${NC}\n\n"
    fi
    
    i=$((i+1))
done < ${servers_lists_file}
