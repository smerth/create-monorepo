#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# Colors
source $SCRIPT_DIR/../utility/colors.zsh

# Collect args
EXIT_STATE=$1
ERROR_MESSAGE=$2
SUCCESS_MESSAGE=$3

if [ $EXIT_STATE -eq 0 ]; then
    echo
    echo "$(gum style --foreground $GREEN "✓ Done") $SUCCESS_MESSAGE"
    echo
else
    echo
    echo "$(gum style --foreground $RED "X Oops") $ERROR_MESSAGE"
    echo
    exit 1
fi
