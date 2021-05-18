#!/bin/bash

# XXX TBD - no need to do if it already exists?
mkdir -p /home/$V_USER/.vnc && x11vnc -storepasswd $VNC_PASSWORD /home/$V_USER/.vnc/passwd

nohup /usr/bin/Xvfb $DISPLAY -screen 0 $RESOLUTION -ac +extension GLX +render -noreset &
nohup startxfce4 &
nohup x11vnc -xkb -noxrecord -noxfixes -noxdamage -display $DISPLAY -forever -bg -rfbauth /home/$V_USER/.vnc/passwd -users $V_USER -rfbport $VNC_PORT &

sleep infinity

