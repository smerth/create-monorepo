#!/bin/zsh

# Colors
source $script_dir/../gum-ui/colors.zsh

# Retrieve answers from the monorepo-options.json file
# ****************************************************
github_org=$(cat monorepo-options.json | jq .org_name)
repo=$(cat monorepo-options.json | jq .repo_name)
node_vers=$(cat monorepo-options.json | jq -r .node_version)
package_names=$(cat monorepo-options.json | jq .packages)
applications=$(cat monorepo-options.json | jq -r .apps)
