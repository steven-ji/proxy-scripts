#!/bin/bash
ip=$1
port=$2
if [ -z $ip ]; then
  echo "Please set ip!"
  exit
fi
if [ -z $port ]; then
  echo "Please set port!"
  exit
fi
scp -P ${port} -C -p /root/.ssh/id_rsa root@${ip}:/root/.ssh/id_rsa
scp -P ${port} -C -p /root/.ssh/id_rsa root@${ip}:/root/.ssh/id_rsa.pub
cp /root/.ssh/known_hosts /tmp/known_hosts
sed -i "/${ip}/d" /tmp/known_hosts
scp -P ${port} -C -p /tmp/known_hosts root@${ip}:/root/.ssh/known_hosts
