#!/bin/bash
# resolve currentDirectory even if symlink
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
my_dir="$( cd -P "$( dirname "$source" )" && pwd )"

source $my_dir/shellTools.sh
source $my_dir/macOsTools.sh
#####################################################################
# brew additional functions

function brewContains {
  FILTER_APP=`echo "$brewListVersions" | grep "$1" | cut -d" " -f1`
  #echo "Filtered from brew: $FILTER_APP"
  if [[ $FILTER_APP == *"$1"* ]]; then
    #echo "Formula: $1 exists :-)"
    return 0;
  else
    #echo "Formula: $1 does not exist !!!"
    return 1;
  fi
}

function brewCaskContains {
  FILTER_APP=`echo "$brewCaskListVersions" | grep "$1" | cut -d" " -f1`
  #echo "Filtered from cask: $FILTER_APP"
  if [[ $FILTER_APP == *"$1"* ]]; then
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

function brewInstall {
  if ! brewContains "$1" ; then
    printf 'Installation:\n> [macOs] BREW installing: %s\n' "$1"
    brew install "$1"
  fi
}

function brewInstallFromGit {
  DELIMITER=/
  BINARY=`splitLast $1 $DELIMITER`
  if ! brewContains "$BINARY" ; then
    printf 'Installation:\n> [macOs] BREW installing: %s\n' "$1"
    brew install "$1"
  fi
}

function brewCaskInstall {
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

function brewCaskVersionsInstall {
  if ! brewCaskContains "$1" ; then
    printf 'Installation:\n> [macOs] BREW CASKroom/Versions installing: %s\n' "$1"
    brew install caskroom/versions/"$1"
  fi
}

function brewGetPackageVersion {
  if ! stringIsEmpty "$1"; then
    PACKAGE="$1"
    VERSION=`echo "$brewListVersions" | grep $PACKAGE | rev | cut -d " " -f1 | rev | xargs`
    echo $VERSION
  fi
}

function brewCaskGetPackageVersion {
  if ! stringIsEmpty "$1"; then
    PACKAGE="$1"
    VERSION=`echo "$brewCaskListVersions" | grep $PACKAGE | rev | cut -d " " -f1 | rev | xargs`
    echo $VERSION
  fi
}

function brewExportHome {
  if ! stringIsEmpty "$1"; then
    if brewContains "$1" ; then
      VERSION=`brewGetPackageVersion "$1"`
      VAR_NAME=""
      if stringIsEmpty "$2"; then
        VAR_NAME="`stringToUpperCase $1`_HOME"
      else # if name passed to this function
        VAR_NAME="`stringToUpperCase $2`"
      fi
      VAR_VALUE="$BREW_HOME/$1/$VERSION"
      #echo "Declaring Brew App Home: name=${VAR_NAME}, value=${VAR_VALUE}"
      export ${VAR_NAME}=${VAR_VALUE}
      #printenv ${VAR_NAME}
    fi
  fi
}

function brewCaskExportHome {
  if ! stringIsEmpty "$1"; then
    if brewCaskContains "$1" ; then
      VERSION=`brewCaskGetPackageVersion "$1"`
      VAR_NAME=""
      if stringIsEmpty "$2"; then
        VAR_NAME="`stringToUpperCase $1`_HOME"
      else # if name passed to this function
        VAR_NAME="`stringToUpperCase $2`"
      fi
      VAR_VALUE="$CASK_HOME/$1/$VERSION"
      #echo "Declaring Cask App Home: name=${VAR_NAME}, value=${VAR_VALUE}"
      export ${VAR_NAME}=${VAR_VALUE}
      #printenv ${VAR_NAME}
    fi
  fi
}

function brewGetLatestPackageHomePath {
  LINK=`brew --prefix $1`
  # echo $LINK
  RESOLVED_LINK=`ls -l $LINK | sed "s,$(printf '\033')\\[[0-9;]*[a-zA-Z],,g"` #sed fix: removes color
  # echo "Resolved link: "$RESOLVED_LINK
  CELLAR_LINK=`echo $RESOLVED_LINK | rev | cut -d">" -f1 | rev | sed 's/\.\.//g' | xargs`
  # echo "Cellar link: $(tput sgr0)$CELLAR_LINK"
  FIXED_CELLAR=`stringRemovePrefix $CELLAR_LINK "/"`
  # echo "Fixed cellar: $FIXED_CELLAR"
  echo /usr/local/${FIXED_CELLAR}
}
