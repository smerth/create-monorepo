#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

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

# CHOOSE WHETHER TO ADD AN APP
YES="Yes, please!"
NO="No."
echo "$(gum style --foreground $GREEN --bold "?") Do you want to add an app?"
INSTALL_APP_CHOICE=$(gum choose "$YES" "$NO")
echo $INSTALL_APP_CHOICE

while [ $INSTALL_APP_CHOICE = "Yes, please!" ]; do

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
        # If the "apps/*" string is not part of the workspaces array
        if ! jq '.workspaces | any(index("apps/*"))' $PACKAGE_JSON_FILE; then
            if ! jq '.workspaces=["packages/*", "apps/*"]' $PACKAGE_JSON_FILE >temp_data.json; then
                echo "$(gum style --foreground $ORANGE --bold "X ERROR!") It looks like there was a problem adding apps/* to workspaces key to package.json"
                exit 1
            else
                echo "$(gum style --foreground $GREEN --bold "✓ Success!") Added 'apps/*' to .workspaces key in package.json"
            fi
            # Overwrite original JSON file
            mv temp_data.json $PACKAGE_JSON_FILE
        fi

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
            # echo creating NEXT app
            # npx create-next-app@latest
            yarn create next-app

        fi
        if [ "$APP_TYPE_CHOICE" = "$REMIX" ]; then
            # INSTALL REMIX
            echo creating REMIX app
            # npx create-remix
            yarn create remix

        fi
        if [ "$APP_TYPE_CHOICE" = "$GATSBY" ]; then
            # INSTALL GATSBY
            echo creating GATSBY app
            # npx create-gatsby
            yarn create gatsby

        fi
        if [ "$APP_TYPE_CHOICE" = "$EXPO" ]; then
            # INSTALL EXPO
            echo creating EXPO app
            # npx create-expo-app
            yarn create expo-app
        fi
    fi

    # MOVE OUT OF APPS FOLDER
    cd ../

    # ASK IF USER WANTS TO INSTALL ANOTHER APP
    echo "$(gum style --foreground $GREEN --bold "?") Do you want to add another app?"
    INSTALL_APP_CHOICE=$(gum choose "$YES" "$NO")

    # # COMMIT CHANGES
    git add . && git commit -m "Added app to monorepo" && git push
    echo "$(gum style --foreground $GREEN --bold "✓ Success!") Changes are committed and pushed."

done
