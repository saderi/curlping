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

  GREEN_COLOR="\033[$C;32m"
  RED_COLOR="\033[$C;31m"
  WHITE_COLOR="\033[$C;97m"
  BLUE_COLOR="\033[$C;34m"
  YELLOW_COLOR="\033[$C;33m"
  RESET_COLOR="\033[0m"

  RESPONSE=$(curl -s -o /dev/null -w "%{http_code} %{size_download} %{time_total}" $URL)
  HTTP_CODE=$(echo $RESPONSE | awk '{print $1}')
  SIZE=$(echo $RESPONSE | awk '{print $2}')
  TIME_TOTAL=$(echo $RESPONSE | awk '{print $3}')
  TIME=$(echo "($TIME_TOTAL * 1000)" | bc | xargs printf "%.2f")

  if [ "$HTTP_CODE" -eq 200 ]; then
    STATUS_COLOR=$GREEN_COLOR
    HTTP_CODE="200 OK"
  else
    STATUS_COLOR=$RED_COLOR
  fi

  printf "${WHITE_COLOR}connected to ${YELLOW_COLOR}%s ${WHITE_COLOR}(%d bytes), seq=${BLUE_COLOR}%-4d${WHITE_COLOR} time=${BLUE_COLOR}%-8s${WHITE_COLOR}ms ${STATUS_COLOR}%s${RESET_COLOR}\n" \
    "$URL" "$SIZE" "$SEQ" "$TIME" "$HTTP_CODE"
  
  SEQ=$((SEQ + 1))
  sleep 1s
done
