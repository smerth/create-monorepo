#!/bin/zsh

# Colors
source $script_dir/../gum-ui/colors.zsh

# Intro
zsh $script_dir/../gum-ui/banner.zsh \
    "Quick questions" \
    "    " \
    "We need some basic info about how you want to set up your monorepo."

filename="monorepo-options.json"

# Ask for repository name
echo "$(gum style --foreground $green "?:") What is the name of the $(gum style --foreground $blue "repo") you just created?"
repo_name=$(gum input --placeholder "my-new-project")
printf "$(gum style --foreground $blue "A: ")"
printf "${repo_name} \n"
echo

# CD into local repository folder
# if ! cd ./$repo_name; then
#     echo "$(gum style --foreground $orange "X ERROR!") Unable to CD into the provided project folder."
#     exit 1
# fi

cd ./$repo_name

# Report Outcome
# zsh $script_dir/../utility/outcome.zsh "$?" \
#     "Unable to cd into your local repository folder" \
#     "Working directory set"

# Ask for GitHub Org name
echo "$(gum style --foreground $green "?:") What is the name of your $(gum style --foreground $blue "GitHub Org")?"
org_name=$(gum input --placeholder "supercoder")
printf "$(gum style --foreground $blue "A: ")"
printf "${org_name} \n"
echo

# Ask for Node version of the project
echo "$(gum style --foreground $green "?:") What $(gum style --foreground $blue "Version of Node") will your monorepo use?"
node_version=$(gum input --placeholder "v18")
printf "$(gum style --foreground $blue "A: ")"
printf "${node_version} \n"
echo

# Create an array to hold package names
package_names=()

# Create an array to hold apps
apps=()

# Ask for package names
echo "$(gum style --foreground $green "?:") Do you want to add a $(gum style --foreground $blue "package") to this monorepo?"
# sleep 1

choice=$(gum choose --item.foreground 250 "Yes" "No")

while [[ "$choice" == "Yes" ]]; do

    # Ask for repository name
    package_name=$(gum input --placeholder "What do you want to name your package?")

    # Construct pacakge name
    namespaced_package_name="@${org_name}/${package_name}"

    printf "$(gum style --foreground $blue "A:") Packages will be namespaced to your organization: "
    echo $namespaced_package_name
    echo

    # Add package name to list of names
    package_names+=("${namespaced_package_name}")

    # Ask for another package name
    echo "$(gum style --foreground $green "?:") Do you want to add another $(gum style --foreground $blue "package") to this monorepo?"
    # sleep 1

    choice=$(gum choose --item.foreground 250 "Yes" "No")

    if [[ $choice == "No" ]]; then
        printf "$(gum style --foreground $blue "A: ")"
        printf "${choice} \n"
        echo
    fi

done

# Add apps to the monorepo
echo "$(gum style --foreground $green "?:") Do you want to add an $(gum style --foreground $blue "app") to this monorepo?"
# sleep 1

install_app=$(gum choose --item.foreground 250 "Yes" "No")

while [[ "$install_app" == "Yes" ]]; do

    # Ask for app type
    echo "$(gum style --foreground $green "?:") What type of $(gum style --foreground $blue "app") do you want to add to this monorepo?"
    app_choice=$(gum choose --item.foreground 250 "NEXT" "GATSBY" "EXPO")

    # Print answer
    printf "$(gum style --foreground $blue "A: ")"
    printf "${app_choice} \n"
    echo

    # Add app type name to list of app types
    apps+=("${app_choice}")

    # Ask for another app
    echo "$(gum style --foreground $green "?:") Do you want to add another $(gum style --foreground $blue "app") to this monorepo?"
    install_app=$(gum choose --item.foreground 250 "Yes" "No")

    # Print answer
    if [[ $install_app == "No" ]]; then
        printf "$(gum style --foreground $blue "A: ")"
        printf "${install_app} \n"
        echo
    fi
done

# JQ program to take a list of items and create a json array
packages_array=$(jq -c -n '$ARGS.positional' --args "${package_names[@]}")

# JQ program to take a list of items and create a json array
apps_array=$(jq -c -n '$ARGS.positional' --args "${apps[@]}")

# Create a new string with JQ
json_string=$(
    jq -n \
        --arg rn "$repo_name" \
        --arg on "$org_name" \
        --arg nv "$node_version" \
        --argjson pk "$packages_array" \
        --argjson apps "$apps_array" \
        '{"org_name": $on, "repo_name": $rn, "node_version": $nv, "packages": $pk, "apps": $apps}'
)

# Print JSON to terminal
# echo
# echo "$(gum style --foreground $green "OK!") Let's convert the $(gum style --foreground $blue $repo_name) repository into a $(gum style --foreground $blue "Lerna Yarn Monorepo") with these $(gum style --foreground $blue "options"):"
# echo
# echo $json_string | jq .
# echo

# Write JSON string to file
echo $json_string | jq . >$filename

# Commit changes
# Because this file is sourced from main script the path is from the main script file
zsh $script_dir/../utility/git-commit.zsh \
    "write responses to monorepo-option.json"
