# EGI documentation

[![Build Status](https://github.com/EGI-Federation/documentation/workflows/Build%20documentation/badge.svg)](https://github.com/EGI-Federation/documentation/actions)

[![Deploy Status](https://github.com/EGI-Federation/documentation/workflows/Deploy%20to%20GitHub%20pages/badge.svg)](https://github.com/EGI-Federation/documentation/actions)

Source files used to build [EGI documentation](https://docs.egi.eu).

- [Hugo](https://gohugo.io/) is used to build a static site.
- The theme [docsy](https://www.docsy.dev) is used.
- The static site is
  [deployed on GitHub](https://gohugo.io/hosting-and-deployment/hosting-on-github/)
  by using a dedicated
  [GitHub repository](https://github.com/EGI-Federation/EGI-Federation.github.io).

> If you are interested in contributing, please check the
> [Contributing Guide](https://docs.egi.eu/about/contributing/).

## Requirements

- [hugo (extended)](https://gohugo.io)
- [NodeJS](https://nodejs.org/) and [docsy](https://www.docsy.dev) theme
  dependencies:
  - postcss-cli
  - autoprofixer

## Installing dependencies, building and testing locally

Hugo can be installed by following
[the official documentation](https://gohugo.io/getting-started/installing).

Hugo (extended) releases can be downloaded from
[the Hugo releases page](https://github.com/gohugoio/hugo/releases).

To install npm+nodejs please check the
[official instructions](https://www.npmjs.com/get-npm).

Everything has been tested with Node.js 12.

The dependencies of the docsy theme can be installed as follows:

```shell
# From the root of the repository clone
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

## Updating the theme

For ease of management, the [docsy](https://www.docsy.dev/docs/getting-started/)
theme has been cloned as a git submodule.

### Updating the theme submodule

```shell
git submodule foreach git pull
git commit themes/docsy -m 'Update theme'
```

## Deployment to the EGI organisation pages

[GitHub Actions](https://github.com/EGI-Federation/documentation/tree/main/.github/workflows)
will automatically deploy a new version when a PR is merged into _main_. It will
then be available at [https://docs.egi.eu](https://docs.egi.eu).
