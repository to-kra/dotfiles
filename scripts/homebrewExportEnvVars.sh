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
# Mac Homebrew : App HOME's
if isMacOs ; then
  # GRADLE_HOME
  brewExportHome 'gradle'
fi
# Mac Homebrew Cask: App HOME's
if isMacOs ; then
  # ANDROID_HOME
  brewCaskExportHome 'android-sdk' 'ANDROID_HOME'
  # ANDROID_NDK_HOME
  #brewCaskExportHome 'android-ndk' 'ANDROID_NDK_HOME'
fi