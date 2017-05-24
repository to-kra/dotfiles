#!/bin/bash

# resolve currentDirectory even if symlink
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
my_dir="$( cd -P "$( dirname "$source" )" && pwd )"

source $my_dir/homebrewTools.sh
source $my_dir/common.sh
source $my_dir/os.sh
source $my_dir/ubuntuAptTools.sh
#####################################################################
# Other development tools: node.js, ruby, sass, compass

# node.js, npm
if isMacOs ; then
  if notExistCommand 'node' ; then
    brewInstall 'node'
  fi
fi
if isUbuntu ; then
  if ! isPackageInstalled 'nodejs' ; then
    printf 'Installation:\n> APT installing nodejs (ubuntu)'
    sudo apt-get install -y nodejs
    sudo ln -s `which nodejs` /usr/bin/node
    sudo apt-get install -y build-essential
  fi
  if ! isPackageInstalled 'npm' ; then
    printf 'Installation:\n> APT installing npm (ubuntu)'
    sudo apt-get install -y npm
  fi
fi

# ruby : Ubuntu (MacOs should have it preinstalled)
if isUbuntu ; then
  if ! isPackageInstalled 'ruby' ; then
    printf 'Installation:\n> APT installing ruby (ubuntu)'
    sudo apt-get install -y ruby-full
  fi
fi

# gem install: sass
if notExistCommand 'sass' ; then
  printf 'Installation:\n> GEM installing sass'
  sudo gem install sass
fi

# gem install: compass
if notExistCommand 'compass' ; then
  printf 'Installation:\n> GEM installing compass'
  sudo gem install compass
fi

# export variables compass and npm for IDE's'
export COMPASS=`which compass`
export NPM=`which npm`
