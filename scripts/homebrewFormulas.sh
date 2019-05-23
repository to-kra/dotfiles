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
  brewInstall 'node@10'
  # yarn
  brewInstall 'yarn'
  # bash debug
  brewInstall 'bashdb'
  # kafka
  brewInstall 'kafka'
  # scala
  brewInstall 'scala'
  # Apache OpenWhisk
  brewInstallFromGit 'ssx/wsk/wsk'
  # jq
  brewInstall 'jq'

  
  ########################## Test tools
  # A TAP-compliant test framework for Bash scripts https://github.com/sstephenson/bats
  brewInstall 'bats'
  
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
  #brewInstall 'python3'
  # Rsync
  brewInstall 'rsync'
  # Wget
  brewInstall 'wget'
  # sshpass
  #brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
  # Midnight Commander
  brewInstall 'midnight-commander'

  ########################## System tools
  # jEnv - Manage your Java environment http://www.jenv.be/
  brewInstall 'jenv'
  brewInstall 'gnuplot'
fi