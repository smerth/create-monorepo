#!/bin/sh

# Introduce this step
TEXT=("Create a repository on GitHub and clone it.")
zsh gum-ui/banner.zsh $TEXT

gh_repo_create_description=("Lets run the 'gh repo create' command because it prompts us for all the options available to us when creating a repo on GitHub. Be sure to choose the option to clone the repo locally so we can work with it.")
zsh gum-ui/description.zsh $gh_repo_create_description

# Confirm
gum confirm "Sound good?" --affirmative="OK" --negative="Cancel" --selected.background="#0000ff" --selected.foreground="#ffffff"

# Run GitHub CLI to create a repository on GitHub
if [ $? -eq 0 ]; then
    gh repo create
else
    echo "OK, see ya..."
fi
