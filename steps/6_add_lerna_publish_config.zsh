#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# TODO: refactor: name: add commands to lerna.json config...

# Colors
# source $SCRIPT_DIR/../gum-ui/colors.zsh

# Intro
zsh $SCRIPT_DIR/../gum-ui/banner.zsh \
  "Add $(gum style --foreground $BLUE "publishing config") for Lerna."

# store default confgi (multi line text) to variable
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

# Use lerna config from options file if present
if [ "$NO_OPTION_FILE" = true ]; then
  # print "Not using an options file"
  cat lerna.json | jq --argjson pubconfig "$COMMAND_PROPERTY" '. += {"command": $pubconfig}' >tmp-lerna.json && mv tmp-lerna.json lerna.json
  # Report outcome
  zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
    "Unable to write commands config from options file to 'lerna.json' (Not using an options file)" \
    "Commands config from options file written to lerna.json"
else
  if $(cat ../$OPTIONS_FILE | jq -e '. | has("command")'); then
    # print "The options file contains lerna command config"
    OPTIONS_CONFIG=$(cat ../$OPTIONS_FILE | jq '. "command"')
    cat lerna.json | jq --argjson pubconfig "$OPTIONS_CONFIG" '. += {"command": $pubconfig}' >tmp-lerna.json && mv tmp-lerna.json lerna.json

    # Report outcome
    zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
      "Unable to write commands config from options file to 'lerna.json' (The options file contains lerna command config)" \
      "Commands config from options file written to lerna.json"
  else
    # print "The options file does not contain lerna command config (using default)"
    # TODO: Next...
    cat lerna.json | jq --argjson pubconfig "$COMMAND_PROPERTY" '. += {"command": $pubconfig}' >tmp-lerna.json && mv tmp-lerna.json lerna.json

    # Report outcome
    zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
      "Unable to write commands config from options file to 'lerna.json' (The options file does not contain lerna command config (using default))" \
      "Commands config from options file written to lerna.json"
  fi
fi

# Commit changes
zsh $SCRIPT_DIR/../utility/git-commit.zsh \
  "add publish config object to .command key in lerna.json"
