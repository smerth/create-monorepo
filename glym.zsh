#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# Example of styled string
# echo "How do you want to $(gum style --foreground $PINK --bold "name") your project? (no spaces please)"

# TODO: Intro

# TODO: Requirements table with links

# Create a repository on GitHub
zsh $SCRIPT_DIR/monorepo-build-steps/create-gh-repository.zsh

echo "✓ Success! your repo has been cloned to this folder. When we're finished..."