#!/bin/zsh

json='[{"name": "jon", "class": "senior"}]'
new="string"

echo "$json" | jq --arg n $new '. += [$n]'
