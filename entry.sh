#!/bin/bash

# XXX TBD - no need to do if it already exists?
mkdir -p /home/alpine/.vnc && x11vnc -storepasswd alpine /home/alpine/.vnc/passwd

nohup /usr/bin/Xvfb :99 -screen 0 $RESOLUTION -ac +extension GLX +render -noreset &
nohup startxfce4 &
nohup x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :99 -forever -bg -rfbauth /home/alpine/.vnc/passwd -users alpine -rfbport 5900 &

sleep infinity

