FROM debian:stretch

# Install git, supervisor, VNC, & X11 packages
RUN set -ex; \
    apt-get update; \
    apt-get install -y \
      bash \
      sudo \
      lxde \
      chromium-browser \
      firefox \
      unzip \
      git \
      net-tools \
      novnc \
      socat \
      supervisor \
      x11vnc \
      xterm \
      xvfb

# Setup demo environment variables
ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1280 \
    DISPLAY_HEIGHT=720 \
    RUN_XTERM=no \
    RUN_LXDE=yes
COPY . /app
RUN chmod +x /app/conf.d/websockify.sh
RUN sudo add-apt-repository ppa:obsproject/obs-studio \
     && sudo apt-get update && sudo apt-get install -y obs-studio
CMD ["/app/entrypoint.sh"]
