#!/bin/zsh

function install_app() {
    APPLICATION_TYPE=$1

    if [ $APPLICATION_TYPE = "NEXT" ]; then
        # This seems to work fine
        yarn create next-app
    fi
    if [ $APPLICATION_TYPE = "GATSBY" ]; then
        # This seems to work fine
        npx gatsby options set package-manager yarn
        npx gatsby new
        # installs a gatsby template with .git directory which must be removed
    fi
    if [ $APPLICATION_TYPE = "EXPO" ]; then
        # install succeeds
        yarn create expo-app
        # Expo requires modification to run in a monorepo
    fi
}
