#!/bin/sh

TEXT=("$@")

export GUM_INPUT_CURSOR_FOREGROUND="#0000ff"
export GUM_INPUT_PROMPT_FOREGROUND="#0000ff"
export GUM_INPUT_PROMPT="> "
export GUM_INPUT_WIDTH=80


WHITE="ffffff"
BLUE="#0000ff"
AQUA="#4cd6f1"


clear

# --foreground is the text
# --border-foreground is the border itself

gum style \
	--background $BLUE --border-background $BLUE \
    --foreground $WHITE \
    --border-foreground $AQUA --border double \
	--align left --width 50 \
    --margin "1 2" --padding "2 2" \
    $TEXT
