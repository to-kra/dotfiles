#!/bin/bash
repository=~/ghe.fork/KC2.0/

#colors
NC="\x1B[m"               # Color Reset
BWhite='\x1B[1;37m'       # White
BRed='\x1B[1;31m'         # Red
BGreen='\x1B[1;32m'       # Green

function existRemote () {
    cd $repository
    remoteList=`git remote -v`
    if [[ $remoteList == *"$1"* ]]; then
        #echo "Tap: $1 exists..."
        return 0;
    else
        #echo "Tap: $1 does not exist !!!"
    return 1;
  fi
}

echo -e "${BWhite}Synchronization${NC} '${BGreen}master${NC}' & '${BGreen}dev${NC}' & '${BGreen}release${NC}' with ${BWhite}upstream KC2.0${NC}... ${BGreen}started${NC}"

if ! existRemote 'upstream' ; then
    echo -e "\t${BRed}>>> FATAL:${NC} Remote ${BWhite}upstream${NC} does not exist ${BRed}!!!${NC}"
    echo -e "\tAdd remote with:"
    echo -e "\t\tgit remote add <REMOTE_NAME> <REMOTE_URL>"
    echo -e "\t\tgit remote add upstream git@github.ibm.com:IBMKC/KC2.0.git"
    exit 1
fi

cd $repository
git fetch upstream

#master
echo -e "\n> ${BWhite}Checking out${NC} '${BGreen}master${NC}'"
git checkout master
echo -e "\n> ${BWhite}Pull${NC} '${BRed}master${NC}' from '${BRed}upstream${NC}'"
git pull upstream master
#echo -e "\n> ${BWhite}Merge${NC} '${BRed}upstream/master${NC}' to '${BRed}local/master${NC}'"
# ?? maybe not needed
git merge upstream master
echo -e "\n> ${BWhite}Push${NC} '${BRed}master${NC}' to '${BRed}origin/master${NC}'"
git push origin master

#dev
echo -e "\n> ${BWhite}Checking out${NC} '${BGreen}dev${NC}'"
git checkout dev
echo -e "\n> ${BWhite}Pull${NC} '${BRed}dev${NC}' from '${BRed}upstream${NC}'"
git pull upstream dev
#echo -e "\n> ${BWhite}Merge${NC} '${BRed}upstream/dev${NC}' to '${BRed}local/dev${NC}'"
# ?? maybe not needed
git merge upstream dev
echo -e "\n> ${BWhite}Push${NC} '${BRed}local/dev${NC}' to '${BRed}origin/dev${NC}'"
git push -u origin dev

#release
echo -e "\n> ${BWhite}Checking out${NC} '${BGreen}release${NC}'"
git checkout release
echo -e "\n> ${BWhite}Pull${NC} '${BRed}release${NC}' from '${BRed}upstream${NC}'"
git pull upstream release
#echo -e "\n> ${BWhite}Merge${NC} '${BRed}upstream/dev${NC}' to '${BRed}local/dev${NC}'"
# ?? maybe not needed
git merge upstream release
echo -e "\n> ${BWhite}Push${NC} '${BRed}local/release${NC}' to '${BRed}origin/release${NC}'"
git push -u origin release

echo -e "${BWhite}Synchronization${NC} '${BGreen}master${NC}' & '${BGreen}dev${NC}' & '${BGreen}release${NC}' with ${BWhite}upstream KC2.0${NC}... ${BGreen}finished${NC}"