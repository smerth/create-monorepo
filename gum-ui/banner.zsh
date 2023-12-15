#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# Collect args
TEXT=("$@")

# Colors
source $SCRIPT_DIR/../gum-ui/colors.zsh

gum style \
    --background $BLACK \
    --foreground $WHITE \
    --border normal \
    --border-foreground $WHITE \
    --border-background $BLACK \
    --width 64 \
    --margin "1" \
    --padding "1 1" \
    $TEXT
