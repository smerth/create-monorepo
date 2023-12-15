#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# Colors
source $SCRIPT_DIR/../gum-ui/colors.zsh

# Collect args
EXIT_STATE=$1
ERROR_MESSAGE=$2
SUCCESS_MESSAGE=$3

# Echo Outcome
if [ $EXIT_STATE -ne 0 ]; then
    echo
    echo "$(gum style --foreground $RED "X Oops") $ERROR_MESSAGE"
    echo
    exit 1
else
    echo
    echo "$(gum style --foreground $GREEN "✓ Done") $SUCCESS_MESSAGE"
    echo
fi
