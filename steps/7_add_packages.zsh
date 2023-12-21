#!/bin/zsh

# Collect args
SCRIPT_DIR=$(dirname "$0")

# add more parameters to lerna create for greater control
# https://www.npmjs.com/package/@lerna/create

# Intro
zsh $SCRIPT_DIR/../utility/banner.zsh \
    "Add $(gum style --foreground $BLUE "packages") to the monorepo."

# Add packages

# If not using an options file
if [ "$NO_OPTION_FILE" = true ]; then
    # If the PACKAGE_NAMES var does not exists
    if [[ -z $PACKAGE_NAMES ]]; then
        print "No packages to install"
    else
        # If PACKAGE_NAMES VAR exists
        echo $PACKAGE_NAMES | jq -r '.[]' | while read i; do
            # do stuff with $i
            npx lerna create ${i} packages --yes

            # Report outcome
            zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
                "There was a problem adding the package ${i} to the monorepo!" \
                "Your package ${i} has been created and added to the monorepo."
        done
    fi
else
    # We are using the options file and it has a packages-names key
    if $(cat ../$OPTIONS_FILE | jq -e '. | has("package-names")'); then
        cat ../$OPTIONS_FILE | jq -r '. "package-names" | .[]' | while read packagename; do

            npx lerna create ${packagename} packages --yes

            zsh $SCRIPT_DIR/../utility/outcome.zsh \
                "$?" \
                "There was a problem adding the package ${packagename} to the monorepo!" \
                "Your package ${packagename} has been created and added to the monorepo."
        done
    else
        # We are using the options file but it does not contain a packages-names key
        print "No packages to install"
    fi
fi

# Commit changes
zsh $SCRIPT_DIR/../utility/git_commit.zsh \
    "add packages to the monorepo"
