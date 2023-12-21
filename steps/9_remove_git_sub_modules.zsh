#!/bin/zsh

# Remove git folders in gatby apps
# https://gist.github.com/facelordgists/80e868ff5e315878ecd6

find . \( -name ".git" \) -exec rm -rf -- {} +

# get back to monorepo root from apps directory
cd ../

# Commit changes
zsh $SCRIPT_DIR/../utility/git_commit.zsh \
    "add apps to the monorepo"
