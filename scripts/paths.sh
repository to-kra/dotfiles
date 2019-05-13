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

source $workingDir/common.sh
source $workingDir/fileSystem.sh
MAIN_DIR=$(1dirUp $workingDir)
#-------------------------------------------------------------
# Exporting paths
#-------------------------------------------------------------
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# dotfiles
export PATH=$MAIN_DIR/scripts:$PATH
export PATH=$MAIN_DIR/bin:$PATH
export PATH=$MAIN_DIR/bin/work:$PATH

if isMacOs ; then
  # to avoid locale warning over ssh
  export LANG="en_US.UTF-8"
  export LC_ALL="en_US.UTF-8"
  
  export PATH=/Applications:$PATH
  
  # Apps homes generated by Brew/Cask
  source $workingDir/homebrewExportEnvVars.sh
  
  # MacPorts
  export PATH=/opt/local/bin:$PATH
  export PATH=/opt/local/sbin:$PATH
  
  #-------------------------------------------------------------
  # Work specific
  ## NPM
  export NPM=$(which npm)
  
  #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
  export SDKMAN_DIR="/Users/tokra/.sdkman"
  [[ -s "/Users/tokra/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/tokra/.sdkman/bin/sdkman-init.sh"
fi

# Android: Mac specific
  export ANDROID_HOME="/usr/local/share/android-sdk"
  #ANDROID_SDK_VERSION=`brew cask info android-sdk | grep android-sdk: | cut -d':' -f2 | xargs`
  #ANDROID_HOME="/usr/local/Cellar/android-sdk/$ANDROID_SDK_VERSION"
  #export ANDROID_HOME=$ANDROID_HOME
  if variableExists $ANDROID_HOME ; then
    launchctl setenv ANDROID_HOME $ANDROID_HOME
  fi

# Android: General
if variableExists $ANDROID_HOME ; then
  #export PATH=$ANDROID_HOME/build-tools/19.1.0:$PATH
  #export PATH=$ANDROID_HOME/platform-tools:$PATH
  export PATH=$ANDROID_HOME/tools:$PATH
  #export PATH=$ANDROID_HOME/build-tools/$(getAndroidBuildToolsVersion):$PATH
fi

# NodeJS
export PATH="/usr/local/opt/node@10/bin:$PATH"
