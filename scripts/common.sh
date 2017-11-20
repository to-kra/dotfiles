#!/bin/bash
function existCommand {
  type "$1" &> /dev/null ;
}

function notExistCommand {
  if existCommand "$1" ; then
    return 1
  fi
  return 0
}

function notExistDir {
  if [[ ! -d $1 ]] ; then
    return 0
  fi
  return 1
}

function gitClone {
  printf 'Git:\n> Cloning %s\n' "$1"
  git clone $1
}

function convertSubtitles {
  echo "> Start converting CP1250 to UTF-8 ..."
  inputEncoding="CP1250"
  outputEncoding="UTF-8"
  # check if output file exist, if yes, delete 1st
  if [ -f $2 ]; then
    rm -rf $2
  fi
  # convert
  iconv -f "${inputEncoding}" -t "${outputEncoding}" $1 > $2
  echo "> Convert CP1250 to UTF-8 on: $1 to: $2 ...done"
}

function getAndroidBuildToolsVersion {
  BUILD_TOOLS_VER=`ls $ANDROID_HOME/build-tools | sort | tail -1 | cut -d"/" -f1 | sed "s,$(printf '\033')\\[[0-9;]*[a-zA-Z],,g"`
  echo $BUILD_TOOLS_VER
}