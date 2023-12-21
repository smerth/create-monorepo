#!/bin/zsh

# Args
SCRIPT_DIR=$(dirname "$0")

# Colors
# Don't need to source colors since this scirpt is being sourced itself
# source $SCRIPT_DIR/../utility/colors.zsh

# Intro
zsh $SCRIPT_DIR/../utility/banner.zsh \
    "Get Monorepo Configuration Options"

if [[ $1 =~ ^(-of|--options-file) ]]; then
    print "$(gum style --foreground $BLUE "i INFO") Reading monorepo config from options file."

    OPTIONS_FILE="$2"

    GITHUB_ORG=$(cat ./$OPTIONS_FILE | jq -r '."github-org"')
    REPO_NAME=$(cat ./$OPTIONS_FILE | jq -r '."repo-name"')
    REPO_DESCRIPTION=$(cat ./$OPTIONS_FILE | jq -r '."repo-description"')
    NODE_VERSION=$(cat ./$OPTIONS_FILE | jq -r '."node-version"')
    PACKAGE_NAMES=$(cat ./$OPTIONS_FILE | jq '."package-names"')
    APPS=$(cat ./$OPTIONS_FILE | jq -r '."apps"')
    NPM_CONFIG=$(cat ./$OPTIONS_FILE | jq -r '."npmrc-config"')

    # print "Your monorepo will be scafolded with the following options: "
    # print "   "
    # cat ./$OPTIONS_FILE | jq .

else
    NO_OPTION_FILE=true
    # Ask for github organization name
    GITHUB_ORG_PROMPT="$(gum style --foreground $GREEN "?:") What is your GitHub $(gum style --foreground $BLUE "org name") / $(gum style --foreground $BLUE "user account name") : "
    GITHUB_ORG=$(gum input --prompt $GITHUB_ORG_PROMPT --placeholder "org/user")
    print "$GITHUB_ORG_PROMPT $GITHUB_ORG"

    # Ask for repository name
    REPO_NAME_PROMPT="$(gum style --foreground $GREEN "?:") What do you want to $(gum style --foreground $BLUE "name") your $(gum style --foreground $BLUE "repository") : "
    REPO_NAME=$(gum input --prompt $REPO_NAME_PROMPT --placeholder "repository name")
    print "$REPO_NAME_PROMPT $REPO_NAME"

    # Ask for repository description
    REPO_DESCRIPTION_PROMPT="$(gum style --foreground $GREEN "?:") Repository $(gum style --foreground $BLUE "description") $(gum style --foreground $ORANGE "(CTRL+D to finish)") : "
    print $REPO_DESCRIPTION_PROMPT
    REPO_DESCRIPTION=$(gum write --placeholder "Write a description (350 char limit) : ")
    print "$REPO_DESCRIPTION"

    # Ask for node version to be used
    NODE_VERSION_PROMPT="$(gum style --foreground $GREEN "?:") What $(gum style --foreground $BLUE "version") of Node.js would you like to use : "
    NODE_VERSION=$(gum input --prompt $NODE_VERSION_PROMPT --placeholder "v18")
    print "$NODE_VERSION_PROMPT $NODE_VERSION"

    # Do you want to add a package?
    ADD_PACKAGE_CHOICE_HEADER="$(gum style --foreground $GREEN "?:") Do you want to add a $(gum style --foreground $BLUE "package") to this monorepo"
    ADD_PACKAGE_CHOICE=$(gum choose --header $ADD_PACKAGE_CHOICE_HEADER "Yes" "No")

    # Create an array to hold package names
    PACKAGES=()

    while [[ "$ADD_PACKAGE_CHOICE" == "Yes" ]]; do
        # Ask for repository name
        PACKAGE_NAME_PROMPT="$(gum style --foreground $GREEN "?:") What's the $(gum style --foreground $BLUE "name") for your package : "
        PACKAGE_NAME=$(gum input --prompt $PACKAGE_NAME_PROMPT --placeholder "package name")
        print "$PACKAGE_NAME_PROMPT $PACKAGE_NAME"

        # Namespace the packge name
        NAMESPACED_PACKAGE_NAME="@${GITHUB_ORG}/${PACKAGE_NAME}"

        # Add package name to list of names
        PACKAGES+=("${NAMESPACED_PACKAGE_NAME}")

        # Ask for another package name
        ADD_ANOTHER_PACKAGE_CHOICE_HEADER="$(gum style --foreground $GREEN "?:") Do you want to add another $(gum style --foreground $BLUE "package") to this monorepo"
        ADD_PACKAGE_CHOICE=$(gum choose --header $ADD_ANOTHER_PACKAGE_CHOICE_HEADER "Yes" "No")

        # JQ program to take a list of items and create a json array
        PACKAGE_NAMES=$(jq -c -n '$ARGS.positional' --args "${PACKAGES[@]}")

    done

    # Add apps to the monorepo

    # Create an array to hold applications
    APPS=()

    INSTALL_APPS_CHOICE_HEADER="$(gum style --foreground $GREEN "?:") Do you want to add an $(gum style --foreground $BLUE "app") to this monorepo? : "
    INSTALL_APP_CHOICE=$(gum choose --header $INSTALL_APPS_CHOICE_HEADER --item.foreground 250 "Yes" "No")

    while [[ "$INSTALL_APP_CHOICE" == "Yes" ]]; do
        # Ask for app type
        APP_CHOICE_HEADER="$(gum style --foreground $GREEN "?:") What type of $(gum style --foreground $BLUE "app") do you want to add to this monorepo? : "
        APP_CHOICE=$(gum choose --header $APP_CHOICE_HEADER --item.foreground 250 "NEXT" "GATSBY" "EXPO")
        print "$APP_CHOICE_HEADER $APP_CHOICE"

        # Add app type name to list of app types
        APPS+=("${APP_CHOICE}")

        # Ask for another app
        INSTALL_ANOTHER_APP_CHOICE_HEADER="$(gum style --foreground $GREEN "?:") Do you want to add another $(gum style --foreground $BLUE "app") to this monorepo?"
        INSTALL_APP_CHOICE=$(gum choose --header $INSTALL_ANOTHER_APP_CHOICE_HEADER --item.foreground 250 "Yes" "No")
    done

fi
