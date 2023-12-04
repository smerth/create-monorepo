#!/bin/zsh

TEXT=$1

if [ -n "$2" ]; then
  if [ "$2" = "banner" ]; then
    gum style --align=left --width=50 --margin="1 2" --padding="2 4" "$TEXT"
  fi
else
  gum style --foreground=#c462fc "$TEXT"
fi
