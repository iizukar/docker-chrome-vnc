FROM debian:bullseye-slim

# Install dependencies with D-Bus and systemd support
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    xvfb fluxbox chromium x11vnc websockify novnc \
    vulkan-tools mesa-vulkan-drivers \
    libgl1-mesa-dri libegl1-mesa libgl1-mesa-glx \
    dbus dbus-x11 libasound2 libdbus-1-3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure environment
ENV DISPLAY=:0
ENV VNC_PORT=5900
ENV NOVNC_PORT=6080
ENV LIBGL_ALWAYS_SOFTWARE=1
ENV EGL_PLATFORM=surfaceless
ENV DBUS_SESSION_BUS_ADDRESS="unix:path=/tmp/dbus.sock"

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE $NOVNC_PORT

CMD ["/start.sh"]
