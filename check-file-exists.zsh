#!/bin/zsh

# This is a bash script that checks if a file exists

FILE=$1

if [[ -e $FILE ]]; then
    echo 'File exists!'
else
    echo 'File does not exist!'
    exit 1
fi

# Output:
# 'File does not exist!'
