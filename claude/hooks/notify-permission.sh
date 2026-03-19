#!/bin/bash
# send a notification when claude needs permission

input=$(cat)
tool_name=$(echo "$input" | jq -r '.tool_name')

if [ "$tool_name" = "Bash" ]; then
  cmd=$(echo "$input" | jq -r '.tool_input.command // "unknown"')
  message="Claude wants to run: $cmd"
elif [ "$tool_name" = "Write" ] || [ "$tool_name" = "Edit" ]; then
  file=$(echo "$input" | jq -r '.tool_input.file_path // "unknown"')
  message="Claude wants to edit: $file"
else
  message="Claude wants to use: $tool_name"
fi

notify-send -a "Claude Code" -i ~/dotfiles/claude/claude-code-icon.png --hint=string:sound-name:bell "Permission Request" "$message"
