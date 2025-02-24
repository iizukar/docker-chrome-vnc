FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    xvfb fluxbox chromium x11vnc websockify novnc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure NovNC
RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# Set display and VNC port
ENV DISPLAY=:0
ENV VNC_PORT=5900
ENV NOVNC_PORT=6080

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE $NOVNC_PORT

CMD ["/start.sh"]
