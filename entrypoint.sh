#!/usr/bin/env bash
set -e

# 1. Virtual X display
Xvfb "$DISPLAY" -screen 0 "$SCREEN_GEOMETRY" &
sleep 2            # give Xvfb a moment to come up

# 2. Window manager + browser
fluxbox   &> /tmp/fluxbox.log &

chromium --no-sandbox about:blank \
         &> /tmp/chromium.log &

# 3. VNC server and noVNC bridge (fixed ports)
x11vnc -display "$DISPLAY" -rfbport 5900 -nopw -shared -forever \
       &> /tmp/x11vnc.log &

websockify --web=/usr/share/novnc 8000 localhost:5900 \
           &> /tmp/websockify.log &

echo "----------------------------------------------------"
echo "Fluxbox desktop ready!"
echo " • In browser : http://localhost:8000"
echo " • Via VNC    : localhost:5900"
echo "----------------------------------------------------"

wait -n   # keep container alive while any child is running
