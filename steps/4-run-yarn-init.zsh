#!/bin/zsh

script_dir=$(dirname "$0")

# Colors
source $script_dir/../gum-ui/colors.zsh

# Banner
gum style --border normal --margin "1" --padding "2 2" --border-foreground $WHITE "Initiate npm project using $(gum style --foreground $BLUE 'yarn')."

# Description
echo "Let's run $(gum style --foreground $BLUE "'yarn init'")."
echo

# Reload .zshrc to load correct Node version
echo
source ~/.zshrc
echo

# Initiate using yarn
if ! yarn init; then
    echo
    echo "$(gum style --foreground $RED "X ERROR!") It looks like there was a problem completing yarn init."
    echo
    exit 1
else
    echo
    echo "$(gum style --foreground $GREEN "✓ Success!") Your yarn project is initiated."
    echo
fi

# Commit changes
zsh $script_dir/../steps/git-commit.zsh "initiate npm with yarn."
