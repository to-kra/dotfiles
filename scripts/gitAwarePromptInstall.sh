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
#####################################################################
# Git + Git aware prompt
GITAWAREPROMPT=~/.bash/git-aware-prompt

# Check ~/.bash/ dir
if notExistDir ~/.bash/ ; then
  echo 'Installation of Git aware prompts:'
  mkdir ~/.bash
fi

# Check if 'git' command exist
if notExistCommand 'git' ; then
  if isMacOs ; then
    brewInstall 'git'
  elif isUbuntu ; then
    printf 'Installation:\n> APT installing of GIT (ubuntu)'
    sudo apt-get install git
  fi
fi

# Git clone if not exist
if notExistDir $GITAWAREPROMPT ; then
  cd ~/.bash
  gitClone 'git://github.com/jimeh/git-aware-prompt.git'
  cd $my_dir
fi

# Export CLI colors etc.
source "${GITAWAREPROMPT}/main.sh"
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ " 
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad