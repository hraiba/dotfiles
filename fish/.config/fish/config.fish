if status is-interactive
  # Commands to run in interactive sessions can go here
end
set -g fish_greeting ""
starship init fish | source
fzf --fish | source
set -x BAT_PAGER "less -R"

export BAT_THEME="gruvbox-dark"
export NIRI_SOCKET=$(ls /run/user/$(id -u)/niri*.sock | head -n1)
export PATH="$PATH:$HOME/.dotnet/tools"
export "DOTNET_ROOT=$HOME/.dotnet"
export "DOTNET_ROOT_X64=$HOME/.dotnet"
export PATH="$PATH:$DOTNET_ROOT"
export PATH="$PATH:$HOME/source/eww/target/release"

export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export PGHOST="/var/run/postgresql"
# export PAGER='nvim'
export MANPAGER='nvim +Man!'
export "QT_QPA_PLATFORM=wayland"

alias v=nvim
alias y=yazi
alias c=code
alias ls=lsd
# alias fx='docker run -d \
#   -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
#   -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY \
#   --device /dev/dri \
#   --shm-size=2g \
#   --cpus="1.0" \
#   --memory="2g" \
#   --memory-swap="2g" \
#   my-firefox'

alias fx='docker run \
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
  isolated-firefox'


# opencode
fish_add_path $HOME/.opencode/bin

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/mo/.lmstudio/bin
# End of LM Studio CLI section

