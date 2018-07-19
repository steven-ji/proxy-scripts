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
# create directory
ssh root@${ip} -p ${port} "mkdir -p {/opt/scripts,/opt/beats,/opt/app/proxy/agent/1.0.0/bin}"
# copy beat directory
scp -P ${port} -C -r /opt/beats root@${ip}:/opt/
# copy proxy.sh file
scp -P ${port} -C -p /opt/app/proxy/agent/1.0.0/bin/proxy.sh root@${ip}:/opt/app/proxy/agent/1.0.0/bin/proxy.sh
# copy scripts file
scp -P ${port} -C -r /opt/scripts root@${ip}:/opt

