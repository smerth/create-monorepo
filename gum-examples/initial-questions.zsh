#!/bin/sh

SCRIPT_DIR=$(dirname "$0")

PINK=#cf118b
GREEN=#27d128
WHITE=#ffffff
ORANGE=#FFA500

# https://github.com/charmbracelet/gum

# Ask for GitHub Org name
GITHUB_ORG=$(gum input --placeholder "What is the name of your GitHub org?")

# Ask for repository name
REPO_NAME=$(gum input --placeholder "What is the name of the repo you just created?")

# Ask for Node version of the project
NODE_VERSION=$(gum input --placeholder "What version of node would you like to use? (eg: v16)")

