#!/bin/bash
#
# autoname          Set your hostname in amazon
#
# chkconfig: 2345 90 60
# description: little script that will setup instance hostnema during bootup

### BEGIN INIT INFO
# Provides: autoname
# Required-Start: $local_fs $syslog
# Required-Stop: $local_fs $syslog
# Default-Start:  2345
# Default-Stop: 90
# Short-Description: run cron daemon
# Description: little script that will setup instance hostnema during bootup
### END INIT INFO
#######################################################
#
# chkconfig: - 60 60
# description: sethostname and add to route53
# 
### BEGIN INIT INFO
# Provides: autoname 
# Required-Start: $network $local_fs
# Required-Stop: $network $local_fs
# Should-Start: $syslog 
# Should-Stop: $syslog 
# Short-Description: run autoname at startup 
# Description: hostname set in instance user-data (HOSTNAME=name)
#              instance IAM role set to addRoute53Record
#
# author: info@daveops.co.uk

### END INIT INFO

HOSTNAME=$(curl -s http://169.254.169.254/latest/user-data|grep HOSTNAME|cut -d = -f 2)
DOMAIN=$(curl -s http://169.254.169.254/latest/user-data|grep DOMAIN|cut -d = -f 2)
AWSPUBNAME=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)
AWSINTIP=$(curl -s  http://169.254.169.254/latest/meta-data/local-ipv4)
TTL=300
OS=$(facter operatingsystem)

###########################
# cli53 executable
if [ $OS == "Amazon" ]; then
  COMMAND='/usr/bin/cli53'
else
  COMMAND='/usr/local/bin/cli53'
fi

# default hostname
if [ -z $HOSTNAME ]; then
        HOSTNAME="changeme"
fi

# default domain
if [ -z $DOMAIN ]; then
        DOMAIN=$(facter domain)
fi

# set hostname
if [ $OS == "Debian" ]; then
  echo "${HOSTNAME}" > /etc/hostname
  hostname $(cat /etc/hostname)
else
  sed -i -e "s/^HOSTNAME.*/HOSTNAME=${HOSTNAME}/g" /etc/sysconfig/network
fi

# set /etc/hosts
if [ $(grep $HOSTNAME /etc/hosts|wc -l) = "0" ]; then
        echo -e "$(facter ipaddress)\t${HOSTNAME} ${HOSTNAME}.${DOMAIN}" >> /etc/hosts
fi

# Add public IP as CNAME record, if exists
if [ $(curl -s http://169.254.169.254/latest/meta-data/ | grep public-hostname) ]; then
  $COMMAND rrcreate -x $TTL -r example.net $HOSTNAME CNAME $AWSPUBNAME
fi
# Add internal IP as A record with -int suffix
  $COMMAND rrcreate -x $TTL -r example.net ${HOSTNAME}-int A $AWSINTIP
