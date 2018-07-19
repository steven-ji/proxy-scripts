ip=$1
hostname=$2
if [ -z $ip ]; then
  echo "请设置主机ip!"
  exit 1
fi
if [ -z $hostname ]; then
  echo "请设置主机名"
  exit 2
fi
#if [ -f /opt/filebeat-6.2.4.rpm ]; then 
#  echo "filebeat已安装".
#else 
#  curl -L -o /opt/filebeat-6.2.4.rpm https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.4-x86_64.rpm
#  rpm -ivh /opt/filebeat-6.2.4.rpm
#fi
#if [ -f /opt/metricbeat-6.2.4.rpm ]; then
#  echo "metricbeat-6.2.6已安装"
#else 
#   curl -L -o /opt/metricbeat-6.2.4.rpm https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.2.4-x86_64.rpm
#   rpm -ivh /opt/metricbeat-6.2.4.rpm
#fi
rpm -ivh /opt/beats/filebeat-6.2.4.rpm
rpm -ivh /opt/beats/metricbeat-6.2.4.rpm
# 覆盖filebeat.yml、metricbeat.yml
yes | cp -f /opt/scripts/filebeat.yml /etc/filebeat/filebeat.yml
# 兼容原来的设置.覆盖.
yes | cp -f /opt/scripts/filebeat.service /usr/lib/systemd/system/filebeat.service 
yes | cp -f /opt/scripts/metricbeat.yml /etc/metricbeat/metricbeat.yml
# 修改filebeat.yml、metricbeat.yml,增加主机ip
echo "name: $ip" >> /etc/filebeat/filebeat.yml
echo "hostname: $hostname" >> /etc/filebeat/filebeat.yml
echo "name: $ip" >> /etc/metricbeat/metricbeat.yml
echo "hostname: $hostname" >> /etc/metricbeat/metricbeat.yml
# 启动
systemctl daemon-reload && systemctl enable filebeat metricbeat && systemctl start filebeat metricbeat
