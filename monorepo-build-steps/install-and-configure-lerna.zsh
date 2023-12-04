#!/bin/zsh

PINK=#cf118b
GREEN=#27d128
WHITE=#ffffff
ORANGE=#FFA500

SCRIPT_DIR=$(dirname "$0")

# Section Header
HEADER=("INSTALL AND CONFIGURE LERNA")
zsh $SCRIPT_DIR/../gum-ui/banner.zsh $HEADER

# DESCRIPTION
echo "- Add $(gum style --foreground $PINK --bold "Lerna") dependancy at the project root and initialize Lerna"

# install lerna at workspace root so we can run it in npm scripts
if ! yarn add lerna -W; then
    echo "$(gum style --foreground $ORANGE --bold "X ERROR!") There was a problem adding Lerna to the workspace root."
    exit 1
    else
    echo "$(gum style --foreground $GREEN --bold "✓ Success!") Lerna has been added to the workspace root."
fi

# Initialize lerna using packages workspace
if ! lerna init --packages="packages/*"; then
    echo "$(gum style --foreground $ORANGE --bold "X ERROR!") There was a problem initializing Lerna."
    exit 1
    else
    echo "$(gum style --foreground $GREEN --bold "✓ Success!") Lerna has been initialized."
fi

# COMMIT CHANGES
git add . && git commit -m "Install and configure Lerna"  && git push

echo "$(gum style --foreground $GREEN --bold "✓ Success!") Changes are committed and pushed."




