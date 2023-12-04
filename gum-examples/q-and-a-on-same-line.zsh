#!/bin/zsh

BLUE=#3232ff
PINK=#cf118b
GREEN=#27d128
WHITE=#ffffff
ORANGE=#FFA500

# Ask for repository name

# printf "$(gum style --foreground $GREEN "?:") What is the name of the repo you just created?"
REPO_NAME=$(gum input --prompt "Question for you:" --placeholder "my-new-project")
# printf "$(gum style --foreground $GREEN --bold "?") What is the name of the repo you just created?"

printf "$(gum style --foreground $PINK "A: ")"
printf "${REPO_NAME} \n"
