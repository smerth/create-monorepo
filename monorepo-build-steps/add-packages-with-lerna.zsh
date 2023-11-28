#!/bin/zsh

# TODO: instead of the array PACKAGE_NAMES=() use an array of objects
# name, description etc applicable to lerna create so you can execute
# lerna create with grearter control
# https://www.npmjs.com/package/@lerna/create

# REQUIRED! pass in GITHUB_ORG as first arg
GITHUB_ORG=$1

# ADD PACKAGES USING LERNA

# Create an array to hold package names
PACKAGE_NAMES=()

# Collect names from user
gum confirm "Add a package to your monorepo?"
# As long as the output from confirm is truthy
while [ $? -eq 0 ]; do
    # Ask for repository name
    PACKAGE_NAME=$(gum input --placeholder "What do you want to name your package?")
    # Add name to array of names
    PACKAGE_NAMES+="${PACKAGE_NAME}"
    # Ask for another package name
    gum confirm "Add another package to your monorepo?"
done

# Loop through array
for PKG_NAME in ${PACKAGE_NAMES[@]}; do
    # create package with name-spaced package name
    lerna create '"@'${GITHUB_ORG}/${PKG_NAME}'"' packages --yes
    # cd into package
    # initialize
    # cd out
done