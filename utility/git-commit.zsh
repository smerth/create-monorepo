#!/bin/zsh

script_dir=$(dirname "$0")

source $script_dir/../gum-ui/colors.zsh

MESSAGE=$1

# Banner
gum style --border normal --margin "1" --padding "2 2" --border-foreground $WHITE "$(gum style --foreground $BLUE 'Add'), $(gum style --foreground $BLUE 'Commit'), and $(gum style --foreground $BLUE 'Push'), changes to $(gum style --foreground $BLUE 'GitHub')."

# Description
echo "$(gum style --foreground $BLUE "Commit") with the message $(gum style --foreground $BLUE $MESSAGE)"
echo

# Commit changes
git add . && git commit -m $MESSAGE && git push

# Echo success message
echo
echo "$(gum style --foreground $GREEN "✓ Success!") Changes are committed and pushed."
echo
