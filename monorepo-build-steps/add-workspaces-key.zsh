#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

PINK=#cf118b
GREEN=#27d128
WHITE=#ffffff
ORANGE=#FFA500

# HEADER
TEXT=("ADD WORKSPACES KEY TO PACKAGE.JSON")
zsh $SCRIPT_DIR/../gum-ui/banner.zsh $TEXT

# DESCRIPTION
echo "- Add the $(gum style --foreground $PINK --bold "'.workspaces'") key to $(gum style --foreground $PINK --bold "'package.json'") tells Lerna to treat the project as a monorepo containing workspaces in the packages folder."

# Path to package.json file
JSON_FILE=package.json

# Print original JSON file to terminal
# echo "Original ${JSON_FILE}"
# cat $JSON_FILE | jq

# Add .workspaces key to json
if ! jq '.workspaces=["packages/*"]' $JSON_FILE >temp_data.json; then
    echo "$(gum style --foreground $ORANGE --bold "X ERROR!") It looks like there was a problem adding workspaces key to package.json"
    exit 1
else
    echo "$(gum style --foreground $GREEN --bold "✓ Success!") Workspaces key has been added to package.json"
fi

# Overwrite original JSON file
mv temp_data.json $JSON_FILE

# Print edited JSON file to terminal
# echo "Edited ${JSON_FILE}"
# cat $JSON_FILE | jq

# COMMIT CHANGES
git add . && git commit -m "Add workspaces key to package.json" && git push

echo "$(gum style --foreground $GREEN --bold "✓ Success!") Changes are committed and pushed."
