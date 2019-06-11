#!/bin/bash

### variables & functions
# resolve currentDirectory even if symlink
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
my_dir="$( cd -P "$( dirname "$source" )" && pwd )"

### imports
source $my_dir/common.sh
source $my_dir/os.sh
source $my_dir/ubuntuAptTools.sh
source $my_dir/ubuntuOsTools.sh

### main

# Java
if isMacOs ; then
    # ll Library/Java/JavaVirtualMachines/ -> will list all java dirs
    # then use: greadlink -f jdk1.8.0_112.jdk -> to get real paths
    # then add them into jenv: jenv add /System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home oracle64-1.6.0.39 added
    export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
fi
if isUbuntu ; then
    # aptAddRepo 'ppa:webupd8team/java'

    # Java 6
    # JAVA6="oracle-java6-installer"
    # if ! isPackageInstalled "$JAVA6" ; then 
    #     echo "$JAVA6 shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
    #     aptGetInstall "$JAVA6"
    # fi

    # Java 7
    JAVA7="oracle-java7-installer"
    #if ! isPackageInstalled "$JAVA7" ; then 
    #    echo "$JAVA7 shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
    #    aptGetInstall "$JAVA7"
    # fi

    # Java 8
    # JAVA8="oracle-java8-installer"
    # if ! isPackageInstalled "$JAVA8" ; then 
    #     echo "$JAVA8 shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
    #     aptGetInstall "$JAVA8"
    #     aptGetInstall 'oracle-java8-set-default'
    # fi
    
    # JAVA_HOME
    # if ! hasEnvJavaHome ; then
    #     printf "\nSetting JAVA_HOME\n"
    #     JAVA_HOME="`getJavaHome 'java-8-oracle'`"
    #     printf "JAVA_HOME=\"$JAVA_HOME\"\n" | sudo tee -a /etc/environment
    #     source /etc/environment
    #     printf "\nSetting JAVA_HOME... done\n"
    # fi
fi
