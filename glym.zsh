#!/bin/zsh

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

echo "$0: " $0
echo "scriptDir: " $scriptDir
echo "SCRIPT_DIR: " $SCRIPT_DIR
echo "pwd: " pwd
# Example of styled string
# echo "How do you want to $(gum style --foreground $PINK --bold "name") your project? (no spaces please)"

# TODO: Intro

# TODO: Requirements table with links

# Create a repository on GitHub
zsh $SCRIPT_DIR/monorepo-build-steps/create-gh-repository.zsh

echo "✓ Success! your repo has been cloned to this folder. When we're finished..."