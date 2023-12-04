#!/bin/sh

SCRIPT_DIR=$(dirname "$0")

PINK=#cf118b
GREEN=#27d128
WHITE=#ffffff
ORANGE=#FFA500

if [ $# -eq 0 ]
  then
    echo "$(gum style --foreground $ORANGE --bold "X ERROR!") Unable to read NODE_VERSION."
    exit 1
fi


NODE_VERSION=$1

# if ! $NODE_VERSION; then
#     echo "$(gum style --foreground $ORANGE --bold "X ERROR!") Unable to read NODE_VERSION."
#     exit 1
# fi

# HEADER
TEXT=("CREATE AN NVMRC FILE.")
zsh $SCRIPT_DIR/../gum-ui/banner.zsh $TEXT

# add .nvmrc
touch .nvmrc
# append node version to .nvmrc
echo $NODE_VERSION > .nvmrc
# reload .zshrc to load correct node version
source ~/.zshrc


echo "$(gum style --foreground $GREEN --bold "✓ Success!") .nvmrc has been added."

# COMMIT CHANGES
git add . && git commit -m "Add .nvmrc"  && git push

echo "$(gum style --foreground $GREEN --bold "✓ Success!") Changes are committed and pushed."