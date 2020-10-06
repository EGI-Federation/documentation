---
title: "Contributing"
description: "Contributing to EGI documentation"
type: docs
weight: 30
---

Thank you for taking the time to contribute to this project.
The maintainers greatly appreciate the interest of contributors and rely on
continued engagement with the community to ensure that this project remains
useful.
We would like to take steps to put contributors in the best possible position
to have their contributions accepted.
Please take a few moments to read this short guide on how to contribute; bear
in mind that contributions regarding how to best contribute are also welcome.

## Style guide

A summary of the style guide is available at [style guide](../style/).
Be sure to follow it when proposing changes.

## Feedback and Questions

If you wish to discuss anything related to the project, please open an issue or
start a topic on the [EGI Community Forum](https://community.egi.eu).
The maintainers will sometimes move issues off of GitHub to the community forum
if it is thought that longer, more open-ended discussion would be beneficial,
including a wider community scope.

## Contribution Process

All contributions have to go through a review process, and contributions can be
made in two ways:

- for simple contribution you can contribute from your browser by clicking the
  **pencil** `Edit this file` icon shown at the top of a page that you are
  viewing (See [GitHub
  documented](https://help.github.com/en/github/managing-files-in-a-repository/editing-files-in-another-users-repository)).
  You will be guided through the required steps.
- for more complex contributions and when you want to preview and test changes
  locally you should fork the repository as documented below in the **Using
  git** section.

### Contributing via a Pull Request

Before proposing a contribution via pull request, ideally there is an open
issue describing the need for your contribution (refer to this issue number
when you submit the pull request). We have a 3 steps process for contributions.

1. Fork the project if you have not, and commit changes to a git branch.
   Documentation on building the documentation locally is available in the
   [README.md](README.md)
1. Create a GitHub Pull Request for your change, following the instructions
   in the pull request template.
1. Perform a [Code Review](#code-review-process) with the maintainers on the
   pull request.

### Pull Request Requirements

1. **Explain your contribution in plain language.** To assist the maintainers
   in understanding and appreciating your pull request, please use the
   template to explain _why_ you are making this contribution, rather than
   just _what_ the contribution entails.

### Code Review Process

Code review takes place in GitHub pull requests. See [this
article](https://help.github.com/articles/about-pull-requests/) if you're not
familiar with GitHub Pull Requests.

Once you open a pull request, maintainers will review your code using the
built-in code review process in Github PRs. The process at this point is as
follows:

1. A maintainer will review your code and merge it if no changes are necessary.
   Your change will be merged into the repository's `master` branch.
1. If a maintainer has feedback or questions on your changes then they will set
   `request changes` in the review and provide an explanation.

## Using git and GitHub

For collaboration purposes, it is best if you create a GitHub account and fork
the repository to your own account. Once you do this you will be able to push
your changes to your GitHub repository for others to see and use, and it will
be easier to send pull requests.

If you are new to `git` and **GitHub** you are advised to start by the two
following articles providing simple tutorials:

- https://opensource.com/article/18/1/step-step-guide-git
- https://opensource.com/article/19/7/create-pull-request-github

GitHub official documentation is available at https://docs.github.com/en/github.

Some documentation about the main steps for working with GitHub is also
available her after.

### Summary of the GitHub flow

In order to be able to send code update to the repository you need to:

- fork the repository to your GitHub account
- clone the repository on your local computer
- create a _feature branch_ where you will commit your changes
- push the _feature branch_ to the repository fork in your GitHub account
- open a Pull Request (PR) against the upstream repository

In this process three git repositories are used:

- The _upstream_ repository: EGI-Foundation/documentation
- Your fork, also named _origin_: <your_username>/documentation
- A local clone of your fork, containing references to your fork, its _origin_
  and to the _upstream_ repository

### Adding an SSH key to your GitHub account

The most convenient way to authenticate with GitHub is to use SSH keys over the
SSH protocol.

You can add an SSH _public_ key to your GitHub account in the `Settings` on GitHub, at
https://github.com/settings/keys.

Refer to [Connecting to GitHub with
SSH](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/connecting-to-github-with-ssh)
for an extensive documentation on using SSH keys with GitHub.

It's worth to mention that your ssh _public_ keys can easily be retrieved using
an URL like https://github.com/<your_username>.keys.

In order to manage repositories over ssh, you will will have to clone them via
SSH, not HTTPS.

If you already have a local clone of a repository created via HTTPS, you can
switch it to SSH by following [Switching remote URLs from HTTPS to
SSH](https://docs.github.com/en/free-pro-team@latest/github/using-git/changing-a-remotes-url#switching-remote-urls-from-https-to-ssh).

### Starting with the GitHub CLI

The GitHub Command Line Interface greatly helps with working with GitHub
repositories from a terminal.

It can be installed using the packages available on https://cli.github.com/.
The manual is available at https://cli.github.com/manual/.

Once installed you will have to start by setting up authentication.

```sh
# Authenticate with GitHub
gh auth login
# Favor ssh protocol
gh config set git_protocol ssh
```

### Forking the repository

The easiest way is to do it via the GitHub CLI that will also clone it locally.
But it can also be done via the web interface, using the _fork_ button and then
cloning it locally manually.

#### Forking and cloning the repository

This command will fork the repository to your GitHub account and clone a local
copy for you to work with.

```sh
gh repo fork EGI-Foundation/documentation
```

#### Cloning the repository fork created using the web interface

If you want to clone an existing fork you should use:

```sh
gh repo clone <your_username>/documentation
```

#### Verifying your local clone is ready to be used

If your local clone of you fork is correctly setup you should see references to
the origin and upstream repositories.

```sh
$ git remote -v
origin  git@github.com:<your_username>/documentation (fetch)
origin  git@github.com:<your_username>/documentation (push)
upstream        git@github.com:EGI-Foundation/documentation.git (fetch)
upstream        git@github.com:EGI-Foundation/documentation.git (push)
```

### Branches and Commits

You should submit your patch as a git branch ideally named with a meaningful
name related to the changes you want to propose.
This is called a _feature branch_ (sometimes also named _topic branch_).
You will commit your modifications to this _feature branch_ and submit a Pull
Request (PR) based on the differences between the upstream master branch and
your _feature branch_.

#### Creating a feature branch

Try to avoid committing changes to the _master_ branch of your clone to
simplify management, creating a dedicated _feature branch_ helps a lot.
Try to pick a meaningful name for the branch (my_nice_update in the example).

```sh
# This should be done from the up-to-date master branch
# Read furthermore to see documentation on updating a local clone
git checkout -b my_nice_update
```

#### Writing changes

The documentation being made of plain text files you are free to use whatever
text editor or Integrated Development Environment (IDE) suits you, from
[neovim](https://neovim.io/) to [Visual Studio
Code](https://code.visualstudio.com/).

Some environments may provide you plugins helping with syntax or offering a
preview, they are worth checking.

Be sure to commit files with a working markdown syntax and with lines cut
around 80 characters.

#### Committing changes

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

#### Pushing your feature branch to your fork for preparing a PR

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

#### Updating local feature branch with changes made on the PR

Once you PR have been opened it will be reviewed, and reviewers can propose and
commit changes to your PR.
If you need to make further changes be sure to update the local clone with the
remote changes.

```sh
# Retrieve changes made on your PR in the upstream repository
gh pull
```

Then you can commit new changes and push them to your remote fork.

### Updating a repository clone with the upstream changes

```sh
# If you are still in a branch created for a previous PR, move to master
git checkout master
# Get the latest data from the upstream repository
git fetch upstream
# Update your local copy with this data
git rebase upstream/master master
# Update your remote GiHhub fork with those changes
git push
```

### Cloning a Pull Request to test it locally

It's possible to clone a Pull Request to a local branch to test it locally.
It's done using the PR number.

```sh
# List available PR and their identifiers.
gh pr list
# Clone  specific PR
gh pr checkout XX
# You can also update your local clone
# It will ask you to merge changes
git pull
```

Then you can refer to the `README.md` to see how to test it locally.

#### Cleaning a local clone of a PR

In case you have troubles updating the local clone, as it can happens if
changes were forced pushed to it, it maybe easier to delete the local copy of
the PR and recreate it.

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

## Release cycle

Master branch is always available.
Tagged versions may be created as needed following [Semantic
Versioning](https://semver.org/) as far as applicable.

## Community

EGI benefits from a strong community of developers and system administrators,
and vice-versa. If you have any questions or if you would like to get involved
in the wider EGI community you can check out:

- [EGI Community Forum](https://community.egi.eu/)
- [EGI website](https://www.egi.eu)

**This file has been modified from the Chef Cookbook Contributing Guide**.
