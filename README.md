# EGI documentation

[![Build Status](https://travis-ci.org/EGI-Foundation/documentation.svg?branch=master)](https://travis-ci.org/EGI-Foundation/documentation)

Sources to build [EGI documentation static pages](https://egi-foundation.github.io/).

* [Hugo](https://gohugo.io/) is used to build a static website.
* The theme [docdock](https://docdock.netlify.com/) is used.
* The static site is [deployed on GitHub](https://gohugo.io/hosting-and-deployment/hosting-on-github/) using a
  dedicated [GitHub repository](https://github.com/EGI-Foundation/EGI-Foundation.github.io).

## Usage

Please refer to [Hugo documentation](https://gohugo.io/documentation/) and
[docdock theme documentation](https://docdock.netlify.com/).

### Updating the theme

To keep complete control over the [docdock](https://docdock.netlify.com/) theme it was
decided to use a snapshot of its master branch.

### Testing locally

```console
hugo server -D
```

The website is available locally at: http://localhost:1313/

### Deploying to the EGI organisation pages

To speed up the travis run a binary version of Hugo (extended version) for
Linux 64 bit is included in the repository under `binaries`.

Travis will automatically deploy a new version when a PR is merged to master.
