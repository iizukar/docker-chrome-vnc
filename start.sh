#!/bin/bash

# Start Xvfb in background
Xvfb :0 -screen 0 1280x720x16 &

# Start fluxbox window manager
fluxbox &

# Start chromium in fullscreen (headless mode)
chromium --no-sandbox --start-maximized --disable-gpu --remote-debugging-port=9222 &

# Start VNC server
x11vnc -display :0 -forever -noxdamage -passwd secret -rfbport $VNC_PORT &

# Start noVNC
websockify -D --web=/usr/share/novnc $NOVNC_PORT localhost:$VNC_PORT

# Keep container running
tail -f /dev/null
