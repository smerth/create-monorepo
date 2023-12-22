# create-monorepo

A Shell CLI to create a nodejs/lerna/yarn monorepo with any number of packages and any number of Nextjs, Gatsby or Expo apps. 

## Intoduction

A Gum/Shell CLI to create a Node/Lerna/Yarn monorepo with two demo packages ready to publish.

The build process modifies the steps outlined in the nice summary article: [publishing and installing private github packages using yarn and lerna](https://viewsource.io/publishing-and-installing-private-github-packages-using-yarn-and-lerna/)

## Requirements

yarn add -g lerna

jq

gum

nvm

node

### Node setup

You should have Node setup with Yarn installed and NVM setup to manage node versions.

### GH

You must have the gh cli installed and authorized to work with your github account

### gum

This CLI is built with [gum](https://github.com/charmbracelet/gum). You must have gum installed.

```shell
brew install gum
```

## Setup Script

### Copy script to local folder

```shell
git clone https://github.com/smerth/create-monorepo.git
```

### Add path to the script to the $PATH variable

Check path to the script with `pwd`

Add the path in `.zprofile`

```shell
echo "export PATH=$PATH:/Users/smerth/Developer/shell-scripts/create-monorepo" >> ~/.zprofile && source ~/.zprofile
```

### Add an alias for the script

Append an alias for the script to `.zprofile`

```shel
echo 'alias cm="create-monorepo.zsh"' >> ~/.zprofile && source ~/.zprofile
```

## Execute the script

CD into the folder you want to contain your new monorepo

```shell
cd ~/smerth/Developer/github-repositories/
```

Call the script

```shell
cm
```

## Steps covered

This script will guide you through the following steps

- create a new repo using the GH CLI

## Gotchas

### Remix

#### Missing version

Remix installation with `npx create-remix` uses a template that does not have a version property in the package.json. You need to add this.

#### Yarn.lock

Remix installation `npx create-remix` offers to install with `npm` which you should not do since this monorepo is using `yarn`

But this leaves the Remix app without a `yarn.lock` file.

To fix this you need to `cd` into the app and run `yarn init` and then run `yarn` once to create the `yarn.lock` file.

Then you can delete the `node_modules` folder and reinstall all deps from the monorepo root.
