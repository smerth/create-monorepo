#!/bin/zsh

FILENAME="setup-options.json"

PINK=#cf118b
GREEN=#27d128
WHITE=#ffffff
ORANGE=#FFA500

# Ask for repository name
echo "$(gum style --foreground $GREEN "?") What is the name of the repo you just created?"
REPO_NAME=$(gum input --placeholder "my-new-project")
echo $REPO_NAME
# Ask for GitHub Org name
echo "$(gum style --foreground $GREEN "?") What is the name of your GitHub Org?"
ORG_NAME=$(gum input --placeholder "supercoder")
echo $ORG_NAME
# Ask for Node version of the project
echo "$(gum style --foreground $GREEN "?") What version of node will your monorepo use?"
NODE_VERSION=$(gum input --placeholder "v18")
echo $NODE_VERSION

# Create an array to hold package names
PACKAGE_NAMES=()

json='[]'

# Collect names from user
echo "$(gum style --foreground $GREEN "?") Do you want to add packges to your monorepo?"
gum confirm
# As long as the user enters yes
while [ $? -eq 0 ]; do
    # Ask for repository name
    PACKAGE_NAME=$(gum input --placeholder "What do you want to name your package?")

    PN= echo "$json" | jq --arg n $PACKAGE_NAME '. += [$n]'

    # Add name to array of names
    PACKAGE_NAMES+=("${PACKAGE_NAME}")
    # Ask for another package name
    echo "$(gum style --foreground $GREEN "?") Do you want to add another packge to your monorepo?"
    gum confirm
done

echo "PN: ${PN}"

PACKAGES_ARRAY= jq -c -n '$ARGS.positional' --args "${PACKAGE_NAMES[@]}"
echo $PACKAGES_ARRAY

JSON_STRING=$(
    jq -n \
        --arg rn "$REPO_NAME" \
        --arg on "$ORG_NAME" \
        --arg nv "$NODE_VERSION" \
        --arg pn "$PN" \
        '{"org_name": $on, "repo_name": $rn, "node_version": $nv, "packages": [$pn], "apps": [ { "name": "next-demo", "type": "NEXT" }, { "name": "gatsby-demo", "type": "GATSBY" } ]}'
)

echo $JSON_STRING | jq --arg pp $PN '. .p: $pp'

echo $JSON_STRING | jq . >$FILENAME
