if status is-interactive
  # Commands to run in interactive sessions can go here
end
set -g fish_greeting ""
starship init fish | source
fzf --fish | source

export BAT_THEME="gruvbox-dark"
export NIRI_SOCKET=$(ls /run/user/$(id -u)/niri*.sock | head -n1)
export PATH="$PATH:/usr/share/dotnet"
export PATH="$PATH:~/.dotnet/tools"
export "DOTNET_ROOT=/usr/share/dotnet"
export PATH="$PATH:~/source/eww/target/release"

export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export PGHOST="/var/run/postgresql"

