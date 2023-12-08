#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

JSON="data/package.json"

# This works but its not pretty
# echo $(cat $JSON | jq '.packages += ["@smerth/cats"]') >$JSON

# This two step works but why is two steps necessary
jq '.packages += ["@smerth/cats"]' $JSON >temp.json

mv temp.json $JSON
