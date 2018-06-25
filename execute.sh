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
ssh root@${ip} -p ${port} "mkdir -p {/opt/scripts,/opt/beats,/opt/app/proxy/agent/1.0.0/bin}"
echo "###目录/opt/scripts,/opt/app/proxy/agent/1.0.0/bin创建完成!###"
scp -P ${port} -r /opt/scripts root@${ip}:/opt
scp -P ${port} /opt/app/proxy/agent/1.0.0/bin/proxy.sh root@${ip}:/opt/app/proxy/agent/1.0.0/bin/
echo "###脚本上传完成!###"
scp -P ${port} -r /opt/beats root@${ip}:/opt/
ssh root@${ip} -p ${port} "sh /opt/scripts/beats_install.sh ${ip}:${port} ${hostname}"
echo "###beats安装完成!###"
ssh root@${ip} -p ${port} "sh /opt/scripts/agent_env.sh ${ip}:${port} ${hostname}"
echo "###agent环境变量设置完成!###"
ssh root@${ip} -p ${port} "sh /opt/scripts/deploy_backup.sh bsd-proxy-agent-1.0.0.jar"
scp -P ${port} /root/.jenkins/workspace/bsd-proxy-agent/target/bsd-proxy-agent-1.0.0.jar root@${ip}:/opt/app/proxy/agent/1.0.0/
ssh root@${ip} -p ${port} "sh /opt/scripts/jar_restart.sh bsd-proxy-agent ${validTime}"
echo "###agent启动完成!###"
echo "##########${ip}:${port}机器设置完成!#########"




