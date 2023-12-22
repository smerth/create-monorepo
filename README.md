# create-monorepo

A Shell CLI to create a nodejs/lerna/yarn monorepo with any number of packages and any number of Nextjs, Gatsby or Expo apps. 



> ## N.B.
>
> Read through the code before running this script, you should know what it does.  If you spot a problem, file an issue, and if possible a pull request.
>
> While the order of operations and the scripts seem straight forward it is ultimately your responsibility to vet the code.
>
> While this script will build a standard monorepo for publishing packages and building apps using NextJS, Gatsby or Expo, there are very sophisticated and robust solutions to building a monorepo like [NX](https://nx.dev/).
>
> I use NX.  I really like it.  But sometimes I want a monorepo that is simple and straight-forward.



## Intoduction

This shell script is written for zsh shell using [gum](https://github.com/charmbracelet/gum) for a nice CLI user interface.  The script will scaffold out a monorepo with any number of packages and Nextjs, Gatsby or Expo apps.  Specifically it does the following:

- Prompts user for input regarding necessary information to scaffold a monorepo (or accepts input from an options file if provided)
- Creates a repository on GitHub and clones the repo locally
- Creates .nvmrc with the version of nodejs
- Created .npmrc with configuration for publishing packages to GitHub package regsitry
- Initiates the project with yarn (accepting defaults)
- Adds the workspaces key to the project root package.json with the `packages/*` route
- Installs lerna and initiates the project with lerna
- Adds a commands key to the lerna.json config with a publish command
- Add packages to the monorepo (one package for each name provided by the user)
- Add applications to the monorepo
- removes .git directory from apps if includes with their install templates

If you would like to look at an example of a monorepo scaffolded out using this script check out [monorepo-from-prompts](https://github.com/smerth/monorepo-from-prompts)




## Requirements

This script assumes your local environment setup includes the following:

| Requirements   | Note                                                       |
| -------------- | ---------------------------------------------------------- |
| GitHub account | this script will create a new repo on your account.        |
| zsh            | this script was tested in zsh but may work in other shells |
| gum            | to make a nice CLI experience                              |
| nvm            | nvm is used to switch between node versions                |
| node           | the monorepo is a node project                             |
| jq             | user input provided as an options file is parsed using jq  |

To run the script you will need to have GitHub CLI (gh) configured and authenticated on your machine.

To publish packages you will need a GitHub PAT which you can add as an env variable to your monorepo and pass to `.npmrc`

For a look at how to set up MacOS for web development check out [macos-setup](https://github.com/smerth/macos-setup)



## Usage



### Copy script to local folder

```shell
git clone https://github.com/smerth/create-monorepo.git
```

### Add path to the script to the $PATH variable

To check path to the script `cd` into the script folder and run `pwd`

Add the script path in `.zprofile`

```shell
echo "export PATH=$PATH:/Users/[YOUR-USER-DIRECTORY]/Developer/shell-scripts/create-monorepo" >> ~/.zprofile && source ~/.zprofile
```

### Add an alias for the script

Append an alias for the script to `.zprofile`

```shel
echo 'alias cm="create-monorepo.zsh"' >> ~/.zprofile && source ~/.zprofile
```

## Execute the script

CD into the folder you want to contain your new monorepo

```shell
cd ~/[YOUR-USER-DIRECTORY]/Developer/github-repositories/
```

Call the script

```shell
cm
```

The script will run through some questions to get necessary input.

### Provide options in a file

If you would prefer to provide options in a json file you can pass an options file to the script

```shell
cm --options-file my-options-file.json
```

your options file must be formatted as follows

```json
{
  "github-org": "YOUR-USER-ACCOUNT",
  "repo-name": "WHAT-DOYOU-WANT-TO-NAME-YOUR-NEW-REPO",
  "repo-description": "this description will be used for the repo descrition on GitHub and the initial repo README.md",
  "node-version": "v18",
  "package-names": ["@YOUR-USER-ACCOUNT/PACKAGE-NAME-ONE", "@YOUR-USER-ACCOUNT/PACKAGE-NAME-TWO"],
  "apps": ["GATSBY", "NEXT", "EXPO"],
  "npmrc-config": [
    "//npm.pkg.github.com/:_authToken=TOKEN",
    "@YOUR-USER-ACCOUNT:registry=https://npm.pkg.github.com"
  ],
  "command": {
    "publish": {
      "conventionalCommits": true,
      "message": "chore(release): publish",
      "registry": "https://npm.pkg.github.com",
      "allowBranch": ["main", "next", "feature/*"]
    }
  }
}
```



## Gotchas

### Expo apps

Expo apps require further configuration to work in a monorepo.  This is not difficult just follow the document in the `docs` folder of this script



## Working with your new monorepo

Here are some next steps to consider:

- modify expo app to run in a monorepo (see the supporting info in the docs folder)

- add scripts to root package.json to support your workflow

- check content of all description properties in various package.json files

- Edit all readmes with simple paragraph describing the package/app

- check the starting versions of all packages and apps

- commit the above changes

- add GitHub token to .npmrc to support publishing packages to GitHub package registry

- publish the first version of packages

- add GitHub Actions workflows to support a multi-channel development workflow



## References

Here is a nice summary article about building a monorepo: [publishing and installing private github packages using yarn and lerna](https://viewsource.io/publishing-and-installing-private-github-packages-using-yarn-and-lerna/)
