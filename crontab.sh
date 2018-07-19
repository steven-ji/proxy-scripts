#!/bin/bash
# add ppp check
if [ ! -f "/var/spool/cron/root" ]; then
  echo "/var/spool/cron/root not exist! create now!"
  touch /var/spool/cron/root
fi
sed -i '/ppp_check*/d' /var/spool/cron/root
echo "*/1 * * * * sh /opt/scripts/ppp_check.sh" >> /var/spool/cron/root

sed -i '/auto_tar_log*/d' /var/spool/cron/root
echo "0 3 * * *  sh /opt/scripts/auto_tar_log.sh" >> /var/spool/cron/root
