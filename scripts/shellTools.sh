#!/bin/bash
# -*- tab-width: 2; encoding: utf-8 -*-

function stringContains {
  local FULL_STRING=$1
  local STRING_TO_FIND=$2
  if [[ $FULL_STRING == *"$STRING_TO_FIND"* ]] ; then
    return 0
  fi
  return 1
}

function stringEquals {
  local str1=$1
  local str2=$2
  if [ "$str1" == "$str2" ]; then
    return 0
  fi
  return 1
}

function stringToUpperCase {
  echo "$1" | tr '[:lower:]' '[:upper:]'
}

function stringIsEmpty {
  if [[ -z "${1}" ]]; then
    return 0
  fi
  return 1
}

function stringIsBlank {
  if [[ -z "${1// }" ]]; then
    return 0
  fi
  return 1
}

function stringStartsWith {
  if ! stringIsEmpty "$2" && [[ "$1" == "$2"* ]]; then
    #echo "Starts"
    return 0
  fi
  #echo "Not starts"
  return 1
}

function stringEndsWith {
  if ! stringIsEmpty "$2" && [[ "$1" == *"$2" ]]; then
    #echo "Ends with"
    return 0
  fi
  #echo "Not ends with"
  return 1
}

function stringRemoveLeading {
  echo ${1:1:${#1}}
}

function stringRemoveTrailing {
  if ! stringIsEmpty; then
    FINAL_LEN=${#1}-1
    echo ${1:0:$FINAL_LEN}
  fi
}

function stringRemoveNCharsFromStart {
  echo ${1:$2:${#1}}
}

function stringRemoveNCharsFromEnd {
  FINAL_LEN=${#1}-$2
  echo ${1:0:$FINAL_LEN}
}

function stringRemovePrefix {
  if stringStartsWith "$1" "$2" ; then
    LEN_1=${#1}
    LEN_2=${#2}
    echo ${1:$LEN_2:$LEN_1}
  fi
}

## @fn stringRemoveSuffix()
## @brief Removes suffix from the end of string, if string ends with suffix
## @param string Original string.
## @param suffix Suffix to be removed from original string.
## @retval string The new string without suffix, if original string ended with suffix.
## @retval string Original string if condition was not met.
function stringRemoveSuffix {
  if stringEndsWith "$1" "$2"; then
    ORIG="$1"
    SUFFIX="$2"
    LEN_DIFF=${#ORIG}-${#SUFFIX}
    echo ${ORIG:0:$LEN_DIFF}
  fi
  echo $1
}

function stringToLowerCase {
  echo "$1" | tr '[:upper:]' '[:lower:]'
}

function arrayJoinBy {
  local separator=$1
  local array=("${!2}")
  IFS=$separator
  echo "${array[*]// /|}"
  IFS=$' \t\n'
}

function arrayLength {
  local array=("${!1}")
  echo ${#array[*]}
}