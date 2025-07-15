FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:0 \
    SCREEN_GEOMETRY=1280x800x24

RUN apt-get update && apt-get install -y --no-install-recommends \
        fluxbox             \
        chromium            \
        xvfb x11vnc         \
        novnc websockify    \
        xterm               \
        eterm               \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5900 8000
ENTRYPOINT ["/entrypoint.sh"]
