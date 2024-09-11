#!/bin/bash

# Выводим информацию о системе
function monitoring {
  echo "HOSTNAME = $(hostname)"
  echo "TIMEZONE = $(cat /etc/timezone) UTC $(date | awk '{print $7}')"
  echo "USER = $USER"
  echo "OS = $(lsb_release -ds)"
  echo "DATE = $(date +"%d %b %Y %T")"
  echo "UPTIME = $(uptime -p)"
  echo "UPTIME_SEC = $(awk '{print int($1)}' /proc/uptime)"

  echo "IP = $(ifconfig | grep 'inet' | head -1 | awk '{print $2}')"
  echo "MASK = $(ifconfig | grep 'inet' | head -1 | awk '{print $4}')"
  echo "GATEWAY = $(route -n | awk '{if($1 == "0.0.0.0") {print $2}}')"

  echo "RAM_TOTAL= $(free -m | awk '/Mem/ {printf "%.3f GB", $2/1024.0}')"
  echo "RAM_USED = $(free -m | awk '/Mem/ {printf "%.3f GB", $3/1024.0}')"
  echo "RAM_FREE = $(free -m | awk '/Mem/ {printf "%.3f GB", $4/1024.0}')"

  echo "SPACE_ROOT = $(df -k / | awk '/\// {printf "%.2f MB", $2/1024.0}')"
  echo "SPACE_ROOT_USED = $(df -k / | awk '/\// {printf "%.2f MB", $3/1024.0}')"
  echo "SPACE_ROOT_FREE = $(df -k / | awk '/\// {printf "%.2f MB", $4/1024.0}')"
}
