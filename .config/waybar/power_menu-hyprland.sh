#!/bin/bash

# Define the monochrome icons and text
lock="  Lock"
suspend="⏾  Suspend"
logout="󰍃  Logout"
reboot="  Reboot"
shutdown="⏻  Shutdown"

# Format the options with newlines
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

# Pipe the options into rofi using the -dmenu flag
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power")

# Execute the corresponding command based on the selection
case $chosen in
"$lock")
  hyprlock
  ;;
"$suspend")
  systemctl suspend
  ;;
"$logout")
  hyprctl dispatch exit
  ;;
"$reboot")
  systemctl reboot
  ;;
"$shutdown")
  systemctl poweroff
  ;;
esac
