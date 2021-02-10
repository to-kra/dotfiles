#!/bin/bash

# OS detection
isLinux=false
isUbuntu=false
isMac=false
isFreeBsd=false

function computeOs () {
    unamestr=`uname`
    if [[ "$unamestr" == 'Linux' ]]; then
        isLinux=true
        ubuntu_str=`cat /etc/os-release | grep ^NAME= | cut -f2 -d'"' | xargs`
        if [[ "$ubuntu_str" == 'Ubuntu' ]]; then
            isUbuntu=true
        fi
        elif [[ "$unamestr" == 'Darwin' ]]; then
        isMac=true
        elif [[ "$unamestr" == 'FreeBSD' ]]; then
        isFreeBsd=true
    fi
}

function isMacOs () {
    if [[ "$isMac" == true ]]; then
        return 0;
    fi
    return 1;
}

function isLinux () {
    if [[ "$isLinux" == true ]]; then
        return 0;
    fi
    return 1;
}

function isUbuntu () {
    if [[ "$isUbuntu" == true ]]; then
        return 0;
    fi
    return 1;
}

computeOs