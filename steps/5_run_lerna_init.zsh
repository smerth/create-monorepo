#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# COLORS
source $SCRIPT_DIR/../utility/colors.zsh

# Intro
zsh $SCRIPT_DIR/../utility/banner.zsh \
    "Install and initialize $(gum style --foreground $BLUE "Lerna")."

# Reload .zshrc to load correct Node version
echo
source ~/.zshrc
echo

gum spin --title "Waiting for 'yarn add lerna -W' to add lerna to the monorepo root..." -- yarn add lerna -W

# Report outcome
zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
    "Unable to add lerna to the monorepo root." \
    "lerna added to the monorepo root."

gum spin --title "Waiting for 'lerna init' to run with the packages flag..." -- lerna init --packages="packages/*"

# Report outcome
zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
    "Unable to initiate lerna." \
    "lerna has been initiated with the packages flag."

# Commit changes
zsh $SCRIPT_DIR/../utility/git_commit.zsh \
    "install and configure Lerna"
