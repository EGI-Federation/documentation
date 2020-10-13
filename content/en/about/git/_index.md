---
title: "Using Git and GitHub"
description: "First steps with Git and GitHub"
type: docs
weight: 50
---

For collaboration purposes, it is best if you create a GitHub account and fork
the repository to your own account. Once you do this you will be able to push
your changes to your GitHub repository for others to see and use, and it will be
easier to send pull requests.

If you are new to `git` and **GitHub** you are advised to start by the two
following articles providing simple tutorials:

- https://opensource.com/article/18/1/step-step-guide-git
- https://opensource.com/article/19/7/create-pull-request-github

GitHub official documentation is available at https://docs.github.com/en/github.

Some documentation about the main steps for working with GitHub is also
available her after.

## Summary of the GitHub flow

In order to be able to send code update to the repository you need to:

- fork the repository to your GitHub account
- clone the repository on your local computer
- create a _feature branch_ where you will commit your changes
- push the _feature branch_ to the repository fork in your GitHub account
- open a Pull Request against the upstream repository

In this process three git repositories are used:

- The _upstream_ repository: EGI-Foundation/documentation
- Your fork, also named _origin_: <your_username>/documentation
- A local clone of your fork, containing references to your fork, its _origin_
  and to the _upstream_ repository

## Adding an SSH key to your GitHub account

The most convenient way to authenticate with GitHub is to use SSH keys over the
SSH protocol.

You can add an SSH _public_ key to your GitHub account in the `Settings` on
GitHub, at https://github.com/settings/keys.

Refer to
[Connecting to GitHub with SSH](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/connecting-to-github-with-ssh)
for an extensive documentation on using SSH keys with GitHub.

It's worth to mention that your ssh _public_ keys can easily be retrieved using
an URL like https://github.com/<your_username>.keys.

In order to manage repositories over ssh, you will will have to clone them via
SSH, not HTTPS.

