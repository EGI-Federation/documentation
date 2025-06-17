# EGI documentation

[![Build Status](https://github.com/EGI-Federation/documentation/workflows/Build%20documentation/badge.svg)](https://github.com/EGI-Federation/documentation/actions)

[![Deploy Status](https://github.com/EGI-Federation/documentation/workflows/Deploy%20to%20GitHub%20pages/badge.svg)](https://github.com/EGI-Federation/documentation/actions)

This repository contains the source for the [EGI documentation](https://docs.egi.eu).

It is built with:

- [Hugo](https://gohugo.io/) is used to build a static site.
- The theme [docsy](https://www.docsy.dev) is used.

The static site is [deployed on GitHub Pages](https://gohugo.io/hosting-and-deployment/hosting-on-github/).

If you are interested in contributing, please check the
[Contributing Guide](https://docs.egi.eu/about/contributing/).

## Requirements

- [hugo (extended)](https://gohugo.io)
- [NodeJS](https://nodejs.org/) and [docsy](https://www.docsy.dev) theme
  dependencies:
  - postcss-cli
  - autoprefixer

These dependencies can be either installed manually or
reusing a flox environment. Please see the steps below.

### Installing dependencies manually

Hugo can be installed by following
[the official documentation](https://gohugo.io/getting-started/installing).

Hugo (extended) releases can be downloaded from
[the Hugo releases page](https://github.com/gohugoio/hugo/releases).
The recommended version for Hugo is specified under the GitHub Action in
[.github/workflows/hugo_version.txt](.github/workflows/hugo_version.txt).

To install npm+nodejs please check the
[official instructions](https://www.npmjs.com/get-npm).

Everything has been tested with Node.js 12.

The dependencies of the docsy theme can be installed as follows:

```shell
# From the root of the repository clone
npm ci
```

### Reuse the flox environment

[Flox](https://flox.dev/) is a virtual environment and package manager
all in one. We provide a flox environment in our GitHub repository
in a way that it is easier for everybody to work with the same
software dependencies and contribute to this repository.

After [installing flox](https://flox.dev/docs/install-flox/)
you can reuse the provided environment with:

```shell
# From the root of the repository clone
flox activate
# Then install docsy dependencies with
npm ci
```

### Building the site

```shell
# From the root of the repository clone
git submodule update --init --recursive --depth 1
hugo --minify
```

### Testing the site locally

```shell
# From the root of the repository clone
hugo server -D
```

The site is available locally at:
[http://localhost:1313/](http://localhost:1313/).

## Updating the themes

For ease of management, the [docsy](https://www.docsy.dev/docs/getting-started/)
theme has been cloned as a git submodule.

### Updating the theme submodule

```shell
git submodule foreach git pull
git commit themes/docsy -m 'Update theme'
```

## Deployment to the EGI organisation pages

[GitHub Actions](https://github.com/EGI-Federation/documentation/tree/main/.github/workflows) deploy a new version when a PR is merged into `main` at [https://docs.egi.eu](https://docs.egi.eu).

Previews of PRs can also be built by applying the `safe-for-preview` label to a PR
