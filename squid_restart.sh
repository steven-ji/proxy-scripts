sed -i '/acl basestore src*/d' /etc/squid/squid.conf

sed -i 'N;/acl SSL_ports port 443/i\acl basestore src "/etc/squid/ipwhite.list"' /etc/squid/squid.conf
sed -i 's/http_access allow all/http_access allow basestore/g' /etc/squid/squid.conf

sed -i '/workers*/d' /etc/squid/squid.conf
sed -i '/request_timeout*/d' /etc/squid/squid.conf
sed -i '/connect_timeout*/d' /etc/squid/squid.conf
sed -i '/read_timeout*/d' /etc/squid/squid.conf

echo workers 50 >> /etc/squid/squid.conf
echo request_timeout 20 second >> /etc/squid/squid.conf
echo connect_timeout 25 second >> /etc/squid/squid.conf
echo read_timeout 15 second >> /etc/squid/squid.conf


yum install -y wget
echo 'squid config modify success!'
wget http://cdn.xiaoxiangyoupin.com/prod/proxy/ipwhite.list?time=date '+%s'  -O /etc/squid/ipwhite.list
echo 'squid ip white download success!'

systemctl restart squid
echo 'squid restart success!'
