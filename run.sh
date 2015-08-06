#!/bin/bash

INTIFACE=${INTIFACE:-docker0}
	
grep -e '^START_DAEMON=' /etc/default/minissdpd || \
  echo "START_DAEMON=1" >> /etc/default/minissdpd

grep -e "^MiniSSDPd_INTERFACE_ADDRESS=" /etc/default/minissdpd || \
  echo "MiniSSDPd_INTERFACE_ADDRESS=${INTIFACE}" >> /etc/default/minissdpd

sed -i -e "s/^MiniSSDPd_INTERFACE_ADDRESS=.*\$/MiniSSDPd_INTERFACE_ADDRESS=${INTIFACE}/" \
       -e "s/^START_DAEMON=.*\$/START_DAEMON=1/" \
       /etc/default/minissdpd

. /etc/default/minissdpd

# This is needed to keep running in the foreground in debug mode
exec /usr/sbin/minissdpd -i ${INTIFACE} -d
