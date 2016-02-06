#!/bin/bash
cd /opt/hybris && git log --decorate -1|grep -E -o 'tag: (.[^,]*)'| tr -d ":"|awk '{print "hybris_"$1 "=" $2}'
