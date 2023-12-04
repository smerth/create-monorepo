#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# REQUIRED! pass in GITHUB_ORG as first arg
# GITHUB_ORG=$1

# COLORS
PINK=#cf118b
GREEN=#27d128
WHITE=#ffffff
ORANGE=#FFA500

# ADD APPS
TEXT=("ADD APPS TO THE MONOREPO")
zsh $SCRIPT_DIR/../gum-ui/banner.zsh $TEXT

# DESCRIPTION
TEXT="Add one or more apps to an 'apps' folder and append the '.workspaces' key in package.json with 'apps/*' to let lerna know that this monorepo contains workspaces in the apps folder.  You can choose from NEXT, REMIX, GATSBY or EXPO. Once the first app is installed, choose to add another app until all the apps you need are installed."
zsh $SCRIPT_DIR/../gum-ui/text.zsh $TEXT banner

# Create an array to hold package names
APP_OPTIONS=()

# Collect names from user
# gum confirm "Add a app to your monorepo?"

################
# If yes add the apps workspace to the package.json for repo
################

# As long as the user enters yes
# while [ $? -eq 0 ]; do
#     # Ask for app type

#     # gum option picker
#     # next, remix, expo, gatsby

#     # npx create-next-app@latest
#     # npx create-remix
#     # npx create-gatsby
#     # npx create-expo-app

#     TYPE=$(gum choose "NEXT" "REMIX" "GATSBY" "EXPO")
#     # SCOPE=$(gum input --placeholder "scope")

#     echo $TYPE

#     # PACKAGE_NAME=$(gum input --placeholder "What do you want to name your package?")
#     # PACKAGE_NAME=$(gum input --placeholder "What do you want to name your package?")
#     # Add name to array of names
#     # PACKAGE_NAMES+="${PACKAGE_NAME}"
#     # Ask for another package name
#     gum confirm "Add another app to your monorepo?"
# done

# Loop through array
# for PKG_NAME in ${PACKAGE_NAMES[@]}; do
#     # echo "@${GITHUB_ORG}/${PKG_NAME}"

#     if ! lerna create "@${GITHUB_ORG}/${PKG_NAME}" packages --yes; then
#         echo "$(gum style --foreground $ORANGE --bold "X ERROR!") It looks like there was a problem creating a package."
#         exit 1
#         else
#         echo "$(gum style --foreground $GREEN --bold "✓ Success!") Your package @${GITHUB_ORG}/${PKG_NAME} has been created."
#     fi

#     # create package with name-spaced package name
#     # lerna create "@${GITHUB_ORG}/${PKG_NAME}" packages --yes

#     # If packages are created manually you need to initiate each one.
#     # cd into package
#     # yarn init
#     # cd out
# done

# CHOOSE WHETHER TO ADD AN APP
YES="Yes, please!"
NO="Not necessary."
echo "$(gum style --foreground $GREEN --bold "?") Do you want to add an app?"
INSTALL_APP_CHOICE=$(gum choose "$YES" "$NO")
echo $INSTALL_APP_CHOICE

# CHOOSE WHICH APP TO ADD
NEXT="Next"
REMIX="Remix"
GATSBY="Gatsby"
EXPO="Expo"

echo "$(gum style --foreground $GREEN --bold "?") Which app would you like to install?"
APP_TYPE_CHOICE=$(gum choose "$NEXT" "$REMIX" "$GATSBY" "$EXPO")
echo $APP_TYPE_CHOICE

# IF THE USER WANTS TO INSTALL AN APP
if [ "$INSTALL_APP_CHOICE" = "$YES" ]; then
    # ADD APPS TO THE PACKAGE.JSON WORKSPACE KEY
    PACKAGE_JSON_FILE=package.json
    # TODO: should append workspaces array not write over it
    if ! jq '.workspaces=["packages/*", "apps/*"]' $PACKAGE_JSON_FILE >temp_data.json; then
        echo "$(gum style --foreground $ORANGE --bold "X ERROR!") It looks like there was a problem adding apps/* to workspaces key to package.json"
        exit 1
    else
        echo "$(gum style --foreground $GREEN --bold "✓ Success!") Added 'apps/*' to .workspaces key in package.json"
    fi
    # Overwrite original JSON file
    mv temp_data.json $PACKAGE_JSON_FILE

    # ADD AN APPS FOLDER IF IT DOESN'T EXIST
    if [ ! -d "apps" ]; then
        # ADD AN APPS FOLDER
        mkdir apps
    fi
    # MOVE INTO THE APPS FOLDER
    cd apps

    # INSTALL USER CHOICE OF APP
    if [ "$APP_TYPE_CHOICE" = "$NEXT" ]; then
        # INSTALL NEXT
        echo creating NEXT app
        # npx create-next-app@latest
        # yarn create next-app

    fi
    if [ "$APP_TYPE_CHOICE" = "$REMIX" ]; then
        # INSTALL REMIX
        echo creating REMIX app
        # npx create-remix
    fi
    if [ "$APP_TYPE_CHOICE" = "$GATSBY" ]; then
        # INSTALL GATSBY
        echo creating GATSBY app
        # npx create-gatsby
    fi
    if [ "$APP_TYPE_CHOICE" = "$EXPO" ]; then
        # INSTALL EXPO
        echo creating EXPO app
        # npx create-expo-app
    fi
    # ASK FOR ANOTHER APP INSTALL
    echo "$(gum style --foreground $GREEN --bold "?") Do you want to add another app?"
    INSTALL_APP_CHOICE=$(gum choose "$YES" "$NO")
fi

# COMMIT CHANGES
# git add . && git commit -m "Created projects with lerna create"  && git push

# echo "$(gum style --foreground $GREEN --bold "✓ Success!") Changes are committed and pushed."
