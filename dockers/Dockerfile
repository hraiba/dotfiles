FROM fedora:latest

# Enable RPM Fusion for codecs Fedora can't ship by default (H.264, AAC, etc.)
RUN dnf install -y \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    && dnf clean all

RUN dnf install -y \
    firefox \
    mesa-libGL \
    mesa-libEGL \
    mesa-dri-drivers \
    libdrm \
    libgbm \
    pulseaudio-libs \
    fontconfig \
    dejavu-sans-fonts \
    dejavu-serif-fonts \
    liberation-fonts \
    google-noto-sans-fonts \
    google-noto-serif-fonts \
    google-noto-emoji-fonts \
    google-noto-cjk-fonts \
    gstreamer1-plugins-base \
    gstreamer1-plugins-good \
    gstreamer1-plugins-bad-free \
    gstreamer1-plugins-ugly-free \
    gstreamer1-plugin-openh264 \
    gstreamer1-libav \
    ffmpeg-libs \
    && dnf clean all

RUN mkdir -p /home/firefox \
    && chown -R 1000:1000 /home/firefox

ENV HOME=/home/firefox
ENV MOZ_ENABLE_WAYLAND=1

USER 1000:1000
WORKDIR /home/firefox

CMD ["firefox"]
