#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")
PINK=#cf118b
GREEN=#27d128
WHITE=#ffffff

# DESCRIPTION
echo "- Add $(gum style --foreground $PINK --bold "'.command'") key to $(gum style --foreground $PINK --bold "lerna.json") with publish config object" 

# store multi line text to variable
read -r -d '' COMMAND_PROPERTY << EOM
{
    "publish": {
      "conventionalCommits": true,
      "message": "chore(release): publish",
      "registry": "https://npm.pkg.github.com",
      "allowBranch": ["main", "next", "feature/*"]
    }
}
EOM

# echo "lerna.json"
# cat lerna.json | jq

jq ".command=${COMMAND_PROPERTY}" lerna.json  > temp_data.json

mv temp_data.json lerna.json

echo "$(gum style --foreground $GREEN --bold "✓ Success!") edited $(gum style --foreground $PINK --bold "lerna.json")"

# echo "edited lerna.json"
# cat lerna.json | jq
