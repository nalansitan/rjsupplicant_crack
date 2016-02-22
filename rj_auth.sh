#!/bin/bash

cd /tmp
YOUR_USERNAME="something"
YOUR_PASSWORD="somethingelse"
sudo nohup /home/nalansitan/program/rjsupplicant_crack/rjsupplicant.sh -a 1 -d 1 -n eth0 -s default -u ${YOUR_USERNAME} -p "${YOUR_PASSWORD}" &
