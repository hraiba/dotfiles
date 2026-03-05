if status is-interactive
  # Commands to run in interactive sessions can go here
end
set -g fish_greeting ""
starship init fish | source
fzf --fish | source
set -x BAT_PAGER "less -R"

export BAT_THEME="gruvbox-dark"
export NIRI_SOCKET=$(ls /run/user/$(id -u)/niri*.sock | head -n1)
export PATH="$PATH:~/.dotnet/tools"
export "DOTNET_ROOT=~/.dotnet"
export "DOTNET_ROOT_X64=~/.dotnet"
export PATH="$PATH:$DOTNET_ROOT"
export PATH="$PATH:~/source/eww/target/release"

export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export PGHOST="/var/run/postgresql"
# export PAGER='nvim'
export MANPAGER='nvim +Man!'

alias v=nvim
alias y=yazi
alias c=code
alias ls=lsd
