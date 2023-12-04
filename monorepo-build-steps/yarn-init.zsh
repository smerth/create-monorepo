#!/bin/sh

SCRIPT_DIR=$(dirname "$0")

PINK=#cf118b
GREEN=#27d128
WHITE=#ffffff
ORANGE=#FFA500

# HEADER
TEXT=("INITIATE NPM PROJECT USING YARN.")
zsh $SCRIPT_DIR/../gum-ui/banner.zsh $TEXT

# DESCRIPTION
echo "- Let's run $(gum style --foreground $PINK --bold "'yarn init'")."

# INITIATE YARN PROJECT
if ! yarn init; then
    echo "$(gum style --foreground $ORANGE --bold "X ERROR!") It looks like there was a problem completing yarn init."
    exit 1
    else
    echo "$(gum style --foreground $GREEN --bold "✓ Success!") Your yarn project is initiated."
fi

# COMMIT CHANGES
git add . && git commit -m "Initiate project with yarn"  && git push

echo "$(gum style --foreground $GREEN --bold "✓ Success!") Changes are committed and pushed."
