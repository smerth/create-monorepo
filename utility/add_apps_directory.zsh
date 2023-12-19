#!/bin/zsh

function add_apps_directory() {
    if [ ! -d "apps" ]; then
        SCRIPT_DIR=$1
        mkdir apps
        # Report outcome
        zsh $SCRIPT_DIR/../utility/outcome.zsh \
            "$?" \
            "There was a problem adding the apps directory!" \
            "The apps folder has been added to the monorepo."
    else
        echo "The apps directory already exists."
        echo
    fi
    cd apps
    pwd
}
