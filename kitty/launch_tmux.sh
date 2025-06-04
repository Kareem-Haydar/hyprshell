sessions=$(tmux list-sessions -F '#S' 2>/dev/null)
if [ -z "$sessions" ]; then
  tmux
else
  count=$(echo "$sessions" | wc -l)
  if [ "$count" -eq 1 ]; then
    tmux attach-session -t "$sessions"
  fi

  selecter=$(echo "$sessions" | fzf --prompt="Select tmux session: ")
  if [ -n "$selecter" ]; then
    tmux attach-session -t "$selecter"
  fi
fi
