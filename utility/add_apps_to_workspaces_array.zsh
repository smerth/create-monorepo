#!/bin/zsh

function add_apps_to_workspaces_array() {
    # Path to package.json file
    PACKAGE_JSON=package.json
    # Get the index of the string "apps/*" in the workspaces array
    # returns null if there is no string "apps/*"
    GET_ARRAY_INDEX=$(jq -r '.workspaces | index("apps/*")' $PACKAGE_JSON)
    # if workspaces already has string
    if (($GET_ARRAY_INDEX)); then
        print "workspaces property already contains the string 'apps/*'"
    else
        # Make a temporary file
        tmpfile=$(mktemp)
        # append the apps/* string to the workspaces array in package.json
        jq --arg newstr "apps/*" '.workspaces += [$newstr]' $PACKAGE_JSON \
            >$tmpfile && mv $tmpfile $PACKAGE_JSON && rm -f "$tmpfile"
        # Report outcome
        zsh $SCRIPT_DIR/../utility/outcome.zsh \
            "$?" \
            "There was a problem adding "apps/*" string to the workspaces array" \
            "The "apps/*" string has been added to the workspaces array"
    fi
}
