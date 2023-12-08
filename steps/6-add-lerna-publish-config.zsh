#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# Colors
source $SCRIPT_DIR/../gum-ui/colors.zsh

# Banner
gum style --border normal --margin "1" --padding "2 2" --border-foreground $WHITE "Add $(gum style --foreground $BLUE "publishing config") for Lerna."

# Description
echo "Add the following publish config object to $(gum style --foreground $BLUE "'.command'") key in $(gum style --foreground $BLUE "lerna.json")"
echo

# store multi line text to variable
read -r -d '' COMMAND_PROPERTY <<EOM
{
    "publish": {
      "conventionalCommits": true,
      "message": "chore(release): publish",
      "registry": "https://npm.pkg.github.com",
      "allowBranch": ["main", "next", "feature/*"]
    }
}
EOM

# echo the json to be inserted
echo $COMMAND_PROPERTY | jq .
echo

# add json to lerna.json
jq ".command=${COMMAND_PROPERTY}" lerna.json >temp_data.json && mv temp_data.json lerna.json

# echo outcome message
zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" "There was a problem adding the publishing config to lerna.json!" "Publish config has been added to the .command key in lerna.json"

# echo edited lerna,json
cat lerna.json | jq .

# Commit changes
zsh $SCRIPT_DIR/git-commit.zsh "add publish config object to .command key in lerna.json"
