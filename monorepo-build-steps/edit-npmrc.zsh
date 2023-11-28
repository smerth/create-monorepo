cd blue-bean

GITHUB_ORG=smerth

# Add .npmrc
touch .npmrc

# Content to add to .npmrc
read -r -d '' NPMRC_CONTENT << EOM
//npm.pkg.github.com/:_authToken=TOKEN
@${GITHUB_ORG}:registry=https://npm.pkg.github.com
EOM

# Add content to .npmrc
echo $NPMRC_CONTENT > .npmrc