#!/bin/bash

### variables & functions
# resolve currentDirectory even if symlink
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
workingDir="$( cd -P "$( dirname "$source" )" && pwd )"

### imports
source $workingDir/scripts/common.sh
source $workingDir/scripts/os.sh

### main

#####################################################################
# Mac : Homebrew
source $workingDir/scripts/homebrewInstall.sh

# link additional own homebrew functions
source $workingDir/scripts/homebrewTools.sh

# tapping brew repositories
#source $workingDir/scripts/homebrewTap.sh

# install brew formulas
source $workingDir/scripts/homebrewFormulas.sh

# install brew casks
source $workingDir/scripts/homebrewCask.sh

# install brew caskroom/versions
source $workingDir/scripts/homebrewCaskVersions.sh

# install npm apps
source $workingDir/scripts/npmInstall.sh

# install yarn apps
source $workingDir/scripts/yarnInstall.sh

#####################################################################
# Ubuntu : apt
source $workingDir/scripts/ubuntuAptInstall.sh

#####################################################################
# Git aware prompt
source $workingDir/scripts/gitAwarePromptInstall.sh

#####################################################################
# Java
source $workingDir/scripts/javaInstall.sh

#####################################################################
# Other development tools: node.js, ruby, sass, compass
source $workingDir/scripts/devToolsInstall.sh

#####################################################################
# Autocompletion: ibmcloud
source $workingDir/scripts/autocompletion.sh

#####################################################################
# Paths
source $workingDir/scripts/paths.sh

#####################################################################
# Alias definitions
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
else
  source $workingDir/.bash_aliases
fi

