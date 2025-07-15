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
        git                 \
    && rm -rf /var/lib/apt/lists/*


# ---------------------------------
# This is from docker documentation
# ---------------------------------
# Add Docker's official GPG key:
RUN apt-get update
RUN apt-get install ca-certificates curl
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
RUN echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update

RUN apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# ---------------------------------

RUN cd /home && git clone https://github.com/fbrunodr/Inception.git

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5900 8000
ENTRYPOINT ["/entrypoint.sh"]
