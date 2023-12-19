#!/bin/zsh

# Collect args
SCRIPT_DIR=$(dirname "$0")

# Source required functions
source $SCRIPT_DIR/../utility/add_apps_to_workspaces_array.zsh
source $SCRIPT_DIR/../utility/add_apps_directory.zsh
source $SCRIPT_DIR/../utility/install_app.zsh

# Intro
zsh $SCRIPT_DIR/../gum-ui/banner.zsh \
    "Add $(gum style --foreground $BLUE "apps") to the monorepo."

# We are using command line input (no options file passed in)
if [ "$NO_OPTION_FILE" = true ]; then
    # if the user did not elect to install apps
    if [[ -z $APPS ]]; then
        print "No apps to install"
    else
        # the APPS var exists
        add_apps_to_workspaces_array
        add_apps_directory $SCRIPT_DIR
        # iterate over apps array
        for APP_TYPE in $(echo "${APPS}" | jq -r '.[]'); do
            clear
            # Banner
            zsh $SCRIPT_DIR/../gum-ui/banner.zsh \
                "Add a $(gum style --foreground $BLUE "${APP_TYPE}") app to the monorepo."
            # Install
            install_app $APP_TYPE
            # # Report outcome
            zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
                "There was a problem installing a ${APP_TYPE} app in the monorepo!" \
                "Your ${APP_TYPE} app has been created and added to the monorepo."
            # Commit changes
            zsh $SCRIPT_DIR/../utility/git-commit.zsh \
                "add apps to the monorepo"
        done
    fi
else
    # We are using the options file and it has a apps key
    if $(cat ../$OPTIONS_FILE | jq -e '. | has("apps")'); then
        # options file has apps key
        add_apps_to_workspaces_array
        add_apps_directory $SCRIPT_DIR
        # iterate over the apps array
        for APP_TYPE in $(echo "${APPS}" | jq -r '.[]'); do
            clear
            # Banner
            zsh $SCRIPT_DIR/../gum-ui/banner.zsh \
                "Add a $(gum style --foreground $BLUE "${APP_TYPE}") app to the monorepo."
            # Install
            install_app $APP_TYPE
            # # Report outcome
            zsh $SCRIPT_DIR/../utility/outcome.zsh "$?" \
                "There was a problem installing a ${APP_TYPE} app in the monorepo!" \
                "Your ${APP_TYPE} app has been created and added to the monorepo."
            # Commit changes
            zsh $SCRIPT_DIR/../utility/git-commit.zsh \
                "add apps to the monorepo"
        done
    else
        # We are using the options file but it does not contain a apps key
        print "No apps to install"
    fi
fi
