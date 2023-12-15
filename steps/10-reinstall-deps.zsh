#!/bin/zsh

script_dir=$(dirname "$0")

# Colors
source $script_dir/../gum-ui/colors.zsh

# lerna clean removes all node_modules from packages (but does it remove from apps?)
lerna clean --yes

# Remove all node_module folders
find . \( -name "node_modules" \) -exec rm -rf -- {} +s

# Reinstall everything with yarn
yarn
