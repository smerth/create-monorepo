#!/bin/sh

SCRIPT_DIR=$(dirname "$0")

# COLORS
source $SCRIPT_DIR/../gum-ui/colors.zsh

# DESCRIPTION
echo "- Run $(gum style --foreground $PINK "'gh repo create'") Choose options to create a new repo on GitHub and then clone it to this directory."

# CREATE A REPOSITORY ON GITHUB
if ! gh repo create; then
    echo "$(gum style --foreground $ORANGE "X ERROR!") It looks like there is a problem creating a repo on GitHub and then cloning it."
    exit 1
else
    echo "$(gum style --foreground $GREEN "✓ Success!") A new repository has been created on GitHub and cloned"
fi
