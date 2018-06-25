#!bin/bash
ip_address=$1
name=$2
if [ -z $name ]; then
  echo "Please set machine name!"
  exit 1
elif [ -z $ip_address ]; then
  echo "Please set ip address!"
  exit 1
else 
  echo '' > /etc/hostname
  echo $name > /etc/hostname
  sed -i '/COMPUTERNAME/d' /etc/profile
  sed -i '/IP_ADDRESS/d' /etc/profile
  echo export COMPUTERNAME=$name >> /etc/profile
  echo export IP_ADDRESS=$ip_address >> /etc/profile
  source /etc/profile
  echo export COMPUTERNAME=$name >> /root/.bashrc
  echo export IP_ADDRESS=$ip_address >> /root/.bashrc
  source /root/.bashrc
fi
echo "服务器主机名:$COMPUTERNAME,IP:$IP_ADDRESS 设置完成."
