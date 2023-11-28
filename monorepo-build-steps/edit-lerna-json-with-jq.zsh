#!/bin/zsh

# Add .command key to lerna.json config file to define publishing config.

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

echo "lerna.json"
cat lerna.json | jq

jq ".command=${COMMAND_PROPERTY}" lerna.json  > temp_data.json

mv temp_data.json lerna.json

echo "edited lerna.json"
cat lerna.json | jq
