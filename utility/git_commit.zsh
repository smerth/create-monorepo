#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

source $SCRIPT_DIR/../utility/colors.zsh

MESSAGE=$1

# Intro
print "$(gum style --foreground $BLUE "* Commit changes to GitHub")"
# zsh $SCRIPT_DIR/../utility/banner.zsh \
#     "Commit changes to GitHub"

# Banner
# gum style --border normal --margin "1" --padding "2 2" --border-foreground $white "$(gum style --foreground $blue 'Add'), $(gum style --foreground $blue 'Commit'), and $(gum style --foreground $blue 'Push'), changes to $(gum style --foreground $blue 'GitHub')."

# Description
# echo "$(gum style --foreground $blue "Commit") with the message $(gum style --foreground $blue $MESSAGE)"
# echo

# Commit changes
gum spin --title " Adding changes..." -- git add .

# Report outcome
# zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
#     "Unable to add changes." \
#     "Changes added."

# Commit changes
git commit -m $MESSAGE

# Report outcome
# zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
#     "Unable to commit changes." \
#     "Changes committed."

# Commit changes
gum spin --title " Pushing changes..." -- git push

# Report outcome
zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
    "Unable to push changes to GitHub." \
    "GitHub up to date."
