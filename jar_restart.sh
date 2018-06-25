#!/bin/bash
dir='/opt/app/'

name=$1
if [ -z "$1" ]; then
  echo " name can't be empty!"
  exit
fi
pid=`ps -ef | grep $name | grep 'java -jar' | awk '{print $2}'`

if [ -n "$pid" ]; then
  echo 'program pid exist : '$pid
  echo 'program proxy :'$name
  kill -9 $pid
fi

export BASH_ENV=/etc/profile

if [ "$1"x == "bsd-proxy-agent"x ] ; then
  if [ -z "$2" ]; then
    echo "jar_restart -> please set proxy valid time(Min)!"
    exit 1
  fi
  echo 'restart ... '$1
  cd /opt/app/proxy/agent/1.0.0/bin/
  bash proxy.sh $2 &
elif [ "$1"x == "bsd-proxy-centre"x ] ; then
  echo 'restart ... '$1
  cd /opt/app/proxy/centre/1.0.0/bin/
  bash proxy.sh &

else
  echo '不支持的项目'
fi


