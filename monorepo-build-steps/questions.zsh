#!/bin/zsh

FILENAME="setup-options.json"

BLUE=#3232ff
PINK=#cf118b
GREEN=#27d128
WHITE=#ffffff
ORANGE=#FFA500

# Ask for repository name
echo "$(gum style --foreground $GREEN "?:") What is the name of the $(gum style --foreground $GREEN "repo") you just created?"
REPO_NAME=$(gum input --placeholder "my-new-project")
printf "$(gum style --foreground $PINK "A: ")"
printf "${REPO_NAME} \n"

# CD INTO THE REPOSITORY FOLDER
if ! cd $REPO_NAME; then
    echo "$(gum style --foreground $ORANGE --bold "X ERROR!") Unable to CD into the provided project folder."
    exit 1
fi

# Ask for GitHub Org name
echo "$(gum style --foreground $GREEN "?:") What is the name of your $(gum style --foreground $GREEN "GitHub Org")?"
ORG_NAME=$(gum input --placeholder "supercoder")
printf "$(gum style --foreground $PINK "A: ")"
printf "${ORG_NAME} \n"

# Ask for Node version of the project
echo "$(gum style --foreground $GREEN "?:") What $(gum style --foreground $GREEN "Version of Node") will your monorepo use?"
NODE_VERSION=$(gum input --placeholder "v18")
printf "$(gum style --foreground $PINK "A: ")"
printf "${NODE_VERSION} \n"

# Create an array to hold package names
PACKAGE_NAMES=()

# Create an array to hold apps
APPS=()

# Ask for package names
echo "$(gum style --foreground $GREEN "?:") Do you want to add a $(gum style --foreground $GREEN "package") to this monorepo?"
# sleep 1

CHOICE=$(gum choose --item.foreground 250 "Yes" "No")

while [[ "$CHOICE" == "Yes" ]]; do

    # Ask for repository name
    PACKAGE_NAME=$(gum input --placeholder "What do you want to name your package?")

    # Construct pacakge name
    NAMESPACED_PACKAGE_NAME="@${ORG_NAME}/${PACKAGE_NAME}"

    printf "$(gum style --foreground $BLUE --bold "i:") Packages will be namespaced to your organization: "
    echo $NAMESPACED_PACKAGE_NAME

    # Add package name to list of names
    PACKAGE_NAMES+=("${NAMESPACED_PACKAGE_NAME}")

    # Ask for another package name
    echo "$(gum style --foreground $GREEN "?:") Do you want to add another $(gum style --foreground $GREEN "package") to this monorepo?"
    # sleep 1

    CHOICE=$(gum choose --item.foreground 250 "Yes" "No")

    if [[ $CHOICE == "No" ]]; then
        printf "$(gum style --foreground $PINK "A: ")"
        printf "${CHOICE} \n"
    fi

done

# Add apps to the monorepo
echo "$(gum style --foreground $GREEN "?:") Do you want to add an $(gum style --foreground $GREEN "app") to this monorepo?"
# sleep 1

INSTALL_APP=$(gum choose --item.foreground 250 "Yes" "No")

while [[ "$INSTALL_APP" == "Yes" ]]; do

    # Ask for app type
    echo "$(gum style --foreground $GREEN "?:") What type of $(gum style --foreground $GREEN "app") do you want to add to this monorepo?"
    # sleep 1

    APP_CHOICE=$(gum choose --item.foreground 250 "NEXT" "REMIX" "GATSBY" "EXPO")

    printf "$(gum style --foreground $PINK "A: ")"
    printf "${APP_CHOICE} \n"

    # Add package name to list of names
    APPS+=("${APP_CHOICE}")

    # Ask for another app
    echo "$(gum style --foreground $GREEN "?:") Do you want to add another $(gum style --foreground $GREEN "app") to this monorepo?"
    # sleep 1

    INSTALL_APP=$(gum choose --item.foreground 250 "Yes" "No")

    if [[ $INSTALL_APP == "No" ]]; then
        printf "$(gum style --foreground $PINK "A: ")"
        printf "${CHOICE} \n"
    fi
done

# jq program to take a list of items and create a json array
PACKAGES_ARRAY=$(jq -c -n '$ARGS.positional' --args "${PACKAGE_NAMES[@]}")

# jq program to take a list of items and create a json array
APPS_ARRAY=$(jq -c -n '$ARGS.positional' --args "${APPS[@]}")

# echo $APPS_ARRAY

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

echo "$(gum style --foreground $GREEN "OK!") Let's convert the $(gum style --foreground $GREEN $REPO_NAME) repository into a $(gum style --foreground $PINK "Lerna Yarn Monorepo") with these $(gum style --foreground $GREEN "options"):"

echo

echo $JSON_STRING | jq .

echo

echo $JSON_STRING | jq . >$FILENAME
