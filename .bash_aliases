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
source $workingDir/scripts/os.sh

#####################################################################
# Aliases
if isMacOs ; then
  # gls is from GNU Core Utilities package
  # a (do not ignore entries starting with)
  # F (append indicator (one of */=>@|) to entries)
  # h (print human readable sizes)
  # --color (colorize the output)
  # --group-directories-first (group directories before files)
  alias ls='gls -Fh --color --group-directories-first'
  alias ll='gls -lFh --color --group-directories-first'
  alias la='gls -laFh --color --group-directories-first'
  alias eclipse_sudo='sudo /opt/kcdev/Eclipse.app/Contents/MacOS/eclipse &'
  alias eclipse='/opt/kcdev/Eclipse.app/Contents/MacOS/eclipse &'
  #open app from /Applications
  alias sublime='open -a "Sublime Text"'
  alias vscode='open -a "Visual Studio Code"'
  alias sourcetree='open -a "SourceTree"'
  alias edit='open -e'
fi
if isUbuntu ; then
  alias ls='ls -Fh --color --group-directories-first'
  alias ll='ls -lFh --color --group-directories-first'
  alias la='ls -laFh --color --group-directories-first'
fi

alias cd..='cd ..'
alias cs....='cd ../..'
alias cls='clear'
alias clr='clear'

# dev
alias gi='git'
alias gs='git status'
alias gc='git commit'
alias ga='git add'
alias docker_jenkins='docker run -p 8080:8080 -p 50000:50000 -v /Users/tokra/jenkins_home:/var/jenkins_home jenkins'
alias wgetkc='wget --user-agent="IBM_Knowledge_Center/1.8"'

# tools
alias cp_rsync='rsync -aP'
alias mv_rsync='rsync -aP --remove-source-files'

# personal
alias unraid='ssh root@tower'
