#!/bin/bash

# Create necessary directories
mkdir -p /var/run/dbus /tmp/.X11-unix
chown -R messagebus:messagebus /var/run/dbus

# Start D-Bus system daemon
dbus-daemon --system --nofork &

# Start D-Bus session daemon and get address
export DBUS_SESSION_BUS_ADDRESS=$(dbus-daemon --config-file=/usr/share/dbus-1/session.conf --print-address --fork)

# Set X authority and display
export XAUTHORITY=/tmp/.Xauthority
touch $XAUTHORITY
xauth add $DISPLAY . $(mcookie)

# Start Xvfb with extended settings
Xvfb $DISPLAY -screen 0 1280x720x24 +extension GLX +render -nolisten tcp -ac +extension RANDR &

# Wait for Xvfb to initialize
sleep 2

# Start fluxbox window manager
fluxbox -display $DISPLAY -log /tmp/fluxbox.log &

# Configure Chromium with comprehensive flags
chromium --no-sandbox \
         --disable-gpu \
         --disable-software-rasterizer \
         --disable-dev-shm-usage \
         --use-gl=swiftshader \
         --ignore-gpu-blocklist \
         --start-maximized \
         --disable-cloud-management \
         --disable-component-update \
         --disable-background-networking \
         --disable-oom-kill-monitor \
         --no-zygote \
         --dbus-stub \
         --remote-debugging-port=9222 \
         about:blank &

# Start VNC server
x11vnc -display $DISPLAY -forever -noxdamage -passwd secret -rfbport $VNC_PORT -shared -bg -o /tmp/x11vnc.log

# Start noVNC websocket proxy
websockify -D --web=/usr/share/novnc $NOVNC_PORT localhost:$VNC_PORT

# Keep container alive
tail -f /dev/null
