#!/bin/bash

# resolve currentDirectory even if symlink
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
my_dir="$( cd -P "$( dirname "$source" )" && pwd )"

source $my_dir/shellTools.sh
source $my_dir/os.sh
#-------------------------------------------------------------
if isMacOs ; then
    if ! commandExists 'ibmcloud' ; then
        # IBM Cloud CLI
        echo 'About to install IBM Cloud CLI...'
        curl -fsSL https://clis.ng.bluemix.net/install/osx | sh
    fi
fi