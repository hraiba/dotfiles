
docker run \
  --rm \
  --name isolated-firefox \
  --network host \
  -e WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
  -e XDG_RUNTIME_DIR=/tmp \
  -e PULSE_SERVER=unix:/tmp/pulse/native \
  -e MOZ_ENABLE_WAYLAND=1 \
  -v "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY" \
  -v "$XDG_RUNTIME_DIR/pulse/native:/tmp/pulse/native" \
  --device /dev/dri \
  --security-opt seccomp=unconfined \
  --shm-size=2g \
  --cpus=1 \
  --memory=2g \
  --memory-swap=2g \
  isolated-firefox 2> /dev/null & 
