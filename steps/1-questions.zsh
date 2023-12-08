#!/bin/zsh

# Colors
# Because this file is sourced from main script the path is from the main script file
source $SCRIPT_DIR/gum-ui/colors.zsh

# Banner
gum style --border normal --margin "1" --padding "2 2" --border-foreground $WHITE "Gather some useful $(gum style --foreground $BLUE 'options')."

# Description
echo "We will use the answers to these $(gum style --foreground $BLUE "questions") to convert your new repo into a monorepo with packages and apps."
echo

FILENAME="monorepo-options.json"

# Ask for repository name
echo "$(gum style --foreground $GREEN "?:") What is the name of the $(gum style --foreground $BLUE "repo") you just created?"
REPO_NAME=$(gum input --placeholder "my-new-project")
printf "$(gum style --foreground $BLUE "A: ")"
printf "${REPO_NAME} \n"
echo

# CD into local repository folder
if ! cd ./$REPO_NAME; then
    echo "$(gum style --foreground $ORANGE "X ERROR!") Unable to CD into the provided project folder."
    exit 1
fi

# Ask for GitHub Org name
echo "$(gum style --foreground $GREEN "?:") What is the name of your $(gum style --foreground $BLUE "GitHub Org")?"
ORG_NAME=$(gum input --placeholder "supercoder")
printf "$(gum style --foreground $BLUE "A: ")"
printf "${ORG_NAME} \n"
echo

# Ask for Node version of the project
echo "$(gum style --foreground $GREEN "?:") What $(gum style --foreground $BLUE "Version of Node") will your monorepo use?"
NODE_VERSION=$(gum input --placeholder "v18")
printf "$(gum style --foreground $BLUE "A: ")"
printf "${NODE_VERSION} \n"
echo

# Create an array to hold package names
PACKAGE_NAMES=()

# Create an array to hold apps
APPS=()

# Ask for package names
echo "$(gum style --foreground $GREEN "?:") Do you want to add a $(gum style --foreground $BLUE "package") to this monorepo?"
# sleep 1

CHOICE=$(gum choose --item.foreground 250 "Yes" "No")

while [[ "$CHOICE" == "Yes" ]]; do

    # Ask for repository name
    PACKAGE_NAME=$(gum input --placeholder "What do you want to name your package?")

    # Construct pacakge name
    NAMESPACED_PACKAGE_NAME="@${ORG_NAME}/${PACKAGE_NAME}"

    printf "$(gum style --foreground $BLUE "A:") Packages will be namespaced to your organization: "
    echo $NAMESPACED_PACKAGE_NAME
    echo

    # Add package name to list of names
    PACKAGE_NAMES+=("${NAMESPACED_PACKAGE_NAME}")

    # Ask for another package name
    echo "$(gum style --foreground $GREEN "?:") Do you want to add another $(gum style --foreground $BLUE "package") to this monorepo?"
    # sleep 1

    CHOICE=$(gum choose --item.foreground 250 "Yes" "No")

    if [[ $CHOICE == "No" ]]; then
        printf "$(gum style --foreground $BLUE "A: ")"
        printf "${CHOICE} \n"
        echo
    fi

done

# Add apps to the monorepo
echo "$(gum style --foreground $GREEN "?:") Do you want to add an $(gum style --foreground $BLUE "app") to this monorepo?"
# sleep 1

INSTALL_APP=$(gum choose --item.foreground 250 "Yes" "No")

while [[ "$INSTALL_APP" == "Yes" ]]; do

    # Ask for app type
    echo "$(gum style --foreground $GREEN "?:") What type of $(gum style --foreground $BLUE "app") do you want to add to this monorepo?"
    APP_CHOICE=$(gum choose --item.foreground 250 "NEXT" "REMIX" "GATSBY" "EXPO")

    # Print answer
    printf "$(gum style --foreground $BLUE "A: ")"
    printf "${APP_CHOICE} \n"
    echo

    # Add app type name to list of app types
    APPS+=("${APP_CHOICE}")

    # Ask for another app
    echo "$(gum style --foreground $GREEN "?:") Do you want to add another $(gum style --foreground $BLUE "app") to this monorepo?"
    INSTALL_APP=$(gum choose --item.foreground 250 "Yes" "No")

    # Print answer
    if [[ $INSTALL_APP == "No" ]]; then
        printf "$(gum style --foreground $BLUE "A: ")"
        printf "${CHOICE} \n"
        echo
    fi
done

# JQ program to take a list of items and create a json array
PACKAGES_ARRAY=$(jq -c -n '$ARGS.positional' --args "${PACKAGE_NAMES[@]}")

# JQ program to take a list of items and create a json array
APPS_ARRAY=$(jq -c -n '$ARGS.positional' --args "${APPS[@]}")

# Create a new string with JQ
JSON_STRING=$(
    jq -n \
        --arg rn "$REPO_NAME" \
        --arg on "$ORG_NAME" \
        --arg nv "$NODE_VERSION" \
        --argjson pk "$PACKAGES_ARRAY" \
        --argjson apps "$APPS_ARRAY" \
        '{"org_name": $on, "repo_name": $rn, "node_version": $nv, "packages": $pk, "apps": $apps}'
)

echo

echo "$(gum style --foreground $GREEN "OK!") Let's convert the $(gum style --foreground $BLUE $REPO_NAME) repository into a $(gum style --foreground $BLUE "Lerna Yarn Monorepo") with these $(gum style --foreground $BLUE "options"):"

echo

echo $JSON_STRING | jq .

echo

# Write json string to file
echo $JSON_STRING | jq . >$FILENAME

# Commit changes
# Because this file is sourced from main script the path is from the main script file
zsh $SCRIPT_DIR/steps/git-commit.zsh "write responses to monorepo-option.json"
