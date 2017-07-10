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
source $my_dir/nodeJsTools.sh
#####################################################################

if isMacOs ; then
    # https://please.hackmyresume.com/
    npmInstallGlobal 'hackmyresume'
    # https://github.com/fluentdesk/FluentCV
    npmInstallGlobal 'fluentcv'
    # https://www.npmjs.com/package/fluent-themes
    npmInstallGlobal 'fluent-themes'
    
    npmInstallGlobal 'resume-cli'
    npmInstallGlobal 'gulp-cli'
fi