If you already have a local clone of a repository created via HTTPS, you can
switch it to SSH by following
[Switching remote URLs from HTTPS to SSH](https://docs.github.com/en/free-pro-team@latest/github/using-git/changing-a-remotes-url#switching-remote-urls-from-https-to-ssh).

## Starting with the GitHub CLI

The GitHub Command Line Interface greatly helps with working with GitHub
repositories from a terminal.

It can be installed using the packages available on https://cli.github.com/. The
manual is available at https://cli.github.com/manual/.

Once installed you will have to start by setting up authentication.

```sh
# Authenticate with GitHub
gh auth login
# Favor ssh protocol
gh config set git_protocol ssh
```

## Forking the repository

The easiest way is to do it via the GitHub CLI that will also clone it locally.
But it can also be done via the web interface, using the _fork_ button and then
cloning it locally manually.

### Forking and cloning the repository

This command will fork the repository to your GitHub account and clone a local
copy for you to work with.

```sh
gh repo fork EGI-Foundation/documentation
```

### Cloning the repository fork created using the web interface

If you want to clone an existing fork you should use:

```sh
gh repo clone <your_username>/documentation
```

### Verifying your local clone is ready to be used

If your local clone of you fork is correctly setup you should see references to
the origin and upstream repositories.

```sh
$ git remote -v
origin  git@github.com:<your_username>/documentation (fetch)
origin  git@github.com:<your_username>/documentation (push)
upstream        git@github.com:EGI-Foundation/documentation.git (fetch)
upstream        git@github.com:EGI-Foundation/documentation.git (push)
```

## Running the documentation site locally

The documentation webiste is built from the source files using
[Hugo](https://gohugo.io/).
The repository
[README](https://github.com/EGI-Foundation/documentation/blob/master/README.md)
can be used as a reference for building instructions.

### Requirements

- mdl
- hugo
- NodeJS
  - postcss-cli
  - autoprofixer

### Installing dependencies, building and testing

To install npm+nodejs please check the instructions at:
[https://www.npmjs.com/get-npm](https://www.npmjs.com/get-npm)

The rest of the tools can be installed as follows:

```sh
gem install mdl
npm install postcss-cli@7.1.2
npm install autoprefixer@9.0
```

The supported Hugo version packages are available under the `binaries` folder.

To build and run the site, from the repository root

```sh
git submodule update --init --recursive --depth 1
mdl -s relaxed -s style.rb -r ~MD002,~MD024 content/
# Pick the repository specific to your platform
./binaries/<platform>/hugo server -D
```

The website is available at: [http://localhost:1313/](http://localhost:1313/).

## Branches and Commits

You should submit your patch as a git branch ideally named with a meaningful
name related to the changes you want to propose. This is called a _feature
branch_ (sometimes also named _topic branch_). You will commit your
modifications to this _feature branch_ and submit a Pull Request (PR) based on
the differences between the upstream master branch and your _feature branch_.

### Creating a feature branch

Try to avoid committing changes to the _master_ branch of your clone to simplify
management, creating a dedicated _feature branch_ helps a lot. Try to pick a
meaningful name for the branch (my_nice_update in the example).

```sh
# This should be done from the up-to-date master branch
# Read furthermore to see documentation on updating a local clone
git checkout -b my_nice_update
```

### Writing changes

The documentation being made of plain text files you are free to use whatever
text editor or Integrated Development Environment (IDE) suits you, from
[neovim](https://neovim.io/) to
[Visual Studio Code](https://code.visualstudio.com/).

Some environments may provide you plugins helping with syntax or offering a
preview, they are worth checking.

Be sure to commit files with having been formated using
[Prettier](https://prettier.io/) as documented in our [style guide](../style/).

### Committing changes

It is the best practice to have your commit message have a _summary line_ that
includes the issue number, followed by an empty line and then a brief
description of the commit. This also helps other contributors understand the
purpose of changes to the code.

```text
    #3 - platform_family and style

    * use platform_family for platform checking
    * update notifies syntax to "resource_type[resource_name]" instead of
      resources() lookup
    * GH-692 - delete config files dropped off by packages in conf.d
    * dropped debian 4 support because all other platforms have the same
      values, and it is older than "old stable" debian release
```

```sh
# Select the modified files to be committed
git add files1 path2/
# Commit the changes
git commit -m <commit_message>
```

### Pushing your feature branch to your fork for preparing a PR

From inside a feature branch you can push it to your remote fork.

```sh
# Ask git to keep trace of the link between local and remote branches
git push --set-upstream
```

Once done `git` output will show a URL that you can click to generate a Pull
Request (PR).

Accessing GitHub upstream or fork repositories may also propose you to submit a
PR.

If needed GitHub CLI can also be used to prepare the PR:

```sh
gh pr create <your_username>:<feature_branch> --web
```

### Updating local feature branch with changes made on the PR

Once you PR have been opened it will be reviewed, and reviewers can propose and
commit changes to your PR. If you need to make further changes be sure to update
the local clone with the remote changes.

```sh
# Retrieve changes made on your PR in the upstream repository
gh pull
```

Then you can commit new changes and push them to your remote fork.

## Updating a repository clone with the upstream changes

```sh
# If you are still in a branch created for a previous PR, move to master
git checkout master
# Get the latest data from the upstream repository
git fetch upstream
# Update your local copy with this data
git rebase upstream/master master
# Update your remote GitHub fork with those changes
git push
```

## Cloning a Pull Request to test and review it locally

It's possible to clone a Pull Request to a local branch to test it locally. It's
done using the PR number.

```sh
# List available PR and their identifiers.
gh pr list
# Clone  specific PR
gh pr checkout XX
```

Once done it's possible to build and run the site locally:

```sh
# For Mac OS X
./binaries/macos64/hugo server -D
```

The documentation will then be accessible on
[http://localhost:1313](http://localhost:1313).

### Updating a local clone of a PR

```sh
# It will ask you to merge changes
git pull
```

Then you can refer to the `README.md` to see how to test it locally.

In case the PR got commits that were forced pushed you may have troubles, in
that case it may be easier to
[delete the local branch](#cleaning-a-local-clone-of-a-pr) and do another
[checkout of the PR](#cloning-a-pull-request-to-test-and-review-it-locally).

### Cleaning a local clone of a PR

In case you have troubles updating the local clone, as it can happens if changes
were forced pushed to it, it maybe easier to delete the local copy of the PR and
recreate it.

```sh
# Switch to main branch
git checkout master
# Check local branches
git branch -vv
# Delete a specific branch
git branch -d <branch_name>
# If you need to force the deletion use -D
git branch -D <branch_name>
```
