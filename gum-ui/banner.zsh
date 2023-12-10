#!/bin/zsh

script_dir=$(dirname "$0")

# Collect args
TEXT=("$@")

# Colors
source $script_dir/../gum-ui/colors.zsh

gum style \
    --border normal \
    --margin "1" \
    --padding "2 2" \
    --border-foreground $WHITE \
    $TEXT
