#!/bin/sh
# Remove stale X11 lock files
rm -f /tmp/.X*lock

# Start Xvfb on display :0 (not :1)
Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset &
export DISPLAY=:0

# Generate X authority file
xauth generate :0 . trusted
xauth add "$DISPLAY" . $(mcookie)

# Start Fluxbox window manager
fluxbox &

# Start D-Bus system daemon
sudo mkdir -p /var/run/dbus
sudo dbus-daemon --system --fork

# Start x11vnc (no password, shared session)
x11vnc -display :0 -forever -shared -nopw -rfbport 5900 -auth /home/browseruser/.Xauthority &

# Start Falkon browser
falkon --no-sandbox &
# (Optional) For Chromium instead: 
# chromium-browser --no-sandbox --disable-gpu &

# Keep container running
tail -f /dev/null
