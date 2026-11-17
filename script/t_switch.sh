#!/bin/sh
l=$(tmux list-windows -a -F '#{session_name}:#{window_index} #{window_name} #{?window_active,*}')
cur=$(tmux display -p '#{session_name}:#{window_index}')
n=$(printf '%s\n' "$l" | grep -n "^$cur " | head -1 | cut -d: -f1)

target=$(printf '%s\n' "$l" \
  | fzf --no-info --bind "load:pos(${n:-1})" \
  | cut -d' ' -f1)

[ -n "$target" ] && tmux switch-client -t "$target"
