---
title: "Contributing"
description: "Contributing to EGI documentation"
type: docs
weight: 30
---

Thank you for taking the time to contribute to this project. The maintainers
greatly appreciate the interest of contributors and rely on continued engagement
with the community to ensure this project remains useful. We would like to
take steps to put contributors in the best possible position to have their
contributions accepted. Please take a few moments to read this short guide on
how to contribute.

{{% alert title="Note" color="info" %}} Before you start contributing to the
EGI documentation, please familiarize yourself with the [concepts](../concepts)
used by documentation authors. When authoring pages, please observe and adhere
to the [Style Guide](style).
{{% /alert %}}

{{% alert title="Tip" color="info" %}} We also welcome contributions
regarding how to contribute easier and more efficiently.
{{% /alert %}}

## Feedback and questions

If you wish to discuss anything related to the project, please open a
[GitHub issue](https://github.com/EGI-Federation/documentation/issues/new) or
start a topic on the [EGI Community Forum](https://community.egi.eu).

{{% alert title="Note" color="info" %}} The maintainers will move issues from
GitHub to the community forum when longer, more open-ended discussion would be
beneficial, including a wider community scope.
{{% /alert %}}

## Contribution process

All contributions have to go through a review process, and contributions can be
made in two ways:

<!-- markdownlint-disable no-inline-html -->
- For simple contributions navigate to the documentation page you want to
  improve, and click the **<i class='fa fa-edit'></i> Edit this page** link in
  the top-right corner
  (see also the [GitHub documentation](https://help.github.com/en/github/managing-files-in-a-repository/editing-files-in-another-users-repository)).
  You will be guided through the required steps. Be sure to save your
  changes quickly as the repository may be updated by someone else in the
  meantime.
- For more complex contributions, and when you want to preview and test changes
  locally, you should fork the repository as documented below on the
  [Using Git and GitHub](git) page.
<!-- markdownlint-enable no-inline-html -->

### Contributing via PRs

{{% alert title="Note" color="info" %}} If you need to discuss your changes
beforehand (e.g. adding a new section, or if you have any doubts), please
consult the maintainers, by creating a
[GitHub issue](https://github.com/EGI-Federation/documentation/issues/new).

<!-- markdownlint-disable no-inline-html -->
You can also create an issue by navigating to a documentation page, and
clicking the **<i class='fab fa-github'></i> Create documentation issue** link
in the top-right corner.
{{% /alert %}}
<!-- markdownlint-enable no-inline-html -->

Before proposing a contribution via the so-called Pull Request (PR) workflow,
there should be an [open issue](https://github.com/EGI-Federation/documentation/issues)
describing the need for your contribution (refer to this issue number when you
submit the PR). We have a three-step process for contributions:

1. Fork the project if you have not done so yet, and commit changes to a
   feature branch. Building the documentation locally is described in the
   [README](https://github.com/EGI-Federation/documentation/blob/main/README.md).
1. Create a GitHub PR from your feature branch, following the instructions
   in the PR template.
1. Perform a [code review](#code-review-process) with the maintainers on the PR.

{{% alert title="Tip" color="info" %}} Rebase your fork's main branch on the
EGI documentation repository's
[main branch](https://github.com/EGI-Federation/documentation/tree/main),
before you create new feature branches from it.
{{% /alert %}}

### PR requirements

1. If the PR is not finalised mark it as draft using the GitHub web interface,
   so it is clear it should not be reviewed yet.
1. **Explain your contribution in plain language.** To assist the maintainers in
   understanding and appreciating your PR, please use the template to
   explain _why_ you are making this contribution, rather than just _what_ the
   contribution entails.

### Code review process

Code review takes place in GitHub pull requests (PRs). See
[this article](https://help.github.com/articles/about-pull-requests/) if you're
not familiar with GitHub PRs.

Once you open a PR, automated checks will verify the style and syntax
of your changes and maintainers will review your code using the built-in code
review process in GitHub PRs.

The process at this point is as follows:

1. Automated syntax and formatting checks are run using
   [GitHub Actions](https://github.com/features/actions), successful checks are
   a hard requirement, but maintainers will help you address reported
   issues.
1. Maintainers will review your changes and merge it if no changes are
   necessary.
   Your change will be merged into the repository's `main` branch.
1. If a maintainer has feedback or questions on your changes, they will set
   `request changes` in the review and provide an explanation.

## Release cycle

The documentation is using a rolling release model, all changes merged to the
`main` branch are directly deployed to the live production environment.

The `main` branch is always available. Tagged versions may be created as needed
following [semantic versioning](https://semver.org/) when applicable.

## Community

EGI benefits from a strong community of developers and system administrators,
and vice-versa. If you have any questions or if you would like to get involved
in the wider EGI community you can check out:

- [EGI Community Forum](https://community.egi.eu/)
- [EGI website](https://www.egi.eu)
