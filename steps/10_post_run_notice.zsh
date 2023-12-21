#!/bin/zsh

#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")

# Intro
zsh $SCRIPT_DIR/../utility/banner.zsh \
    "WHAT TO DO NEXT?"

# TODO: Display an intro banner and table of follow-up steps
print "modify expo app to run in a monorepo (see the supporting info in the docs folder)"
print "    "
print "add scripts to root package.json to support your workflow"
print "    "
print "check content of all description properties in various package.json files"
print "    "
print "Edit all readmes with simple paragraph describing the package/app"
print "    "
print "check the starting versions of all packages and apps"
print "    "
print "commit the above changes"
print "    "
print "add GitHub token to .npmrc to support publishing packages to GitHub package registry"
print "    "
print "publish the first version of packages"
print "    "
print "add GitHub Actions workflows to support a multi-channel development workflow"
print "    "
