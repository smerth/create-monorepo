#!/bin/zsh

echo "What's your first name?"
NAME=$(gum input --placeholder="Tell me your name, please...")
NAME="*$NAME*"

# The only time $NAME will equal ** is when there is no input!
if [ "$NAME" == "**" ]; then
    gum style --foreground "$FG" --border-foreground "$BFG" --border double --align center --width 64 --margin "1 2" --padding "2 4" "Oh well, see you later"
    exit 0
fi
