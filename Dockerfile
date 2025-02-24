# Use Alpine Linux as the base image
FROM alpine:latest

# Install dependencies
RUN apk add --no-cache falkon xvfb x11vnc fluxbox dbus qt5-qtbase-x11 ttf-freefont

# Copy the start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose the VNC port
EXPOSE 5900

# Start the virtual browser and VNC server
CMD ["/start.sh"]
