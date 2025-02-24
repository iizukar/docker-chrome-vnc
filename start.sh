#!/bin/sh
# Remove any existing X server lock files
rm -f /tmp/.X1-lock

# Start Xvfb (virtual framebuffer) on display :1
Xvfb :1 -screen 0 1024x768x16 &
export DISPLAY=:1

# Start Fluxbox (lightweight window manager)
fluxbox &

# Start x11vnc (VNC server)
x11vnc -display :1 -forever -shared -nopw -rfbport 5900 &

# Start dbus (required for Falkon)
dbus-uuidgen > /var/lib/dbus/machine-id
dbus-daemon --system --fork

# Start Falkon (lightweight browser)
falkon
