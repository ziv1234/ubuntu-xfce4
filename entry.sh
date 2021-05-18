#!/bin/bash

# XXX TBD - no need to do if it already exists?
mkdir -p /home/$V_USER/.vnc && x11vnc -storepasswd $VNC_PASSWORD /home/$V_USER/.vnc/passwd

nohup /usr/bin/Xvfb :99 -screen 0 $RESOLUTION -ac +extension GLX +render -noreset &
nohup startxfce4 &
nohup x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :99 -forever -bg -rfbauth /home/$V_USER/.vnc/passwd -users $V_USER -rfbport 5900 &

sleep infinity

