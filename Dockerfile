FROM debian:bullseye-slim

# Install dependencies with Vulkan and EGL support
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    xvfb fluxbox chromium x11vnc websockify novnc \
    vulkan-utils mesa-vulkan-drivers \
    libgl1-mesa-dri libegl1-mesa && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure environment variables
ENV DISPLAY=:0
ENV VNC_PORT=5900
ENV NOVNC_PORT=6080
ENV LIBGL_ALWAYS_SOFTWARE=1
ENV EGL_PLATFORM=surfaceless

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE $NOVNC_PORT

CMD ["/start.sh"]
