#!/bin/bash
# Variables
local_repos_dir=`realpath ~/ghe.fork/`
repo_name="KC2.0"
repo_path=${local_repos_dir}/${repo_name}
branch_remote_tracking="origin"
git_remote="upstream"
default_branch="dev"
declare -a branches=("master" "$default_branch" "release" "disqus" "video-search")

# Colors
NC="\x1B[m"               # Color Reset
BWhite='\x1B[1;37m'       # White
BRed='\x1B[1;31m'         # Red
BGreen='\x1B[1;32m'       # Green
BYellow='\x1B[1;33m'      # Yellow

# Functions
function existRemote () {
    local repository=$2
    cd $repository
    local remoteList=`git remote -v`
    if [[ $remoteList == *"$1"* ]]; then
        return 0;
    else
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

function printlnSeparator {
    echo "============================================================="
    echo "Sync started: '`date`'"
}

function printVars {
    echo -e "\n-------------------------------------------------------------"
    echo -e "| local_repos_dir        : ${BWhite}${local_repos_dir}${NC}"
    echo -e "| repo_name              : ${BWhite}${repo_name}${NC}"
    echo -e "| repo_path              : ${BWhite}${repo_path}${NC}"
    echo -e "| branches               : ${BWhite}`arrayJoinBy "," branches[@]`${NC}"
    echo -e "| branch_remote_tracking : ${BWhite}${branch_remote_tracking}${NC}"
    echo -e "| git_remote             : ${BWhite}${git_remote}${NC}"
    echo -e "-------------------------------------------------------------\n"
}

function printMissingRemote {
    local remote="$1"
    echo -e "\t${BRed}>>> FATAL:${NC} Remote ${BWhite}${remote}${NC} does not exist ${BRed}!!!${NC}"
    echo -e "\tAdd remote with:"
    echo -e "\t\tgit remote add <REMOTE_NAME> <REMOTE_URL>"
    echo -e "\t\tgit remote add ${remote} git@github.ibm.com:IBMKC/${repo_name}.git"
}

function gitCheckout {
    local branch="$1"
    echo -e "\n> ${BWhite}Checking out${NC} '${BRed}${branch}${NC}'"
    git checkout ${branch}
}

function gitFetch {
    local remote="$1"
    echo -e "\n> ${BWhite}Fetching${NC} from '${BRed}${remote}${NC}'"
    git fetch ${remote}
}

function gitPull {
    local remote="$1"
    local branch="$2"
    echo -e "\n> ${BWhite}Pulling${NC} '${BRed}${branch}${NC}' from '${BRed}${remote}${NC}'"
    git pull ${remote} ${branch}
}

function gitPush {
    local remote="$1"
    local branch="$2"
    echo -e "\n> ${BWhite}Pushing${NC} '${BRed}${branch}${NC}' to '${BRed}${remote}${NC}'"
    git push -u ${remote} ${branch}
}

function synchBranch {
    local branch="$1"
    local remote_fork="$2"
    local remote_project="$3"
    gitFetch ${remote_project}
    gitCheckout ${branch}
    gitPull ${remote_project} ${branch}
    gitPush ${remote_fork} ${branch}
}

# ========================
# =        Main          =
# ========================

# Log separator
printlnSeparator

# print input variables
printVars
cd ${repo_path}
echo -e "${BWhite}Synchronization${NC} of '${BGreen}`arrayJoinBy "," branches[@]`${NC}' with ${BWhite}${git_remote} ${repo_name}${NC}... ${BGreen}started${NC}"

# check for remote upstream in local repo
if ! existRemote "${git_remote}" "`pwd`" ; then
    printMissingRemote "${git_remote}"
    exit 1
fi

# sync of all branches
for branch in "${branches[@]}"
do
    echo -e "\n${BYellow}Start${NC} ${BWhite}synchronizing${NC} '${BGreen}${branch}${NC}' of '${BRed}${repo_name}${NC}' with '${BRed}${git_remote}${NC}'..."
    synchBranch "${branch}" "${branch_remote_tracking}" "${git_remote}"
    echo -e "\nFinished ${BWhite}synchronizing${NC} '${BWhite}${branch}${NC}' of '${BRed}${repo_name}${NC}' with '${BRed}${git_remote}${NC}'..."
done

# checkout default branch at the end
echo -e "\n> ${BWhite}Checking out${NC} default branch: '${BRed}${default_branch}${NC}'"
git checkout ${default_branch}

echo -e "\n${BWhite}Synchronization${NC} of '${BGreen}`arrayJoinBy "," branches[@]`${NC}' with ${BWhite}${git_remote} ${repo_name}${NC}... ${BGreen}finished${NC}"
