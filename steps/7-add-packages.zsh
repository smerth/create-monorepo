#!/bin/zsh

# Collect args
SCRIPT_DIR=$(dirname "$0")
PACKAGE_NAMES=$1

# Colors
source $SCRIPT_DIR/../gum-ui/colors.zsh

# add more parameters to lerna create for greater control
# https://www.npmjs.com/package/@lerna/create

# Banner
zsh $SCRIPT_DIR/../gum-ui/banner.zsh \
    "Add $(gum style --foreground $BLUE "packages") to the monorepo."

# Description
echo "Add $(gum style --foreground $BLUE "packages") using $(gum style --foreground $BLUE "'lerna create'")."
echo

echo $PACKAGE_NAMES | jq -r '.[]' | while read i; do
    # do stuff with $i
    npx lerna create ${i} packages --yes

    zsh $SCRIPT_DIR/../utility/outcome.zsh \
        "$?" \
        "There was a problem adding the package ${i} to the monorepo!" \
        "Your package ${i} has been created and added to the monorepo."
done

# Commit changes
zsh $SCRIPT_DIR/git-commit.zsh \
    "add packages to the monorepo"
