#!/bin/bash
cd /opt/hybris && git log -1|grep -E -o 'commit (.[^ ]*)'  | awk '{ print "hybris_" $1 "=" $2}'
