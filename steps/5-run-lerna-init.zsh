#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# COLORS
source $SCRIPT_DIR/../gum-ui/colors.zsh

# Banner
gum style --border normal --margin "1" --padding "2 2" --border-foreground $WHITE "Install and initialize $(gum style --foreground $BLUE "Lerna")."

# Description
echo "Add $(gum style --foreground $BLUE "Lerna") dependancy at the project root and run $(gum style --foreground $BLUE "lerna init")"
echo

# Reload .zshrc to load correct Node version
echo
source ~/.zshrc
echo

# install lerna at workspace root so we can run it in npm scripts
if ! yarn add lerna -W; then
    echo
    echo "$(gum style --foreground $ORANGE "X ERROR!") There was a problem adding Lerna to the workspace root."
    echo
    exit 1
else
    echo
    echo "$(gum style --foreground $GREEN "✓ Success!") Lerna has been added to the workspace root."
    echo
fi

lerna init --packages="packages/*"

exit_code=$?

if [ $exit_code -ne 0 ]; then
    echo
    echo "$(gum style --foreground $ORANGE "X ERROR!") There was a problem initializing Lerna."
    echo
    exit 1
fi

# Commit changes
zsh $SCRIPT_DIR/git-commit.zsh "install and configure Lerna"
