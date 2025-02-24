FROM debian:bullseye-slim

# Install dependencies (keep existing packages)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    xvfb fluxbox chromium x11vnc websockify novnc \
    vulkan-tools mesa-vulkan-drivers \
    libgl1-mesa-dri libegl1-mesa libgl1-mesa-glx \
    dbus dbus-x11 libasound2 libdbus-1-3 \
    upower policykit-1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create fluxbox config directory first
RUN mkdir -p /root/.fluxbox

# Copy configuration files
COPY fluxbox-init /root/.fluxbox/init
COPY start.sh /start.sh

# Set permissions and environment
RUN chmod +x /start.sh && \
    chmod 644 /root/.fluxbox/init

ENV DISPLAY=:0
ENV VNC_PORT=5900
ENV NOVNC_PORT=6080
ENV LIBGL_ALWAYS_SOFTWARE=1

EXPOSE $NOVNC_PORT

CMD ["/start.sh"]
