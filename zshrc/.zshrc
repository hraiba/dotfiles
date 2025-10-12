eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export PGHOST="/var/run/postgresql"


export PATH=$PATH:/usr/local/go/bin

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000

setopt inc_append_history

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

plugins=( 
    # other plugins...
    zsh-autosuggestions
)

new_tmux () {
  session_dir=$(zoxide query --list | fzf)
  session_name=$(basename "$session_dir")

  if tmux has-session -t $session_name 2>/dev/null; then
    if [ -n "$TMUX" ]; then
      tmux switch-client -t "$session_name"
    else
      tmux attach -t "$session_name"
    fi
    notification="tmux attached to $session_name"
  else
    if [ -n "$TMUX" ]; then
      tmux new-session -d -c "$session_dir" -s "$session_name" && tmux switch-client -t "$session_name"
      notification="new tmux session INSIDE TMUX: $session_name"
    else
      tmux new-session -c "$session_dir" -s "$session_name"
      notification="new tmux session: $session_name"
    fi
  fi

  if [-s "$session_name" ]; then
    notify-send "$notification"
  fi
}

alias tm=new_tmux
source /home/mo/source/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export NIRI_SOCKET=$(ls /run/user/$(id -u)/niri*.sock | head -n1)
export PATH="$PATH:/usr/share/dotnet"
export PATH="$PATH:~/.dotnet/tools"
export "DOTNET_ROOT=/usr/share/dotnet"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
