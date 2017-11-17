#!/bin/bash

# resolve currentDirectory even if symlink
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
my_dir="$( cd -P "$( dirname "$source" )" && pwd )"

source $my_dir/os.sh
source $my_dir/homebrewTools.sh
#####################################################################
# Mac Homebrew
# Homebrew installation
if isMacOs ; then
  if notExistCommand 'brew' ; then
    printf 'Installation:\n> [macOs] RUBY installing BREW'
    #/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
  fi
fi

# Variables for homebrew to speed up functions
brewList=''
brewCaskList=''
brewTapList=''
if isMacOs ; then
  brewList=`brew list`
  #brewListVersions=`brew list --versions`
  brewCaskList=`brew cask list`
  #brewTapList=`brew tap`
fi