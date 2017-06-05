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
#####################################################################

# Node.JS helpers functions
npmGlobalList=''
if isMacOs ; then
  npmGlobalList=`npm list -g --depth=0`
fi

function npmGlobalContains () {
  if [[ $npmGlobalList == *"$1"* ]]; then
    #echo "NPM: $1 exists :-)"
    return 0;
  else
    #echo "NPM: $1 does not exist !!!"
    return 1;
  fi
}

function npmInstallGlobal () {
  if ! npmGlobalContains "$1" ; then
    printf 'Installation:\n> [macOs] NPM installing: %s\n' "$1"
    npm install "$1" -g 
  fi
}