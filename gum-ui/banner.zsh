#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# Collect args
TEXT=("$@")

# Colors
source $SCRIPT_DIR/../gum-ui/colors.zsh

gum style \
    --border normal \
    --margin "1" \
    --padding "2 2" \
    --border-foreground $WHITE \
    $TEXT
