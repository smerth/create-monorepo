#!/bin/zsh

# TODO: check if apps array is empty then skip this step
# TODO: add apps to the workspaces key
# TODO: remove git folders in gatby apps
# TODO: remove all node_module folders in apps and packages with lerna
# TODO: reinstall everything with yarn

# Collect args
SCRIPT_DIR=$(dirname "$0")
APPlICATIONS=$1

# Colors
source $SCRIPT_DIR/../gum-ui/colors.zsh

# Banner
# zsh $SCRIPT_DIR/../gum-ui/banner.zsh \
#     "Add $(gum style --foreground $BLUE "apps") to the monorepo."

# Description
# echo "Call the install CLI for each of the previously specified apps."
# echo

# Reload .zshrc to load correct Node version
echo
source ~/.zshrc
echo

# ADD AN APPS FOLDER IF IT DOESN'T EXIST
if [ ! -d "apps" ]; then
    # ADD AN APPS FOLDER
    mkdir apps
    # Report outcome
    zsh $SCRIPT_DIR/../utility/outcome.zsh \
        "$?" \
        "There was a problem adding the apps directory!" \
        "The apps has been added to the monorepo."
else
    echo "The apps directory already exists."
    echo
fi

# MOVE INTO THE APPS FOLDER
cd apps

for a in "${APPlICATIONS[@]}"; do
    echo "this is a: $a"
    # or do whatever with individual element of the array
done

for row in $(echo "${APPlICATIONS}" | jq -r '.[]'); do
    # _jq() {
    #  echo ${row} | base64 --decode | jq -r ${1}
    # }
    #    echo $(_jq '.name')
    echo ${row}
    if [ $row = "NEXT" ]; then
        yarn create next-app
    fi
    if [ $row = "REMIX" ]; then
        npx create-remix
    fi
    if [ $row = "GATSBY" ]; then
        npx gatsby new
    fi
    if [ $row = "EXPO" ]; then
        npx create-expo-app
    fi
done
