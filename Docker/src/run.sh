#!/bin/bash

if [[ $# == 0 ]]; then
  echo ./run.sh run_4 - компиляция и запуск. dockle ошибки
  echo ./run.sh run_5 - компиляция и запуск. dockle пройден
  echo ./run.sh run_6 - запуск через прокси
  echo
  echo ./run.sh rm - удалить контейнер и образ
  echo ./run.sh open - открытие http:/localhost:80
  echo ./run.sh dockle_install - установка dockle. Нужен brsw
fi

if [[ $1 == run_4 ]]; then
  cd part_4
  docker build -t server .
  docker run -d -p 80:81 --name myserver server
fi

if [[ $1 == run_5 ]]; then
  # export DOCKER_CONTENT_TRUST=1 # не работает без авторизации docker hub
  docker build -t server .
  docker run -d -p 80:81 --name myserver server
fi

if [[ $1 == run_6 ]]; then
  docker-compose build
  docker-compose up
fi

if [[ $1 == dockle_install ]]; then
  # brsw
  brew install goodwithtech/r/dockle
fi

if [[ $1 == open ]]; then
  open http:/localhost:80/status
  open http:/localhost:80
fi

if [[ $1 == rm ]]; then
  docker stop myserver
  docker rm myserver
  docker rmi server
fi