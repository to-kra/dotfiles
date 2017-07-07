#!/bin/bash

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