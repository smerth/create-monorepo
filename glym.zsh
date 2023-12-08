#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# Create a repo
# *************
# Use the GH CLI to create a repo on GitHub
# Clone the repo to the working directory
# source $SCRIPT_DIR/steps/0-create-repo.zsh

# Get user input
# **************
# Source questions so the working directory remains
# in repository after questions run
# TODO: refactor to remove the use of an options file
# source $SCRIPT_DIR/steps/1-questions.zsh

# FOR DEBUGGING STEPS
# *******************
cd hoop
pwd
# *******************

# Retrieve answers from the monorepo-options.json file
# ****************************************************
GITHUB_ORG=$(cat monorepo-options.json | jq .org_name)
REPO=$(cat monorepo-options.json | jq .repo_name)
NODE_VERS=$(cat monorepo-options.json | jq -r .node_version)
PACKAGE_NAMES=$(cat monorepo-options.json | jq .packages)

APPlICATIONS=$(cat monorepo-options.json | jq -r .apps)

# ADD NVMRC
# zsh $SCRIPT_DIR/steps/2-add-nvmrc.zsh "$NODE_VERS"
# zsh $SCRIPT_DIR/steps/2-add-nvmrc.zsh "$NODE_VERS"

# INITIATE YARN PROJECT
# zsh $SCRIPT_DIR/steps/3-run-yarn-init.zsh

# ADD WORKSPACES KEY TO PACKAGE.JSON
# zsh $SCRIPT_DIR/steps/4-add-workspaces-key.zsh

# INSTALL AND INITIALIZE LERNA
# zsh $SCRIPT_DIR/steps/5-run-lerna-init.zsh

# ADD PUBLISH CONFIG TO LERNA.JSON
# zsh $SCRIPT_DIR/steps/6-add-lerna-publish-config.zsh

# ADD PACKAGES
# zsh $SCRIPT_DIR/steps/7-add-packages.zsh "$PACKAGE_NAMES"

# ADD APPS
# TODO: DELETE .git folder in a gatsby installation if it exists
zsh $SCRIPT_DIR/steps/8-add-apps.zsh $APPlICATIONS

# TODO: remove all node_module folders and re-install deps with yarn
