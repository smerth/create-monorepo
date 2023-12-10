#!/bin/zsh

script_dir=$(dirname "$0")

# Colors
source $script_dir/../gum-ui/colors.zsh

# Collect args
exit_state=$1
error=$2
success=$3

# Echo Outcome
if [ $exit_state -ne 0 ]; then
    echo
    echo "$(gum style --foreground $ORANGE "X ERROR!") $error"
    echo
    exit 1
else
    echo
    echo "$(gum style --foreground $GREEN "✓ Success!") $success"
    echo
fi
