# Use the latest Alpine base
FROM alpine:3.18

# Install essential packages including chromium, xvfb, fluxbox, supervisor, bash,
# plus git, python3, and pip (to install websockify)
RUN apk update && apk add --no-cache \
    chromium \
    xvfb \
    fluxbox \
    supervisor \
    bash \
    git \
    python3 \
    py3-pip \
    && rm -rf /var/cache/apk/*

# Install websockify via pip
RUN pip3 install websockify

# Clone the noVNC repository into /usr/share/novnc (only the latest commit for a smaller size)
RUN git clone --depth=1 https://github.com/novnc/noVNC.git /usr/share/novnc

# Set environment variables for the display and noVNC port
ENV DISPLAY=:99
ENV NOVNC_PORT=6080

# Copy supervisor config and startup script (we’ll add these files next)
COPY supervisord.conf /etc/supervisord.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose the noVNC web port
EXPOSE 6080

# Start our supervisor process (which will launch all needed services)
CMD ["/start.sh"]
