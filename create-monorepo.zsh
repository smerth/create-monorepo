#!/bin/zsh

script_dir=$(dirname "$0")

# Create a repo
# *************
# Use the GH CLI to create a repo on GitHub
# Clone the repo to the working directory
source $script_dir/steps/0-create-repo.zsh

# Get user input
# **************
# Source questions so the working directory remains
# in repository after questions run
# TODO: refactor to remove the use of an options file
source $script_dir/steps/1-questions.zsh

# Retrieve answers from the monorepo-options.json file
# ****************************************************
github_org=$(cat monorepo-options.json | jq .org_name)
repo=$(cat monorepo-options.json | jq .repo_name)
node_vers=$(cat monorepo-options.json | jq -r .node_version)
package_names=$(cat monorepo-options.json | jq .packages)
applications=$(cat monorepo-options.json | jq -r .apps)

# ADD NVMRC

zsh $script_dir/steps/2-add-nvmrc.zsh "$node_vers"

# INITIATE YARN PROJECT
zsh $script_dir/steps/3-add-npmrc.zsh

# INITIATE YARN PROJECT
zsh $script_dir/steps/4-run-yarn-init.zsh

# ADD WORKSPACES KEY TO PACKAGE.JSON
zsh $script_dir/steps/5-add-workspaces-key.zsh

# INSTALL AND INITIALIZE LERNA
zsh $script_dir/steps/6-run-lerna-init.zsh

# ADD PUBLISH CONFIG TO LERNA.JSON
zsh $script_dir/steps/7-add-lerna-publish-config.zsh

# ADD PACKAGES
# TODO: only install packages if package_names array contains names
# echo $package_names | jq length
zsh $script_dir/steps/8-add-packages.zsh "$package_names"

# ADD APPS
# TODO: only install apps if apps array contains type
# echo $applications | jq length
zsh $script_dir/steps/9-add-apps.zsh $applications

# lerna clean removes all node_modules from packages (but does it remove from apps?)
lerna clean --yes

# Remove all node_module folders
find . \( -name "node_modules" \) -exec rm -rf -- {} +s

# Reinstall everything with yarn
yarn

# TODO: Add npmrc with config for publishing to private repos
