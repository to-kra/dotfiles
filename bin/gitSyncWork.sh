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
enhanced_logs_enabled=true
git_repositories_root=$(realpath ~/ghe.fork/)
project_name="KC2.0"
local_repository_path="${git_repositories_root}/${project_name}"
fork_remote="origin"
project_remote="upstream"
default_branches=("master" "dev" "release")
feature_branches_string=$(cat $workingDir/gitSyncWork_KC2.0_featureBranches.txt |tr "\n" " ")
feature_branches=($feature_branches_string)
branches=("${default_branches[@]}" "${feature_branches[@]}")

# Colors
NC="\x1B[m"               # Color Reset
BWhite='\x1B[1;37m'       # White
BRed='\x1B[1;31m'         # Red
BGreen='\x1B[1;32m'       # Green
BYellow='\x1B[1;33m'      # Yellow

# Functions
function readFile {
    IFS=$'\n' read -d '' -r -a  < "$path_to_file"
}


function stringEquals {
    local str1=$1
    local str2=$2
    if [ "$str1" == "$str2" ]; then
        return 0
    fi
    return 1
}

function arrayJoinBy {
    local separator=$1
    local array=("${!2}")
    IFS=$separator
    echo "${array[*]// /|}"
    IFS=$' \t\n'
}

function log {
    if [ $enhanced_logs_enabled = true ] ; then
        logType="$1"
        case $logType in
            separator)
                echo "*************************************************************"
                echo -e "Synchronization started: ${BWhite}$(date)${NC}"
            ;;
            start)
                echo -e "${BWhite}Synchronization${NC} of '${BGreen}`arrayJoinBy "," branches[@]`${NC}' with ${BWhite}${project_remote} ${project_name}${NC}... ${BGreen}started${NC}"
            ;;
            end)
                echo -e "\n\n${BWhite}Synchronization${NC} of '${BGreen}`arrayJoinBy "," branches[@]`${NC}' with ${BWhite}${project_remote} ${project_name}${NC}... ${BGreen}finished${NC}"
            ;;
            vars)
                echo -e "\n-------------------------------------------------------------"
                echo -e "| git_repositories_root  : ${BWhite}${git_repositories_root}${NC}"
                echo -e "| project_name           : ${BWhite}${project_name}${NC}"
                echo -e "| local_repository_path  : ${BWhite}${local_repository_path}${NC}"
                echo -e "| branches               : ${BWhite}$(arrayJoinBy "," branches[@])${NC}"
                echo -e "| actual_branch          : ${BWhite}${actual_branch}${NC}"
                echo -e "| project_remote         : ${BWhite}${project_remote}${NC}"
                echo -e "| fork_remote            : ${BWhite}${fork_remote}${NC}"
                echo -e "-------------------------------------------------------------\n"
            ;;
            missingRemote)
                local remote="$2"
                echo -e "\t${BRed}>>> FATAL:${NC} Remote ${BWhite}${remote}${NC} does not exist ${BRed}!!!${NC}"
                echo -e "\tAdd remote with:"
                echo -e "\t\tgit remote add <REMOTE_NAME> <REMOTE_URL>"
                echo -e "\t\tgit remote add ${remote} git@github.ibm.com:IBMKC/${project_name}.git"
            ;;
            *)
                echo "${BRed}ERR: Sorry, I don't understand${NC}"
            ;;
        esac
    fi
}

function gitRemoteExist {
    local repository=$2
    cd $repository
    local remoteList=`git remote -v`
    if [[ "$remoteList" == *"$1"* ]]; then
        return 0;
    else
        return 1;
    fi
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

function gitGetActualCheckedOutBranch {
    local branch=`git branch | grep \* | cut -d ' ' -f2-`
    echo $branch
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

# << Abracadabra! Here's a the magic trick >>
function sync {
    for branch in "${branches[@]}"
    do
        echo -e "\n\n${BYellow}Start${NC} ${BWhite}synchronizing${NC} '${BGreen}${branch}${NC}' of '${BRed}${project_name}${NC}' with '${BRed}${project_remote}${NC}'..."
        synchBranch "${branch}" "${fork_remote}" "${project_remote}"
        echo -e "\nFinished ${BWhite}synchronizing${NC} '${BWhite}${branch}${NC}' of '${BRed}${project_name}${NC}' with '${BRed}${project_remote}${NC}'..."
    done
}

function setUp {
    # date time separator
    log "separator"
    
    # switch to repository dir
    cd $local_repository_path
    
    # get actual checked out branch
    actual_branch="$(gitGetActualCheckedOutBranch)"
    
    # check for remote upstream in local repo
    if ! gitRemoteExist "$project_remote" "`pwd`" ; then
        log "missingRemote" "$project_remote"
        exit 1
    fi
    
    # print input variables
    log "vars"
    
    # app start log
    log "start"
}

function tearDown {
    echo -e "\n\n> ${BWhite}Checking out${NC} previously active branch: '${BRed}${actual_branch}${NC}'"
    git checkout ${actual_branch}
    
    # app end log
    log "end"
}

# ========================
# =        Main          =
# ========================

# Set up
setUp

# sync of all branches
sync

# Tear down
tearDown
