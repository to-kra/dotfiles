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
source $my_dir/yarnTools.sh
#####################################################################

if isMacOs ; then
    # react
    yarnGlobalAdd 'create-react-app'
    # react native
    yarnGlobalAdd 'create-react-native-app'
    # node fix
    yarnGlobalAdd 'node-gyp'
    # expo.io
    yarnGlobalAdd 'exp'
fi