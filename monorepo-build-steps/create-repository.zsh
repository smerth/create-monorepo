#!/bin/sh

SCRIPT_DIR=$(dirname "$0")

PINK=#cf118b
GREEN=#27d128
WHITE=#ffffff
ORANGE=#FFA500

# DESCRIPTION
echo "- Run $(gum style --foreground $PINK --bold "'gh repo create'") Choose options to create a new repo on GitHub and then clone it to this directory."

# CREATE A REPOSITORY ON GITHUB
if ! gh repo create; then
    echo "$(gum style --foreground $ORANGE --bold "X ERROR!") It looks like there is a problem creating a repo on GitHub and then cloning it."
    exit 1
    else
    echo "$(gum style --foreground $GREEN --bold "✓ Success!") A new repository has been created on GitHub and cloned"
fi

