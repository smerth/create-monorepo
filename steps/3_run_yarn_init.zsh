#!/bin/zsh

# TODO: all caps for variables
# TODO: chanage banner

SCRIPT_DIR=$(dirname "$0")

# Colors
source $SCRIPT_DIR/../utility/colors.zsh

# Intro
zsh $SCRIPT_DIR/../utility/banner.zsh \
    "Initiate npm project using $(gum style --foreground $BLUE 'yarn')."

# Reload .zshrc to load correct Node version
echo
source ~/.zshrc
echo

gum spin --title "Waiting for 'yarn init' to complete." -- yarn init -yp

# Report outcome
zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
    "Unable to complete yarn init." \
    "Project initiated using yarn."

touch tmp-package.json

# Add description property to packages.json
cat package.json | jq --arg desc "$REPO_DESCRIPTION" '. .description=$desc' >tmp-package.json && mv tmp-package.json package.json

# Report outcome
zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
    "Unable to add description to package.json." \
    "Description added to package.json."

# Commit changes
zsh $SCRIPT_DIR/../utility/git_commit.zsh \
    "initiate npm with yarn."
