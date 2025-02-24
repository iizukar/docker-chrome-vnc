FROM alpine:3.18

ENV PIP_ROOT_USER_ACTION=ignore

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

# Clone noVNC repository (shallow clone)
RUN git clone --depth=1 https://github.com/novnc/noVNC.git /usr/share/novnc

ENV DISPLAY=:99
ENV NOVNC_PORT=6080

COPY supervisord.conf /etc/supervisord.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080

CMD ["/start.sh"]
