---
title: "Git and GitHub"
description: "First steps with Git and GitHub"
type: docs
weight: 10
---

For collaboration purposes, it is best if you create a GitHub account and fork
the repository to your own account. Once you do this, you will be able to push
your changes to your GitHub repository for others to see and use, and you will
be able to create pull requests (PRs) in the official EGI documentation
repository based on branches in your fork.

If you are new to `git` and **GitHub** you are advised to start by the two
following articles providing simple tutorials:

- [Step by step guide to git](https://opensource.com/article/18/1/step-step-guide-git)
- [Creating pull request with GitHub](https://opensource.com/article/19/7/create-pull-request-github)

GitHub official documentation is available at
[docs.github.com](https://docs.github.com/en/).

{{% alert title="Tip" color="info" %}} The
[first-contributions](https://github.com/firstcontributions/first-contributions)
is a repository allowing anyone to freely learn and test creating a real Pull
Request to an existing GitHub repository. {{% /alert %}}

Additional documentation about the main steps for working with GitHub is also
available in this section.

## The GitHub contribution flow

In order to be able to send code update to the repository you need to:

- fork the repository to your GitHub account
- clone the repository on your local computer
- create a _feature branch_ where you will commit your changes
- push the _feature branch_ to the repository fork in your GitHub account
- open a Pull Request against the upstream repository

In this process three git repositories are used:

- The _upstream_ repository: EGI-Federation/documentation
- Your fork, also named _origin_: <your_username>/documentation
- A local clone of your fork, containing references to your fork, its _origin_
  and to the _upstream_ repository

## Add an SSH key to your GitHub account

The most convenient way to authenticate with GitHub is to use SSH keys over the
SSH protocol.

You can add an SSH _public_ key to your GitHub account in the `Settings` on
GitHub, at [https://github.com/settings/keys](https://github.com/settings/keys).

Refer to
[Connecting to GitHub with SSH](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/connecting-to-github-with-ssh)
for an extensive documentation on using SSH keys with GitHub.

It's worth to mention that your ssh _public_ keys can easily be retrieved using
a URL like `https://github.com/<your_username>.keys`.

In order to manage repositories over ssh, you will have to clone them via
SSH, not HTTPS.

If you already have a local clone of a repository created via HTTPS, you can
switch it to SSH by following
[Switching remote URLs from HTTPS to SSH](https://docs.github.com/en/free-pro-team@latest/github/using-git/changing-a-remotes-url#switching-remote-urls-from-https-to-ssh).

## Starting with the GitHub CLI

The GitHub command-line interface greatly helps with working with GitHub
repositories from a terminal.

It can be installed using the packages available on
[their homepage](https://cli.github.com/). There is also a
[manual](https://cli.github.com/manual/).

Once installed you will have to start by setting up authentication.

```shell
# Authenticate with GitHub, favor SSH protocol
$ gh auth login
$ gh config set git_protocol ssh
```

## Working with repositories

The easiest way is to do it via the GitHub CLI that will also clone it locally.
But it can also be done via the web interface, using the _fork_ button and then
cloning it locally manually.

### Fork and clone

This command will fork the repository to your GitHub account and clone a local
copy for you to work with.

```shell
$ gh repo fork EGI-Federation/documentation
```

### Clone existing fork

If you want to clone an existing fork you should use:

```shell
$ gh repo clone <your_username>/documentation
```

### Validate the local clone

If your local clone of you fork is correctly setup you should see references to
the origin and upstream repositories.

```shell
$ git remote -v
origin  git@github.com:<your_username>/documentation (fetch)
origin  git@github.com:<your_username>/documentation (push)
upstream        git@github.com:EGI-Federation/documentation.git (fetch)
upstream        git@github.com:EGI-Federation/documentation.git (push)
```

## Run the site locally

The documentation site is built from the source files using
[Hugo](https://gohugo.io/). The repository
[README](https://github.com/EGI-Federation/documentation/blob/main/README.md)
can be used as a reference for building instructions.

### Requirements

- [Hugo](https://gohugo.io)
- [Node.js](https://nodejs.org/) and other [docsy](https://www.docsy.dev) theme
  dependencies:
  - postcss-cli
  - autoprofixer

### Installing dependencies

To install npm+Node.js please check the
[official instructions](https://www.npmjs.com/get-npm).

Everything has been tested with Node.js 12.

The dependencies of the docsy theme can be installed as follows:

```shell
# From the root of the repository clone
$ npm ci
```

Hugo can be installed following
[the official documentation](https://gohugo.io/getting-started/installing).

Hugo (extended) releases can be downloaded at
[the Hugo releases page](https://github.com/gohugoio/hugo/releases).

### Building the site

To build and run the site, from the repository root:

```shell
$ git submodule update --init --recursive --depth 1
$ hugo --minify
```

### Testing the site locally

To launch the site locally, from the repository root:

```shell
$ hugo serve -D
```

The site is available locally at:
[http://localhost:1313/](http://localhost:1313/).

## Branches and commits

You should submit your patch as a git branch ideally named with a meaningful
name related to the changes you want to propose. This is called a _feature
branch_ (sometimes also named _topic branch_). You will commit your
modifications to this _feature branch_ and submit a Pull Request (PR) based on
the differences between the upstream main branch and your _feature branch_.

### Create a feature branch

Try to avoid committing changes to the _main_ branch of your clone to simplify
management, creating a dedicated _feature branch_ helps a lot. Try to pick a
meaningful name for the branch (my_nice_update in the example).

```shell
# This should be done from the up-to-date main branch
# Read furthermore to see documentation on updating a local clone
$ git checkout -b my_nice_update
```

## Write changes

The documentation being made of plain text files you are free to use whatever
text editor or Integrated Development Environment (IDE) suits you, from
[neovim](https://neovim.io/) to
[Visual Studio Code](https://code.visualstudio.com/).

Some environments may provide you plugins helping with syntax or offering a
preview, they are worth checking.

Be sure to commit files with having been formated using
[Prettier](https://prettier.io/) as documented in our [style guide](../style/).

## Commit changes

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

```shell
# Select the modified files to be committed
$ git add files1 path2/
# Commit the changes
$ git commit -m <commit_message>
```

## Push feature branch to the fork in preparation of a PR

From inside a feature branch you can push it to your remote fork.

```shell
# Ask git to keep trace of the link between local and remote branches
$ git push --set-upstream
```

Once done, the output will show a URL that you can click to generate a Pull
Request (PR). Accessing GitHub upstream of forked repositories may also propose
you to submit a PR.

If needed GitHub CLI can also be used to prepare the PR:

```shell
$ gh pr create <your_username>:<feature_branch> --web
```

### Previewing a pull request

If a repository maintainer adds the label `safe for preview` to a pull request
it will be possible to preview it using a pull request-specific URL:
`https://docs.egi.eu/documentation/[PR_NUMBER]`

The preview can be used as an alternative to testing a pull request locally, and
the preview can easily be shared with other contributors.

Only collaborators having write permission to the repository are able to mark a
pull request as safe for review.

> This should be carefully considered, especially for external and first time
> contributors.

### Update local feature branch with changes made on the PR

Once you PR have been opened it will be reviewed, and reviewers can propose and
commit changes to your PR. If you need to make further changes be sure to update
the local clone with the remote changes.

```shell
# Retrieve changes made on your PR in the upstream repository
$ git pull
```

Then you can commit new changes and push them to your remote fork.

## Update repository clone with the upstream changes

```shell
# If you are still in a branch created for a previous PR, move to main
$ git checkout main
# Get the latest data from the upstream repository
$ git fetch upstream
# Update your local copy with this data
$ git rebase upstream/main main
# Update your remote GitHub fork with those changes
$ git push
```

## Update local feature branch with changes made on the main branch

In case the _main_ branch evolved since the feature branch was created, it may
be required to merge the new changes in the feature branch.

It can easily be done via the PR page on the GitHub web interface, but it can
also be done in your repository clone using `git rebase`.

```shell
# Retrieve changes made in the upstream repository
$ git fetch upstream
# Check out the feature branch
$ git checkout feature_branch
# Apply the new changes on main to your feature branch
$ git rebase upstream/main
```

In case some files have been changed on both sides you will have to merge
the conflicts manually.

## Clone PR to edit/test/review locally

It's possible to clone a Pull Request to a local branch to test it locally. It's
done using the PR number.

```shell
# List available PR and their identifiers.
$ gh pr list
# Clone  specific PR, updating sudmodules
$ gh pr checkout XX --recurse-submodules
```

Once done it's possible to build and run the site locally:

```shell
# From the root of the repository clone
# Here on MacOS X, adapt depending on your platform
$ hugo serve -D
```

The documentation will then be accessible on
[http://localhost:1313](http://localhost:1313).

> People having write access to the repository hosting the branch related to the
> PR (ie. usually the PR author) will be able to add and edit files.

```shell
# From the local clone of the repository
$ gh pr checkout XXX --recurse-submodules
$ vim yyy.zz
$ git add yyy.zz
$ git commit yyy.zz -m <commit_message>
$ git push
```

### Update a local clone of a PR

```shell
# It will ask you to merge changes
$ git pull
```

Then you can refer to the `README.md` to see how to test it locally.

In case the PR got commits that were forced pushed you may have troubles, in
that case it may be easier to
[delete the local branch](#clean-a-local-clone-of-a-pr) and do another
[checkout of the PR](#clone-pr-to-edittestreview-locally).

### Clean a local clone of a PR

In case you have troubles updating the local clone, as it can happens if changes
were forced pushed to it, it maybe easier to delete the local copy of the PR and
recreate it.

```shell
# Switch to main branch
$ git checkout main
# Check local branches
$ git branch -vv
# Delete a specific branch
$ git branch -d <branch_name>
# If you need to force the deletion use -D
$ git branch -D <branch_name>
```

## Using stashes

Sometimes we realise just before committing a change that we are not in the
correct branch (ie. that we forgot to create a dedicated feature branch), when
this happens `git stash` can be helpful.

```shell
# Saving a change
$ git stash save <optional message>
# Creating the forgotten branch
$ git checkout -b <my_feature_branch>
# Reviewing the saved changes, use TAB completion
$ git stash show <TAB>
# Applying the saved changes, use TAB completion
$ git stash pop <TAB>
# Review the changes to be committed
$ git diff
```

If you already committed your change(s) you may have to look at `git reset`.

```shell
# Viewing the diff of the two last commits
$ git log -n 2 -p
# Reverting the last change, keeping the change in the local directory
$ git reset HEAD^
```
