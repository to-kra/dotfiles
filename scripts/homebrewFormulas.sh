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
source $my_dir/brewtools.sh
#####################################################################
# Mac Homebrew apps
if isMacOs ; then
  ########################## SDK's'
  brewInstall 'groovy'

  ########################## Build tools
  # Ant
  brewInstall 'ant'
  # Gradle
  brewInstall 'gradle'
  # Maven
  brewInstall 'maven'

  ########################## Daily use cli tools
  # git
  brewInstall 'git'
  # Core utils: grealink etc.
  brewInstall 'coreutils'
  # Python
  brewInstall 'python'
  # Python3
  brewInstall 'python3'
  # Rsync
  brewInstall 'rsync'
  # Wget
  brewInstall 'wget'
fi 