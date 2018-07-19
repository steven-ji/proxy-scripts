#!/bin/bash
ip=$1
port=$2
hostname=$3
validTime=$4
if [ -z "$ip" ]; then
  echo "Please set ip!"
  exit 1
fi
if [ -z "$port" ]; then
  echo "Please set port!"
  exit 1
fi
if [ -z "$hostname" ]; then
  echo "Please set hostname!"
  exit 1
fi
if [ -z "$validTime" ]; then
  echo "Please set proxy valid time!"
  exit 1
fi
# start squid 
ssh root@${ip} -p ${port} "mkdir -p {/opt/scripts,/opt/beats,/opt/app/proxy/agent/1.0.0/bin}"
echo "###create directory :{/opt/scripts,/opt/app/proxy/agent/1.0.0/bin} success!###"
scp -P ${port} -p /opt/scripts/{agent_env.sh,beats_install.sh,beats_uninstall.sh,deploy_backup.sh,execute.sh,filebeat.service,filebeat.yml,jar_restart.sh,metricbeat.service,metricbeat.yml,squid_restart.sh} root@${ip}:/opt/scripts
scp -P ${port} /opt/app/proxy/agent/1.0.0/bin/proxy.sh root@${ip}:/opt/app/proxy/agent/1.0.0/bin/
echo "###upload scripts success!###"
#scp -P ${port} -r /opt/beats root@${ip}:/opt/
#ssh root@${ip} -p ${port} "sh /opt/scripts/beats_install.sh ${ip}:${port} ${hostname}"
#echo "###beats install success!###"
ssh root@${ip} -p ${port} "sh /opt/scripts/beats_uninstall.sh"
echo "###beats uninstall success!###"

ssh root@${ip} -p ${port} "sh /opt/scripts/squid_restart.sh"
echo "###squid restart success!###"

ssh root@${ip} -p ${port} "sh /opt/scripts/agent_env.sh ${ip}:${port} ${hostname}"
echo "###agent environment set success!###"
ssh root@${ip} -p ${port} "sh /opt/scripts/deploy_backup.sh bsd-proxy-agent-1.0.0.jar"
scp -P ${port} /root/.jenkins/workspace/bsd-proxy-agent/target/bsd-proxy-agent-1.0.0.jar root@${ip}:/opt/app/proxy/agent/1.0.0/
ssh root@${ip} -p ${port} "sh /opt/scripts/jar_restart.sh bsd-proxy-agent ${validTime}"
echo "###agent start success!###"

ssh root@${ip} -p ${port} "sh /opt/scripts/crontab.sh"
echo "###add crontab success!###"

echo "##########${ip}:${port} machine set success!#########"





