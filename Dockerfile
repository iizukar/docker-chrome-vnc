FROM alpine:3.18

# Suppress pip warnings when running as root
ENV PIP_ROOT_USER_ACTION=ignore

# Install necessary packages: chromium, xvfb, fluxbox, x11vnc (for VNC), supervisor, bash, git, python3, and pip
RUN apk update && apk add --no-cache \
    chromium \
    xvfb \
    fluxbox \
    x11vnc \
    supervisor \
    bash \
    git \
    python3 \
    py3-pip \
    && rm -rf /var/cache/apk/*

# Install websockify via pip
RUN pip3 install websockify

# Clone the noVNC repository (shallow clone to save space)
RUN git clone --depth=1 https://github.com/novnc/noVNC.git /usr/share/novnc

# Set environment variables for display and the noVNC port
ENV DISPLAY=:99
ENV NOVNC_PORT=6080

# Copy Supervisor configuration and startup script
COPY supervisord.conf /etc/supervisord.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose the noVNC web port
EXPOSE 6080

# Start Supervisor (which launches all services)
CMD ["/start.sh"]
