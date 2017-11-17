#!/usr/bin/env bash
# -*- tab-width: 2; encoding: utf-8 -*-

# test functions
# --------------------------------------------------------------#

function assertSuccess {
  if [ $1 -eq 0 ]; then
    return 0
  fi
  echo "> Assert expects exit(0) status, but status was: $1"
  return 1
}

function assertFailure {
  if [ $1 -eq 1 ]; then
    return 0
  fi
  echo "> Assert expects exit(1) status, but status was: $1"
  return 1
}

function assertEquals {
  if [ "$1" = "$2" ]; then
    return 0
  fi
  echo "> Expected: '$2'"
  echo "> Actual:   '$1'"
  return 1
}
