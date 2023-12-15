#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

source $SCRIPT_DIR/gum-ui/colors.zsh

# Get options for creating a new Repo on Github and converting it to a Monorepo
# N.B. sourcing this script means
# its variables are available
# throughout the rest of this script
# source $SCRIPT_DIR/steps/0-get-options.zsh

# Create a new remote repository and clone it locally
# ***************************************************
# gh repo create $REPO_NAME \
#     --add-readme \
#     --private \
#     --clone \
#     --description $REPO_DESCRIPTION \
#     --gitignore "Node" \
#     --license "MIT"

# Change working Directory into new repo
# **************************************
# cd $REPO_NAME
cd golden

# print "this is NPMRC_CONFIG: $NPM_CONFIG"

# Add nvmrc
# *********
# example of calling a script with named parameter
# zsh $SCRIPT_DIR/2-add-nvmrc.zsh --node-version $NODE_VERSION

# Add npmrc
# *********
# sourcing a script so the variables are all available
# source $SCRIPT_DIR/3-add-npmrc.zsh

# Initiate yarn
# *************
zsh $SCRIPT_DIR/4-run-yarn-init.zsh

exit 1

# Add workspaces to package.json
# ******************************
zsh $SCRIPT_DIR/5-add-workspaces-key.zsh

# Install and initialize lerna
# ****************************
zsh $SCRIPT_DIR/6-run-lerna-init.zsh

# Add publish config to lerna
# ***************************
zsh $SCRIPT_DIR/7-add-lerna-publish-config.zsh

# Add packages
# ************
if (($(echo $package_names | jq " . | length") != 0)); then zsh $SCRIPT_DIR/steps/8-add-packages.zsh "$package_names"; fi

# Add apps
# ********
if (($(echo $applications | jq " . | length") != 0)); then zsh $SCRIPT_DIR/steps/9-add-apps.zsh $applications; fi

# Reinstall dependancies
# **********************
