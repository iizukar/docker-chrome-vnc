#!/bin/bash

# Start D-Bus system daemon
mkdir -p /var/run/dbus
dbus-daemon --system --nofork &

# Start Xvfb with extended permissions
Xvfb :0 -screen 0 1280x720x24 +extension GLX +render -nolisten tcp -ac &

# Start fluxbox
fluxbox -display :0 &

# Configure Chromium with additional flags
chromium --no-sandbox \
         --disable-gpu \
         --disable-software-rasterizer \
         --disable-dev-shm-usage \
         --use-gl=swiftshader \
         --ignore-gpu-blocklist \
         --start-maximized \
         --disable-cloud-management \
         --disable-oom-kill-monitor \
         --dbus-stub \
         --remote-debugging-port=9222 &

# Start VNC server
x11vnc -display :0 -forever -noxdamage -passwd secret -rfbport $VNC_PORT &

# Start noVNC
websockify -D --web=/usr/share/novnc $NOVNC_PORT localhost:$VNC_PORT

tail -f /dev/null
