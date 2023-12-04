#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

PINK=#cf118b
GREEN=#27d128
WHITE=#ffffff
ORANGE=#FFA500

# DESCRIPTION
echo "- Add publish config object to $(gum style --foreground $PINK --bold "'.command'") key in $(gum style --foreground $PINK --bold "lerna.json")" 

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

if ! jq ".command=${COMMAND_PROPERTY}" lerna.json  > temp_data.json; then
    echo "$(gum style --foreground $ORANGE --bold "X ERROR!") It looks like there was a problem adding workspaces key to package.json"
    exit 1
    else
    echo "$(gum style --foreground $GREEN --bold "✓ Success!") Workspaces key has been added to package.json"
fi

mv temp_data.json lerna.json

# echo "edited lerna.json"
# cat lerna.json | jq

# COMMIT CHANGES
git add . && git commit -m "Add publish config object to .command key in lerna.json"  && git push

echo "$(gum style --foreground $GREEN --bold "✓ Success!") Changes are committed and pushed."
