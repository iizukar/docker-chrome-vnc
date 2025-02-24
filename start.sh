#!/bin/sh
# Start Xvfb (virtual framebuffer)
Xvfb :1 -screen 0 1024x768x16 &
export DISPLAY=:1

# Start Fluxbox (lightweight window manager)
fluxbox &

# Start x11vnc (VNC server)
x11vnc -display :1 -forever -shared -nopw -rfbport 5900 &

# Start Falkon (lightweight browser)
falkon
