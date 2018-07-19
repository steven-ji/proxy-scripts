#!/bin/bash
ppp=`ifconfig | grep ppp | wc -l`
echo "ppp $ppp"
if [ $ppp -gt 2 ]; then
  echo "ppp count $ppp"
  ps -ef | grep pppoe-adsl | awk '{print $2}' | xargs  kill -9
  echo "kill all pppoe success!"
  sleep 1
  current=`ifconfig | grep ppp | wc -l`
  echo "current ppp count $current"
fi
