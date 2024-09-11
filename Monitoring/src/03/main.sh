#!/bin/bash

if [ $# -ne 4 ]; then
  echo "Ошибка: скрипт должен быть запущен с четырьмя параметрами"
  exit 1
fi

for arg in "$@"; do
  if ! [[ "$arg" =~ ^[1-6]$ ]]; then
    echo "Ошибка: параметры должны быть числовыми от 1 до 6"
    exit 1
  fi
done

if [[ $1 -eq $2 ]] || [[ $3 -eq $4 ]]; then
  echo "Ошибка: цвета текста и фона должны различаться"
  exit 1
fi

  . color.sh
  firstColor=$(Color $1 $2)
  secondColor=$(Color $3 $4)
  resetColor="\e[0m"

  printf "${firstColor}HOSTNAME${resetColor} = ${secondColor}$(hostname)${resetColor}\n"
  printf "${firstColor}TIMEZONE${resetColor} = ${secondColor}$(cat /etc/timezone) UTC $(date | awk '{print $7}')${resetColor}\n"
  printf "${firstColor}USER${resetColor} = ${secondColor}$USER${resetColor}\n"
  printf "${firstColor}OS${resetColor} = ${secondColor}$(lsb_release -ds)${resetColor}\n"
  printf "${firstColor}DATE${resetColor} = ${secondColor}$(date +"%d %b %Y %T")${resetColor}\n"
  printf "${firstColor}UPTIME${resetColor} = ${secondColor}$(uptime -p)${resetColor}\n"
  printf "${firstColor}UPTIME_SEC${resetColor} = ${secondColor}$(awk '{print int($1)}' /proc/uptime)${resetColor}\n"

  echo -e "${firstColor}IP${resetColor} = ${secondColor}$(ifconfig | grep 'inet' | head -1 | awk '{print $2}')${resetColor}"
  echo -e "${firstColor}MASK${resetColor} = ${secondColor}$(ifconfig | grep 'inet' | head -1 | awk '{print $4}')${resetColor}"
  echo -e "${firstColor}GATEWAY${resetColor} = ${secondColor}$(route -n | awk '{if($1 == "0.0.0.0") {print $2}}')${resetColor}"

  echo -e "${firstColor}RAM_TOTAL${resetColor}= ${secondColor}$(free -m | awk '/Mem/ {printf "%.3f GB", $2/1024.0}')${resetColor}"
  echo -e "${firstColor}RAM_USED${resetColor} = ${secondColor}$(free -m | awk '/Mem/ {printf "%.3f GB", $3/1024.0}')${resetColor}"
  echo -e "${firstColor}RAM_FREE${resetColor} = ${secondColor}$(free -m | awk '/Mem/ {printf "%.3f GB", $4/1024.0}')${resetColor}"

  echo -e "${firstColor}SPACE_ROOT${resetColor} = ${secondColor}$(df -k / | awk '/\// {printf "%.2f MB", $2/1024.0}')${resetColor}"
  echo -e "${firstColor}SPACE_ROOT_USED${resetColor} = ${secondColor}$(df -k / | awk '/\// {printf "%.2f MB", $3/1024.0}')${resetColor}"
  echo -e "${firstColor}SPACE_ROOT_FREE${resetColor} = ${secondColor}$(df -k / | awk '/\// {printf "%.2f MB", $4/1024.0}')${resetColor}"
