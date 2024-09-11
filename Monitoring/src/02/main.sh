#!/bin/bash

. monitoring.sh
monitoring
read -p "Хотите сохранить эту информацию в файл? (Y/N) " choice
if [[ "$choice" == "Y" || "$choice" == "y" ]]; then
  filename="$(date +"%d_%m_%Y_%H_%M_%S").status"
  sudo sh -c "$(declare -f monitoring); monitoring > $filename"
  echo "Информация была успешно записана в файл $filename"
fi
