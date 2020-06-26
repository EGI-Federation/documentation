# Contributing

Thank you for taking the time to contribute to this project.
The maintainers greatly appreciate the interest of contributors and rely on
continued engagement with the community to ensure that this project remains
useful.
We would like to take steps to put contributors in the best possible position
to have their contributions accepted.
Please take a few moments to read this short guide on how to contribute; bear
in mind that contributions regarding how to best contribute are also welcome.

## Feedback and Questions

If you wish to discuss anything related to the project, please open an issue or
start a topic on the [EGI Community Forum](https://community.egi.eu).
The maintainers will sometimes move issues off of GitHub to the community forum
if it is thought that longer, more open-ended discussion would be beneficial,
including a wider community scope.

## Contribution Process

Before proposing a contribution via pull request, ideally there is an open
issue describing the need for your contribution (refer to this issue number
when you submit the pull request). We have a 3 step process for contributions.

  1. Fork the project if you have not, and commit changes to a git branch
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
1. If a maintainer has feedback or questions on your changes they they will set
   `request changes` in the review and provide an explanation.

## Using git

For collaboration purposes, it is best if you create a GitHub account and fork
the repository to your own account. Once you do this you will be able to push
your changes to your GitHub repository for others to see and use, and it will
be easier to send pull requests.

### Branches and Commits

You should submit your patch as a git branch named after the Github issue, such
as `#3`\. This is called a _topic branch_ and allows users to associate a
branch of code with the issue.

It is a best practice to have your commit message have a _summary line_ that
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
