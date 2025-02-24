#!/bin/bash

# Configure D-Bus directories
mkdir -p /var/run/dbus
chown messagebus:messagebus /var/run/dbus

# Start system bus
dbus-daemon --system --nofork &

# Start session bus
export DBUS_SESSION_BUS_ADDRESS=$(dbus-daemon --config-file=/usr/share/dbus-1/session.conf --print-address)

# Rest of your existing startup commands...
