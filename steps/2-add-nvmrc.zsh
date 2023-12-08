#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# COLORS
source $SCRIPT_DIR/../gum-ui/colors.zsh

if [ $# -eq 0 ]; then
  echo "$(gum style --foreground $ORANGE "X ERROR!") Unable to read NODE_VERSION."
  exit 1
fi

NODE_VERSION=$1

# Banner
gum style --border normal --margin "1" --padding "2 2" --border-foreground $WHITE "Configure $(gum style --foreground $BLUE 'NVM')."

# Description
echo "Add an $(gum style --foreground $BLUE ".nvmrc") file with the $(gum style --foreground $BLUE "Node version") for this project."
echo

# Add file
if [ ! -f .npmrc ]; then
  touch .nvmrc
fi

# Add node version to file
if ! echo $NODE_VERSION >.nvmrc; then
  echo "$(gum style --foreground $ORANGE "X ERROR!") Unable to write NODE_VERSION to .nvmrc."
  exit 1
fi

# Reload .zshrc to load correct node version
echo
source ~/.zshrc
echo

# Success message
echo "$(gum style --foreground $GREEN "✓ Success!") .nvmrc has been added."

# Commit changes
zsh $SCRIPT_DIR/../steps/git-commit.zsh "add .nvmrc file with the project node version."
