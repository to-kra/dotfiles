#!/bin/bash
# brew additional functions
function brewContains () {
  if [[ $brewList == *"$1"* ]]; then
    #echo "Formula: $1 exists :-)"
    return 0;
  else
    #echo "Formula: $1 does not exist !!!"
    return 1;
  fi
}
function brewCaskContains () {
  if [[ $brewCaskList == *"$1"* ]]; then
    #echo "Cask: $1 exists..."
    return 0;
  else
    #echo "Cask: $1 does not exist !!!"
    return 1;
  fi
}
# function brewTapContains () {
#   if [[ $brewTapList == *"$1"* ]]; then
#     #echo "Tap: $1 exists..."
#     return 0;
#   else
#     #echo "Tap: $1 does not exist !!!"
#     return 1;
#   fi
# }
function brewInstall () {
  if ! brewContains "$1" ; then
    printf 'Installation:\n> [macOs] BREW installing: %s\n' "$1"
    brew install "$1"
  fi
}
function brewCaskInstall () {
  if ! brewCaskContains "$1" ; then
    printf 'Installation:\n> [macOs] BREW CASK installing: %s\n' "$1"
    brew cask install "$1"
  fi
}
# function brewTap () {
#   if ! brewTapContains "$1" ; then
#     printf 'Installation:\n> [macOs] BREW TAP adding repository: %s\n' "$1"
#     brew tap "$1"
#   fi
# }
function brewCaskVersionsInstall () {
  if ! brewCaskContains "$1" ; then
    printf 'Installation:\n> [macOs] BREW CASKroom/Versions installing: %s\n' "$1"
    brew install caskroom/versions/"$1"
  fi
}
