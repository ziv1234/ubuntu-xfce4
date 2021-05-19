#!/bin/bash
set -e
set -x

# remove existing locks
sudo rm -f /tmp/.X*lock

mkdir -p $V_USER_HOME/.vnc && x11vnc -storepasswd $VNC_PASSWORD $V_USER_HOME/.vnc/passwd

nohup /usr/bin/Xvfb $DISPLAY -screen 0 $RESOLUTION -ac +extension GLX +render -noreset &
sleep 1
nohup startxfce4 &
sleep 1
nohup x11vnc -xkb -noxrecord -noxfixes -noxdamage -display $DISPLAY -forever -bg -rfbauth $V_USER_HOME/.vnc/passwd -users $V_USER -rfbport $VNC_PORT &

# disable power management and screen saver
xset -dpms &
xset s noblank &
xset s off &

sleep infinity

