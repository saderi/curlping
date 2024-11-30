#!/bin/bash

URL=$1
SEQ=1
C=2

if [ -z "$URL" ]; then
  echo "Usage: $0 <url>"
  exit 1
fi


while true; do
  if [ $C -eq 2 ]; then
    C=0
  else
    C=2
  fi

  GREEN_COLOR="\e[$C;32m"
  RED_COLOR="\e[$C;31m"
  WHITE_COLOR="\e[$C;97m"
  BLUE_COLOR="\e[$C;34m"
  YELLOW_COLOR="\e[$C;33m"
  RESET_COLOR="\e[;0m"

  RESPONSE=$(curl -s -o /dev/null -w "%{http_code} %{size_download} %{time_total}" $URL)
  HTTP_CODE=$(echo $RESPONSE | awk '{print $1}')
  SIZE=$(echo $RESPONSE | awk '{print $2}')
  TIME_TOTAL=$(echo $RESPONSE | awk '{print $3}')
  TIME=$(echo "($TIME_TOTAL * 1000)" | bc | xargs printf "%.2f \n")
  
  if [ "$HTTP_CODE" -eq 200 ]; then
    STATUS_COLOR=$GREEN_COLOR # Green for 200 OK
    HTTP_CODE="200 OK"
  else
    STATUS_COLOR=$RED_COLOR # Red for other status codes
  fi
  
  echo -e "${WHITE_COLOR} connected to ${YELLOW_COLOR}$URL ${WHITE_COLOR}($SIZE bytes), ${WHITE_COLOR}seq=${BLUE_COLOR}$SEQ ${WHITE_COLOR}time=${BLUE_COLOR}${TIME}${WHITE_COLOR} ms ${STATUS_COLOR} $HTTP_CODE${RESET_COLOR}"
  
  SEQ=$((SEQ + 1))
  sleep 1s
done