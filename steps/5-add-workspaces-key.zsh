#!/bin/zsh

script_dir=$(dirname "$0")

# Colors
source $script_dir/../gum-ui/colors.zsh

# Banner
gum style --border normal --margin "1" --padding "2 2" --border-foreground $white "Add $(gum style --foreground $blue 'workspaces') key to $(gum style --foreground $blue 'package.json')."

# Description
echo "The $(gum style --foreground $blue "'workspaces'") key in package.json tells Lerna where to look for workspaces."
echo

# Path to package.json file
JSON_FILE=package.json

# Add .workspaces key to json
if ! jq '.workspaces=["packages/*"]' $JSON_FILE >temp_data.json; then
    echo "$(gum style --foreground $orange "X ERROR!") It looks like there was a problem adding workspaces key to package.json"
    exit 1
else
    # Overwrite original JSON file
    mv temp_data.json $JSON_FILE
    echo "$(gum style --foreground $green "✓ Success!") Workspaces key has been added to package.json"
    echo
    cat $JSON_FILE | jq .
    echo
fi

# Commit changes
zsh $script_dir/../utility/git-commit.zsh \
    "add workspaces key to package.json"
