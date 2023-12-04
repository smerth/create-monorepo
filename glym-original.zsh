#!/bin/zsh

# REFERENCES:
# https://github.com/charmbracelet/gum
# https://unix.stackexchange.com/questions/273341/obtain-script-current-directory-so-that-i-can-do-include-files-without-relative

SCRIPT_DIR=$(dirname "$0")

PINK=#cf118b
GREEN=#27d128
WHITE=#ffffff
ORANGE=#FFA500

# CREATE A REPOSITORY ON GITHUB
zsh $SCRIPT_DIR/monorepo-build-steps/create-repository.zsh

# QUESTIONS

# Ask for GitHub Org name
GITHUB_ORG=$(gum input --placeholder "What is the name of your GitHub org?")
# Ask for repository name
REPO_NAME=$(gum input --placeholder "What is the name of the repo you just created?")
# Ask for Node version of the project
NODE_VERSION=$(gum input --placeholder "What version of node would you like to use? (eg: v16)")

# CD INTO THE REPOSITORY FOLDER
if ! cd $REPO_NAME; then
    echo "$(gum style --foreground $ORANGE --bold "X ERROR!") Unable to CD into the provided project folder."
    exit 1
fi

# ADD NVMRC
zsh $SCRIPT_DIR/monorepo-build-steps/add-nvmrc.zsh $NODE_VERSION

# INITIATE YARN PROJECT
zsh $SCRIPT_DIR/monorepo-build-steps/yarn-init.zsh

# ADD WORKSPACES KEY TO PACKAGE.JSON
zsh $SCRIPT_DIR/monorepo-build-steps/add-workspaces-key.zsh

# INSTALL AND INITIALIZE LERNA
zsh $SCRIPT_DIR/monorepo-build-steps/install-and-configure-lerna.zsh

# ADD PUBLISH CONFIG TO LERNA.JSON
zsh $SCRIPT_DIR/monorepo-build-steps/add-lerna-publish-config.zsh

# ADD PACKAGES
zsh $SCRIPT_DIR/monorepo-build-steps/add-packages-with-lerna.zsh $GITHUB_ORG

# ADD APPS
zsh $SCRIPT_DIR/monorepo-build-steps/add-apps.zsh $GITHUB_ORG

# INSTALL AND CONFIGURE LERNA
# zsh $SCRIPT_DIR/monorepo-build-steps/install-and-configure-lerna.zsh

# EDIT LERNA CONFIG TO PUBLISH TO GITHUB PACKAGE REGISTRY
# zsh $SCRIPT_DIR/monorepo-build-steps/edit-lerna-json-with-jq.zsh
