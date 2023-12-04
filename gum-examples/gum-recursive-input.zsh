#!/bin/zsh

PACKAGE_NAMES=()

gum confirm "Add a package to your monorepo?"

# if [ $? -eq 0 ]; then
#   echo "Adding a package"
# else
#   echo "Moving to next step"
# fi
# ADD_ANOTHER_PACKAGE=0


# As long as the output from confirm is truthy
while [ $? -eq 0 ]; do
    # Ask for repository name
    PACKAGE_NAME=$(gum input --placeholder "What do you want to name your package?")
    # Add name to array of names
    PACKAGE_NAMES+="${PACKAGE_NAME}"
    # Ask for another package name
    gum confirm "Add another package to your monorepo?"
done

# Loop through array
for str in ${PACKAGE_NAMES[@]}; do
  echo $str
done

