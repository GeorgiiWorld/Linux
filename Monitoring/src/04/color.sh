#!/bin/bash

default_col1_background=5
default_col1_font_color=3
default_col2_background=1
default_col2_font_color=6

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

function ColorName () {
  local color=$1

  # Обозначения цветов
  case "$color" in
    "1" )   cString="white";;
    "2" )   cString="red";;
    "3" )   cString="green";;
    "4" )   cString="blue";;
    "5" )   cString="purple";;
    "6" )   cString="black";;
  esac

  echo "$cString"
}

function SetDefault () {
  local flag_default=$1
  if [[ $flag_default -eq 1 ]]; then
    echo "default";
  else
    echo "$2"
  fi
}

flagC1_back=0; flagC1_font=0; flagC2_back=0; flagC2_font=0;
if [[ $column1_background -eq "" ]]; then
  column1_background=$default_col1_background
  flagC1_back=1
fi
if [[ $column1_font_color -eq "" ]]; then
  column1_font_color=$default_col1_font_color
  flagC1_font=1
fi
if [[ $column2_background -eq "" ]]; then
  column2_background=$default_col2_background
  flagC2_back=1
fi
if [[ $column2_font_color -eq "" ]]; then
  column2_font_color=$default_col2_font_color
  flagC2_font=1
fi

if [[ $column1_background -eq $column1_font_color ]] || [[ $column2_background -eq $column2_font_color ]]; then
  echo "Ошибка: цвета текста и фона должны различаться"
  exit 1
fi
