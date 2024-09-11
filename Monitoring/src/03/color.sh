#!/bin/bash

# 1 - white, 2 - red, 3 - green, 4 - blue, 5 – purple, 6 - black
function Color () {
local foreground=$2
local background=$1

local colorString='\e['
# Цвета текста
case "$foreground" in
  "1" )   colorString='\033[37m';;
  "2" )   colorString='\033[31m';;
  "3" )   colorString='\033[32m';;
  "4" )   colorString='\033[36m';;
  "5" )   colorString='\033[35m';;
  "6" )   colorString='\033[30m';;
  *)      colorString='\033[39m';;
esac

# Цвета фона
case "$background" in
  "1" )   colorString="${colorString}\033[47m";;
  "2" )   colorString="${colorString}\033[41m";;
  "3" )   colorString="${colorString}\033[42m";;
  "4" )   colorString="${colorString}\033[46m";;
  "5" )   colorString="${colorString}\033[45m";;
  "6" )   colorString="${colorString}\033[40m";;
  *)      colorString="${colorString}\033[49m";;
esac

  echo "${colorString}"
}
