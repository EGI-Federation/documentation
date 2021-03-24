# EGI documentation

[![Build Status](https://github.com/EGI-Federation/documentation/workflows/Build%20documentation/badge.svg)](https://github.com/EGI-Federation/documentation/actions)

[![Deploy Status](https://github.com/EGI-Federation/documentation/workflows/Deploy%20to%20GitHub%20pages/badge.svg)](https://github.com/EGI-Federation/documentation/actions)

Sources files used to build [EGI documentation](https://docs.egi.eu).

- [Hugo](https://gohugo.io/) is used to build a static website.
- The theme [docsy](https://www.docsy.dev) is used.
- The static site is
  [deployed on GitHub](https://gohugo.io/hosting-and-deployment/hosting-on-github/)
  using a dedicated
  [GitHub repository](https://github.com/EGI-Federation/EGI-Federation.github.io).

> If you are interested in contributing please check the
> [Contributing Guide](https://docs.egi.eu/about/contributing/).

## Requirements

- [hugo](https://gohugo.io)
- [NodeJS](https://nodejs.org/) and other
  [docsy](https://www.docsy.dev) theme dependencies:
  - postcss-cli
  - autoprofixer

## Installing dependencies, building and testing locally

To install npm+nodejs please check the
[official instructions](https://www.npmjs.com/get-npm).

Everything has been tested with Node.js 12.

The dependencies of the docsy theme can be installed as follows:

```sh
# from the root of the repository clone
npm ci
```

The supported Hugo version is documented under the `binaries` folder.
To help testing a binary version of Hugo (extended version. Updates
can be downloaded at
[the Hugo releases page](https://github.com/gohugoio/hugo/releases).

### Building the site

```sh
# From the repository clone root
git submodule update --init --recursive --depth 1
./binaries/<platform>/hugo --minify
```

### Testing the site locally

```sh
# From the repository clone root
./binaries/<platform>/hugo server -D
```

The website is available locally at:
[http://localhost:1313/](http://localhost:1313/).

## Updating the theme

To ease management the [docsy](https://www.docsy.dev/docs/getting-started/)
theme has been cloned as a git submodule.

### Updating the theme submodule

```sh
git submodule foreach git pull
git commit themes/docsy -m 'Update theme'
```

## Deployment to the EGI organisation pages

[GitHub Actions](https://github.com/EGI-Federation/documentation/tree/master/.github/workflows)
will automatically deploy a new version when a PR is merged to master,
it will then be availalbe at [https://docs.egi.eu](https://docs.egi.eu).
