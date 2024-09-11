#!/bin/bash

source config.cfg
source color.sh

fColor=$(Color $column1_background $column1_font_color)
sColor=$(Color $column2_background $column2_font_color)
resColor="\e[0m"

printf "${fColor}HOSTNAME${resColor} = ${sColor}$(hostname)${resColor}\n"
printf "${fColor}TIMEZONE${resColor} = ${sColor}$(cat /etc/timezone) UTC $(date | awk '{print $7}')${resColor}\n"
printf "${fColor}USER${resColor} = ${sColor}$USER${resColor}\n"
printf "${fColor}OS${resColor} = ${sColor}$(lsb_release -ds)${resColor}\n"
printf "${fColor}DATE${resColor} = ${sColor}$(date +"%d %b %Y %T")${resColor}\n"
printf "${fColor}UPTIME${resColor} = ${sColor}$(uptime -p)${resColor}\n"
printf "${fColor}UPTIME_SEC${resColor} = ${sColor}$(awk '{print int($1)}' /proc/uptime)${resColor}\n"

echo -e "${fColor}IP${resColor} = ${sColor}$(ifconfig | grep 'inet' | head -1 | awk '{print $2}')${resColor}"
echo -e "${fColor}MASK${resColor} = ${sColor}$(ifconfig | grep 'inet' | head -1 | awk '{print $4}')${resColor}"
echo -e "${fColor}GATEWAY${resColor} = ${sColor}$(route -n | awk '{if($1 == "0.0.0.0") {print $2}}')${resColor}"

echo -e "${fColor}RAM_TOTAL${resColor}= ${sColor}$(free -m | awk '/Mem/ {printf "%.3f GB", $2/1024.0}')${resColor}"
echo -e "${fColor}RAM_USED${resColor} = ${sColor}$(free -m | awk '/Mem/ {printf "%.3f GB", $3/1024.0}')${resColor}"
echo -e "${fColor}RAM_FREE${resColor} = ${sColor}$(free -m | awk '/Mem/ {printf "%.3f GB", $4/1024.0}')${resColor}"

echo -e "${fColor}SPACE_ROOT${resColor} = ${sColor}$(df -k / | awk '/\// {printf "%.2f MB", $2/1024.0}')${resColor}"
echo -e "${fColor}SPACE_ROOT_USED${resColor} = ${sColor}$(df -k / | awk '/\// {printf "%.2f MB", $3/1024.0}')${resColor}"
echo -e "${fColor}SPACE_ROOT_FREE${resColor} = ${sColor}$(df -k / | awk '/\// {printf "%.2f MB", $4/1024.0}')${resColor}"

echo ""
echo -e "${fColor}Column 1 background${resColor} = ${sColor}$(SetDefault $flagC1_back $column1_background) ($(ColorName $column1_background))${resColor}"
echo -e "${fColor}Column 1 font color${resColor} = ${sColor}$(SetDefault $flagC1_font $column1_font_color) ($(ColorName $column1_font_color))${resColor}"
echo -e "${fColor}Column 2 background${resColor} = ${sColor}$(SetDefault $flagC2_back $column2_background) ($(ColorName $column2_background))${resColor}"
echo -e "${fColor}Column 2 font color${resColor} = ${sColor}$(SetDefault $flagC2_font $column2_font_color) ($(ColorName $column2_font_color))${resColor}"
