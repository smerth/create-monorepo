#!/bin/zsh

# Collect args
script_dir=$(dirname "$0")
package_names=$1

# Colors
source $script_dir/../gum-ui/colors.zsh

# add more parameters to lerna create for greater control
# https://www.npmjs.com/package/@lerna/create

# Banner
zsh $script_dir/../gum-ui/banner.zsh \
    "Add $(gum style --foreground $BLUE "packages") to the monorepo."

# Description
echo "Add $(gum style --foreground $BLUE "packages") using $(gum style --foreground $BLUE "'lerna create'")."
echo

echo $package_names | jq -r '.[]' | while read i; do
    # do stuff with $i
    npx lerna create ${i} packages --yes

    zsh $script_dir/../utility/outcome.zsh \
        "$?" \
        "There was a problem adding the package ${i} to the monorepo!" \
        "Your package ${i} has been created and added to the monorepo."
done

# Commit changes
zsh $script_dir/git-commit.zsh \
    "add packages to the monorepo"
