# Use Alpine Linux as the base image
FROM alpine:latest

# Install dependencies
RUN apk add --no-cache midori xvfb x11vnc fluxbox

# Copy the start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose the VNC port
EXPOSE 5900

# Start the virtual browser and VNC server
CMD ["/start.sh"]
