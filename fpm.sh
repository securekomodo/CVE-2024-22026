#!/bin/sh
fpm -s dir -t rpm -n ivanti-privesc -v 13.37 -a i386 --description "Ivanti POC" --maintainer "exploit-poc" --before-install preinstall.sh --after-install postinstall.sh -C .
