#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# COLORS
# Don't need to source colors since this script is being sourced, not executed
# source $SCRIPT_DIR/../gum-ui/colors.zsh

# Intro
zsh $SCRIPT_DIR/../gum-ui/banner.zsh \
    "Add .npmrc with package registry config"

# add .npmrc to .gitignore to exclude from .npmrc git tracking
read -r -d '' IGNORE_NPMRC <<EOM
# Do not commit .npmrc as it may contain tokens or secrets
.npmrc
EOM

print $IGNORE_NPMRC >>.gitignore

zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
    "Unable to append '.npmrc' to .gitignore" \
    "Appended '.npmrc' to .gitignore"

# Add .npmrc file
if [ ! -f .npmrc ]; then
    # Create file
    touch .npmrc
else
    print "   "
    echo "$(gum style --foreground $BLUE "* INFO: ") File .npmrc already exists."
    print "   "
fi

# Excude npmrc from git tracking
read -r -d '' NPMRC_CONFIG <<EOM
//npm.pkg.github.com/:_authToken=TOKEN
@${GITHUB_ORG}:registry=https://npm.pkg.github.com
EOM

# ...do something interesting...
if [ "$NO_OPTION_FILE" = true ]; then
    # print "Not using an options file"
    print $NPMRC_CONFIG >.npmrc

    # Report outcome
    zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
        "Unable to write config to '.npmrc'" \
        "Config written to .npmrc"
else
    if $(cat ../$OPTIONS_FILE | jq -e '. | has("npmrc-config")'); then
        # print "The options file contains npm config"
        cat ../$OPTIONS_FILE | jq -r '. "npmrc-config"[]' >.npmrc

        # Report outcome
        zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
            "Unable to write config to '.npmrc'" \
            "Config written to .npmrc"
    else
        # print "The options file does not contain npm config"
        print $NPMRC_CONFIG >.npmrc

        # Report outcome
        zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
            "Unable to write config to '.npmrc'" \
            "Config written to .npmrc"
    fi
fi

# Commit changes
zsh $SCRIPT_DIR/../utility/git-commit.zsh \
    "add .npmrc file with config for GitHub Package Registry."
