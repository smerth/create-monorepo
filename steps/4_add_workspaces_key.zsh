#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# Colors
source $SCRIPT_DIR/../gum-ui/colors.zsh

# Intro
zsh $SCRIPT_DIR/../gum-ui/banner.zsh \
    "Add $(gum style --foreground $BLUE 'workspaces') key to $(gum style --foreground $BLUE 'package.json')."

# Path to package.json file
JSON_FILE=package.json

# Add .workspaces key to json
if ! jq '.workspaces=["packages/*"]' $JSON_FILE >temp_data.json; then
    echo "$(gum style --foreground $RED "X Oops!") It looks like there was a problem adding workspaces key to package.json"
    exit 1
else
    # Overwrite original JSON file
    mv temp_data.json $JSON_FILE
    echo "$(gum style --foreground $GREEN "✓ Success!") Workspaces key has been added to package.json"
    echo
    # cat $JSON_FILE | jq .
    # echo
fi

# Commit changes
zsh $SCRIPT_DIR/../utility/git-commit.zsh \
    "add workspaces key to package.json"
