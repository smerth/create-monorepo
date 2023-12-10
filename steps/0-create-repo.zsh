#!/bin/zsh

script_dir=$(dirname "$0")

# Colors
source $script_dir/../gum-ui/colors.zsh

clear

# Banner
gum style --border normal --margin "1" --padding "2 2" --border-foreground $WHITE "Create a $(gum style --foreground $BLUE 'repository') on $(gum style --foreground $BLUE 'GitHub')."

# Description
echo "Use GitHub's $(gum style --foreground $BLUE "GH CLI") to create a new repo on GitHub and then clone it to the current directory."
echo

# Create a repository on GitHub
if ! gh repo create; then
    echo "$(gum style --foreground $RED "X ERROR!") It looks like there is a problem creating a repo on GitHub and then cloning it."
    exit 1
else
    echo
    echo "$(gum style --foreground $GREEN "✓ Success!") A new repository has been created on GitHub and cloned"
    echo
fi
