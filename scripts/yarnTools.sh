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

# YARN helpers functions
yarnGlobalList=''
if isMacOs ; then
    yarnGlobalList=$(yarn global list 2>/dev/null)
fi

function yarnGlobalContains () {
  if [[ $yarnGlobalList == *"$1"* ]]; then
    #echo "YARN: $1 exists :-)"
    return 0;
  else
    #echo "YARN: $1 does not exist !!!"
    return 1;
  fi
}

function yarnGlobalAdd () {
  if ! yarnGlobalContains "$1" ; then
    printf 'Installation:\n> [macOs] YARN installing: %s\n' "$1"
    yarn global add "$1" --prefix /usr/local 
  fi
}