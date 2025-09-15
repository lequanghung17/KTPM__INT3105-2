# syntax=docker/dockerfile:1.6
FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8 TZ=UTC



RUN apt-get update && apt-get install -y --no-install-recommends \
    lxde-core lxterminal \
    tigervnc-standalone-server \
    dbus-x11 x11-xserver-utils xauth sudo procps \
    x11vnc xvfb \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash docker && echo "docker:docker" | chpasswd && adduser docker sudo

USER docker
WORKDIR /home/docker
ENV HOME=/home/docker

# Script khởi động: tạo passwd nếu thiếu, dựng Xvfb (:99), chạy LXDE, rồi x11vnc
RUN mkdir -p $HOME/.vnc && \
    printf '%s\n' '#!/usr/bin/env bash' \
    'set -e' \
    ': "${VNC_PASSWORD:=docker}"' \
    ': "${VNC_GEOMETRY:=1280x800}"' \
    'mkdir -p "$HOME/.vnc"' \
    '# tạo mật khẩu cho x11vnc nếu chưa có' \
    'if [ ! -f "$HOME/.vnc/passwd" ]; then' \
    '  x11vnc -storepasswd "$VNC_PASSWORD" "$HOME/.vnc/passwd"' \
    'fi' \
    'export DISPLAY=:99' \
    '# start X virtual framebuffer' \
    'Xvfb :99 -screen 0 ${VNC_GEOMETRY}x24 -nolisten tcp &' \
    'sleep 1' \
    '# start desktop' \
    'dbus-launch --exit-with-session startlxde &' \
    '# start vnc server, lắng nghe port 5900' \
    'exec x11vnc -display :99 -rfbauth "$HOME/.vnc/passwd" -forever -shared -listen 0.0.0.0 -rfbport 5900 -xkb' \
    > /home/docker/start-vnc.sh && chmod +x /home/docker/start-vnc.sh

EXPOSE 5900
CMD ["/home/docker/start-vnc.sh"]
