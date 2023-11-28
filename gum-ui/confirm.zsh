#!/bin/sh

gum confirm "Sound good?" --affirmative="OK" --negative="Cancel" --selected.background="#0000ff" --selected.foreground="#ffffff"

# if [ $? -eq 0 ]; then
#   echo "Lets go!"
# else
#   echo "Well, maybe later..."
# fi