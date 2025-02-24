# Use the latest Alpine base
FROM alpine:3.18

# Install Chromium, Xvfb, a minimal window manager, novnc, websockify, and supervisor
RUN apk update && apk add --no-cache \
    chromium \
    xvfb \
    fluxbox \
    novnc \
    websockify \
    supervisor \
    bash \
    && rm -rf /var/cache/apk/*

# Set environment variables for the display and novnc port
ENV DISPLAY=:99
ENV NOVNC_PORT=6080

# Copy supervisor config and startup script (we will add these files next)
COPY supervisord.conf /etc/supervisord.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose the noVNC web port
EXPOSE 6080

# Start supervisor to launch all required services
CMD ["/start.sh"]
