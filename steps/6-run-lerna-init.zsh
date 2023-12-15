#!/bin/zsh

script_dir=$(dirname "$0")

# COLORS
source $script_dir/../gum-ui/colors.zsh

# Banner
gum style --border normal --margin "1" --padding "2 2" --border-foreground $white "Install and initialize $(gum style --foreground $blue "Lerna")."

# Description
echo "Add $(gum style --foreground $blue "Lerna") dependancy at the project root and run $(gum style --foreground $blue "lerna init")"
echo

# Reload .zshrc to load correct Node version
echo
source ~/.zshrc
echo

gum spin --title "Waiting for 'yarn add lerna -W' to add lerna to the monorepo root..." -- yarn add lerna -W

# Report outcome
zsh $script_dir/../utility/outcome.zsh "$?" \
    "Unable to add lerna to the monorepo root." \
    "lerna added to the monorepo root."

gum spin --title "Waiting for 'lerna init' to run with the packages flag..." -- lerna init --packages="packages/*"

# Report outcome
zsh $script_dir/../utility/outcome.zsh "$?" \
    "Unable to initiate lerna." \
    "lerna has been initaited with the pakages flag."

# install lerna at workspace root so we can run it in npm scripts
# if ! yarn add lerna -W; then
#     echo
#     echo "$(gum style --foreground $orange "X ERROR!") There was a problem adding Lerna to the workspace root."
#     echo
#     exit 1
# else
#     echo
#     echo "$(gum style --foreground $green "✓ Success!") Lerna has been added to the workspace root."
#     echo
# fi

# lerna init --packages="packages/*"

# exit_code=$?

# if [ $exit_code -ne 0 ]; then
#     echo
#     echo "$(gum style --foreground $orange "X ERROR!") There was a problem initializing Lerna."
#     echo
#     exit 1
# fi

# Commit changes
zsh $script_dir/../utility/git-commit.zsh \
    "install and configure Lerna"
