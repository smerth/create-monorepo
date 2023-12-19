#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

source $SCRIPT_DIR/gum-ui/colors.zsh

# Get options for creating a new Repo on Github and converting it to a Monorepo
# N.B. sourcing this script means:
# its variables are available throughout the rest of this script
# the path to reference further scripts is relative to the /steps dir
source $SCRIPT_DIR/steps/0_get_options.zsh

# Create a new remote repository and clone it locally
# ***************************************************
gh repo create $REPO_NAME \
    --add-readme \
    --private \
    --clone \
    --description $REPO_DESCRIPTION \
    --gitignore "Node" \
    --license "MIT"

# Change working Directory into new repo
# **************************************
cd $REPO_NAME

# Add nvmrc
# *********
# example of calling a script with named parameter
zsh $SCRIPT_DIR/1_add_nvmrc.zsh --node-version $NODE_VERSION

# Add npmrc
# *********
# sourcing a script so the variables are all available
source $SCRIPT_DIR/2_add_npmrc.zsh

# Initiate yarn
# *************
source $SCRIPT_DIR/3_run_yarn_init.zsh

# Add workspaces to package.json
# ******************************
zsh $SCRIPT_DIR/4_add_workspaces_key.zsh

# Install and initialize lerna
# ****************************
zsh $SCRIPT_DIR/5_run_lerna_init.zsh

# Add publish config to lerna
# ***************************
source $SCRIPT_DIR/6_add_lerna_publish_config.zsh

# Add packages
# ************
source $SCRIPT_DIR/7_add_packages.zsh

# Add apps
# ********
source $SCRIPT_DIR/8_add_apps.zsh

# Reinstall dependancies
# source $SCRIPT_DIR/9-remove-git-sub-modules.zsh
