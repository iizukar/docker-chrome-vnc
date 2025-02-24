# Use Alpine Linux as the base image
FROM alpine:latest

# Install all dependencies
RUN apk add --no-cache \
    xvfb \
    x11vnc \
    fluxbox \
    falkon \
    dbus \
    ttf-freefont \
    qt5-qtbase-x11 \
    vulkan-tools \
    mesa-dri-gallium \
    && mkdir -p /var/run/dbus

# Create a non-root user
RUN adduser -D -u 1000 browseruser

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose VNC port
EXPOSE 5900

# Run as non-root user
USER browseruser

# Start the services
CMD ["/start.sh"]
