#!/bin/sh
name=$1
now=`date +%Y%m%d%H%M%S`
if [ -n "$1" ]; then
  path=`find /opt/ -name $1`
  if [ -n "$path" ]; then
    echo "backup project :"$1
    find /opt/ -name $1 | xargs -i mv {} {}.bak.$now
  else
    echo $1" file is not exist"
  fi
else
  echo "project name is empty"
fi

find /opt/app/ -name "*.bak.201*" -mtime +10 | xargs rm -f
