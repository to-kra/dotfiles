#!/bin/bash

function removeColorsFromCliString {
  REMOVED=`echo $1 | sed "s,$(printf '\033')\\[[0-9;]*[a-zA-Z],,g"`
  echo $REMOVED
}