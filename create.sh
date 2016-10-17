#~/bin/sh
cd /tmp
wget -N http://www.shallalist.de/Downloads/shallalist.tar.gz
tar -zxf shallalist.tar.gz
cp -r /tmp/BL/* /dansguardian/blacklists/
