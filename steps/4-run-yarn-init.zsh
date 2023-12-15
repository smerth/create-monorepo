#!/bin/zsh

# TODO: all caps for variables
# TODO: chanage banner

script_dir=$(dirname "$0")

# Colors
source $script_dir/../gum-ui/colors.zsh

# Banner
gum style --border normal --margin "1" --padding "2 2" --border-foreground $white "Initiate npm project using $(gum style --foreground $blue 'yarn')."

# Description
echo "Let's run $(gum style --foreground $blue "'yarn init'")."
echo

# Reload .zshrc to load correct Node version
echo
source ~/.zshrc
echo

gum spin --title "Waiting for 'yarn init' on the repo..." -- yarn init -yp

# Report outcome
zsh $script_dir/../utility/outcome.zsh "$?" \
    "Unable to complete yarn init." \
    "Monorepo initiated using yarn."

# Commit changes
zsh $script_dir/../utility/git-commit.zsh \
    "initiate npm with yarn."
