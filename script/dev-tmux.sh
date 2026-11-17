#!/usr/bin/env bash
set -euo pipefail

# Use the caller's directory, even when this script lives elsewhere.
directory="$PWD"
window_name="$(basename "$directory")"
program=pi
program_args=()

usage() {
    cat <<'EOF'
Usage: dev-tmux.sh [LAUNCHER_OPTIONS] [--] [PROGRAM_ARGUMENTS...]

Open a program on the left, with Neovim and a shell below it on the right.
All panes start in the current directory.
Inside tmux, reuse the current window and run the program in the current pane.
Outside tmux, create and attach to a new session.

  --wname NAME         Window name (default: current directory name)
  --command PROGRAM    Program to launch (default: codex; executable name or path)
  -h, --help           Show this launcher help
  --                   Pass all remaining arguments to the program verbatim

Other arguments are passed to the program unchanged. Use -- before program
arguments that conflict with launcher options, including --help.

Examples:
  dev-tmux.sh -- --model o3 --add-dir ../shared
  dev-tmux.sh -- resume --last
  dev-tmux.sh --command claude -- --help
  dev-tmux.sh --wname review --command bash -- -l
EOF
}

while (( $# > 0 )); do
    case "$1" in
        --wname|--command)
            option="$1"
            shift
            if [[ $# -eq 0 || -z "$1" || "$1" == -* ]]; then
                printf '%s requires a value.\n' "$option" >&2
                exit 1
            fi
            if [[ "$option" == --wname ]]; then
                window_name="$1"
            else
                program="$1"
            fi
            shift
            ;;
        --)
            shift
            program_args+=("$@")
            break
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            program_args+=("$1")
            shift
            ;;
    esac
done

program_command=("$program")
if (( ${#program_args[@]} > 0 )); then
    program_command+=("${program_args[@]}")
fi

for command in tmux "$program" nvim; do
    if ! command -v "$command" >/dev/null 2>&1; then
        printf 'Required command not found: %s\n' "$command" >&2
        exit 1
    fi
done

if [[ -n "${TMUX:-}" ]]; then
    program_pane="${TMUX_PANE:-$(tmux display-message -p '#{pane_id}')}"
    window_id=$(tmux display-message -p -t "$program_pane" '#{window_id}')
    tmux rename-window -t "$window_id" "$window_name"
else
    program_pane=$(tmux new-session -d -P -F '#{pane_id}' \
        -n "$window_name" -c "$directory" "${program_command[@]}")
    window_id=$(tmux display-message -p -t "$program_pane" '#{window_id}')
fi

# Keep applications from changing the chosen window name.
tmux set-option -w -t "$window_id" automatic-rename off
tmux set-option -w -t "$window_id" allow-rename off
nvim_pane=$(tmux split-window -d -h -p 50 -P -F '#{pane_id}' \
    -t "$program_pane" -c "$directory" 'nvim')
# Leave a quarter of the right column for an interactive shell.
tmux split-window -d -v -p 25 -t "$nvim_pane" -c "$directory"

if [[ -n "${TMUX:-}" ]]; then
    exec "${program_command[@]}"
else
    session_id=$(tmux display-message -p -t "$window_id" '#{session_id}')
    exec tmux attach-session -t "$session_id"
fi
