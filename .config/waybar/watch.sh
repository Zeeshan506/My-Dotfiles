#!/bin/bash
# Watch the waybar config directory for modifications (supporting atomic editor saves & symlinks)
CONFIG_DIR="$HOME/.config/waybar"
TARGET_DIR=$(readlink -f "$CONFIG_DIR" 2>/dev/null || echo "$CONFIG_DIR")

# Watch both the logical ~/.config/waybar directory and the real target directory
inotifywait -m -e modify,close_write,moved_to,create "$CONFIG_DIR" "$TARGET_DIR" 2>/dev/null | while read -r directory events filename; do
  case "$filename" in
    config*|style.css)
      killall -SIGUSR2 waybar 2>/dev/null
      ;;
  esac
done
