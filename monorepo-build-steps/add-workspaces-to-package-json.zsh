#!/bin/zsh

# Execute
# zsh add-workspaces-to-package-json.zsh

# Add "workspaces" key to package.json

# Path to package.json file
JSON_FILE=package.json

# Print original JSON file to terminal
echo "Original ${JSON_FILE}"
cat $JSON_FILE | jq

# Add .workspaces key to json
jq '.workspaces=["packages/*"]' $JSON_FILE  > temp_data.json

# Overwrite original JSON file
mv temp_data.json $JSON_FILE

# Print edited JSON file to terminal
echo "Edited ${JSON_FILE}"
cat $JSON_FILE | jq
