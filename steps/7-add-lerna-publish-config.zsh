#!/bin/zsh

script_dir=$(dirname "$0")

# Colors
source $script_dir/../gum-ui/colors.zsh

# Banner
gum style --border normal --margin "1" --padding "2 2" --border-foreground $white "Add $(gum style --foreground $blue "publishing config") for Lerna."

# Description
echo "Add the following publish config object to $(gum style --foreground $blue "'.command'") key in $(gum style --foreground $blue "lerna.json")"
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
zsh $script_dir/../utility/outcome.zsh "$?" "There was a problem adding the publishing config to lerna.json!" "Publish config has been added to the .command key in lerna.json"

# echo edited lerna,json
cat lerna.json | jq .

# Commit changes
zsh $script_dir/../utility/git-commit.zsh \
  "add publish config object to .command key in lerna.json"
