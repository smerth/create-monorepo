#!/bin/zsh

# SCRIPT_DIR=$(dirname "$0")

# REQUIRED! pass in GITHUB_ORG as first arg
GITHUB_ORG=$1

PINK=#cf118b
GREEN=#27d128
WHITE=#ffffff
ORANGE=#FFA500

# TODO: instead of the array PACKAGE_NAMES=() use an array of objects
# name, description etc applicable to lerna create so you can execute
# lerna create with greater control
# https://www.npmjs.com/package/@lerna/create

# ADD PACKAGES USING LERNA
TEXT=("ADD PACKAGES USING LERNA")
zsh $SCRIPT_DIR/../gum-ui/banner.zsh $TEXT

# DESCRIPTION
echo "- Ask for $(gum style --foreground $PINK --bold "package names") to be created and pass each name to $(gum style --foreground $PINK --bold "'lerna create'")."


# Create an array to hold package names
PACKAGE_NAMES=()

# Collect names from user
gum confirm "Add a package to your monorepo?"
# As long as the user enters yes
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
    # echo "@${GITHUB_ORG}/${PKG_NAME}"

    if ! lerna create "@${GITHUB_ORG}/${PKG_NAME}" packages --yes; then
        echo "$(gum style --foreground $ORANGE --bold "X ERROR!") It looks like there was a problem creating a package."
        exit 1
        else
        echo "$(gum style --foreground $GREEN --bold "✓ Success!") Your package @${GITHUB_ORG}/${PKG_NAME} has been created."
    fi

    # create package with name-spaced package name
    # lerna create "@${GITHUB_ORG}/${PKG_NAME}" packages --yes

    # If packages are created manually you need to initiate each one.
    # cd into package
    # yarn init
    # cd out
done

# COMMIT CHANGES
git add . && git commit -m "Created projects with lerna create"  && git push

echo "$(gum style --foreground $GREEN --bold "✓ Success!") Changes are committed and pushed."
