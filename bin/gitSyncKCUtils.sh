#!/bin/bash
local_repos_dir=`realpath ~/ghe.fork/`
repo_name="KCUtils"
repo_path=${local_repos_dir}/${repo_name}
branch_remote_tracking="origin"
git_remote="upstream"
declare -a branches=("master")

# functions
function existRemote () {
    local repository=$2
    cd $repository
    local remoteList=`git remote -v`
    if [[ $remoteList == *"$1"* ]]; then
        #echo "Tap: $1 exists..."
        return 0;
    else
        #echo "Tap: $1 does not exist !!!"
    return 1;
  fi
}

function arrayJoinBy {
    local param1=$1
    local param2=("${!2}")
    IFS=$param1
    echo "${param2[*]// /|}"
    IFS=$' \t\n'
}

# print input variables
echo "local_repos_dir        : $local_repos_dir"
echo "repo_name              : $repo_name"
echo "repo_path              : $repo_path"
echo "branches               : `arrayJoinBy "," branches[@]`"
echo "branch_remote_tracking : $branch_remote_tracking"
echo "git_remote             : $git_remote"
echo ""

# Colors
NC="\x1B[m"               # Color Reset
BWhite='\x1B[1;37m'       # White
BRed='\x1B[1;31m'         # Red
BGreen='\x1B[1;32m'       # Green
BYellow='\x1B[1;33m'      # Yellow

# Main
cd ${repo_path}
echo -e "${BWhite}Synchronization${NC} '${BGreen}`arrayJoinBy "," branches[@]`${NC}' with ${BWhite}upstream:$repo_name${NC}... ${BGreen}started${NC}"

if ! existRemote "$git_remote" "`pwd`" ; then
    echo -e "\t${BRed}>>> FATAL:${NC} Remote ${BWhite}upstream${NC} does not exist ${BRed}!!!${NC}"
    echo -e "\tAdd remote with:"
    echo -e "\t\tgit remote add <REMOTE_NAME> <REMOTE_URL>"
    echo -e "\t\tgit remote add upstream git@github.ibm.com:IBMKC/${repo_name}.git"
    exit 1
fi

for branch in "${branches[@]}"
do
    echo -e "\n${BYellow}Start${NC} ${BWhite}synchronizing${NC} '${BRed}${branch}${NC}' of '${BRed}${repo_name}${NC}' with '${BRed}${git_remote}${NC}'..."

    echo -e "\n> ${BWhite}Fetching${NC} from '${BRed}${git_remote}${NC}'"
    git fetch ${git_remote}

    echo -e "\n> ${BWhite}Checking out${NC} '${BRed}${branch}${NC}'"
    git checkout ${branch}

    echo -e "\n> ${BWhite}Pulling${NC} '${BRed}${branch}${NC}' from '${BRed}${git_remote}${NC}'"
    git pull ${git_remote} ${branch}

    echo -e "\n> ${BWhite}Pushing${NC} '${BRed}${branch}${NC}' to '${BRed}${branch_remote_tracking}${NC}'"
    git push -u ${branch_remote_tracking} ${branch}

    echo -e "\nFinished ${BWhite}synchronizing${NC} '${BRed}${branch}${NC}' of '${BRed}${repo_name}${NC}' with '${BRed}${git_remote}${NC}'..."
done

echo -e "\n${BWhite}Synchronization${NC} '${BGreen}master${NC}' & '${BGreen}dev${NC}' & '${BGreen}release${NC}' with ${BWhite}upstream KC2.0${NC}... ${BGreen}finished${NC}"