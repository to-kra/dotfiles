#!/bin/bash

function stringContains() {
    local FULL_STRING=$1
    local STRING_TO_FIND=$2
    if [[ $FULL_STRING == *"$STRING_TO_FIND"* ]] ; then
        return 0
    fi
    return 1
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