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
# Mac Homebrew apps
if isMacOs ; then
  ########################## Dev tools
  # groovy
  brewInstall 'groovy'
  # node.js
  brewInstall 'node'
  # vert.x
  brewInstall 'vert.x'
  # phantomjs
  brewInstall 'phantomjs'

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
  # git large file storage
  brewInstall 'git-lfs'
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

  ########################## System tools
  # jEnv - Manage your Java environment http://www.jenv.be/
  brewInstall 'jenv'
  brewInstall 'gnuplot'
fi 