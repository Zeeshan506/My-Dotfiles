#!/bin/bash
# Watch the waybar config directory for modifications
inotifywait -m -e modify ~/.config/waybar/ | while read -r directory events filename; do
  # If the saved file is config or style.css, trigger the reload
  if [ "$filename" = "config" ] || [ "$filename" = "style.css" ]; then
    killall -SIGUSR2 waybar
  fi
done
