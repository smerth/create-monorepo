#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# Colors
source $SCRIPT_DIR/../utility/colors.zsh

# Intro
zsh $SCRIPT_DIR/../utility/banner.zsh \
  "Add an ".nvmrc" file with the Node version for this project."

if [[ $1 =~ ^(-nv|--node-version) ]]; then
  NODE_VERSION="$2"
else
  print "   "
  echo "$(gum style --foreground $RED "X ERROR!") Unable to read NODE_VERSION."
  print "   "
  exit 1
fi

# Add file
if [ ! -f .nvmrc ]; then
  # Create file
  touch .nvmrc
  # Add node version to file
  echo $NODE_VERSION >.nvmrc
  # Report outcome
  zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
    "Unable to write node version to .nvmrc." \
    "File .nvmrc created with node version."
else
  print "   "
  echo "$(gum style --foreground $BLUE "i INFO: ") File .nvmrc already exists."
  print "   "
fi

# Commit changes
zsh $SCRIPT_DIR/../utility/git_commit.zsh \
  "add .nvmrc file with the project node version."
