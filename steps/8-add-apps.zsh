#!/bin/zsh

# Collect args
script_dir=$(dirname "$0")
applications=$1

# Colors
source $script_dir/../gum-ui/colors.zsh

# Banner
zsh $script_dir/../gum-ui/banner.zsh \
    "Add $(gum style --foreground $BLUE "apps") to the monorepo."

# Description
echo "Call the install CLI for each of the previously specified apps."
echo

# Reload .zshrc to load correct Node version
echo
source ~/.zshrc
echo

# Add apps to the workspaces key

# Path to package.json file
json_file=package.json

# Get the index of the string "apps/*" in the array workspaces
# returns null if there is no string "apps/*"
get_array_index=$(jq -r '.workspaces | index("apps/*")' $json_file)

if (($get_array_index)); then
    print "workspaces property already contains the string 'apps/*'"
else
    # Make a temporary file
    tmpfile=$(mktemp)

    # create a jq variable to hold the string to be appended
    # append the array in the json from json_file
    # write edited json to tmpfile
    # mv tmpfile to json_file
    # delete tmpfile
    jq --arg newstr "apps/*" '.workspaces += [$newstr]' $json_file \
        >$tmpfile && mv $tmpfile $json_file && rm -f "$tmpfile"
fi

# Add an apps folder if it doesn't exist
if [ ! -d "apps" ]; then
    mkdir apps
    # Report outcome
    zsh $script_dir/../utility/outcome.zsh \
        "$?" \
        "There was a problem adding the apps directory!" \
        "The apps folder has been added to the monorepo."
else
    echo "The apps directory already exists."
    echo
fi

# CD into the apps folder
cd apps

# for a in "${applications[@]}"; do
#     echo "this is a: $a"
#     # or do whatever with individual element of the array
# done

for row in $(echo "${applications}" | jq -r '.[]'); do

    if [ $row = "NEXT" ]; then
        # Banner
        zsh $script_dir/../gum-ui/banner.zsh \
            "Add a $(gum style --foreground $BLUE "NEXT") app to the monorepo."
        # This seems to work fine
        yarn create next-app
    fi
    if [ $row = "GATSBY" ]; then
        # Banner
        zsh $script_dir/../gum-ui/banner.zsh \
            "Add a $(gum style --foreground $BLUE "GATSBY") app to the monorepo."
        # This creates a yarn install in my environment
        # But not all?
        npx gatsby options set package-manager yarn
        npx gatsby new
    fi
    if [ $row = "EXPO" ]; then
        # Banner
        zsh $script_dir/../gum-ui/banner.zsh \
            "Add a $(gum style --foreground $BLUE "EXPO") app to the monorepo."
        # TODO: test this create function
        # npx installs with npm not yarn
        # npx create-expo-app
        yarn create expo-app
    fi
done

# Remove git folders in gatby apps
# https://gist.github.com/facelordgists/80e868ff5e315878ecd6
find . \( -name ".git" -o -name ".gitignore" -o -name ".gitmodules" -o -name ".gitattributes" \) -exec rm -rf -- {} +

# Commit changes
zsh $script_dir/git-commit.zsh \
    "add apps to the monorepo"
