#!/bin/bash

if [[ $# == 0 ]]; then
  echo
  echo "            для linux"
  echo
  echo ./run.sh install - установка необходимого
  echo ./run.sh run - компиляция и запуск
  echo ./run.sh open - открытие. curl
fi

if [[ $1 == install ]]; then
  sudo apt-get update
  sudo apt-get install -y gcc libfcgi-dev spawn-fcgi curl nginx
  sudo cp ../nginx/nginx.conf ~/../../etc/nginx/nginx.conf
  sudo systemctl restart nginx
fi

if [[ $1 == run ]]; then
  gcc -o myserver main.c -lfcgi
  spawn-fcgi -p 8080 -n myserver
fi

if [[ $1 == open ]]; then
  curl http:/localhost:81
fi