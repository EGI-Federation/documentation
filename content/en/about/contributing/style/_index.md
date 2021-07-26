---
title: "Style Guide"
linkTitle: "Style"
description: "Style guide for EGI documentation"
type: docs
weight: 20
---

## General recommendations

- All files and folders should be lower case
- EGI Services should be named exactly as in the
  [EGI Services Portfolio](https://www.egi.eu/services/)
- Acronyms should be used only when it makes sense
- Service names should never be replaced by acronyms
- In the introduction of services link to the public page of the service,
if any:

```markdown
[EGI Cloud Compute](https://www.egi.eu/services/cloud-compute/)
```

## Writing markdown

Documentation pages have to be written in markdown compliant with
[CommonMark](https://spec.commonmark.org/0.29/) and
[GitHub Flavored Markdown](https://github.github.com/gfm/).

### Notable points

- Headings start at level 2 (`##`), as level 1 (`#`) is the title of the page
- Lines should be wrapped at 80 characters
- Sentences should be separated by one space only
- Indent is made with tabs not with spaces
- Lists should be using `-` not `*`
- Indent secondary (and following) level lists with 2 spaces
- Lines should end with a Line Feed character ("\n")
- Files should end with a Line Feed character ("\n"), but not including an empty
  line

{{% alert title="Tip" color="info" %}} Syntax examples that can be used in the
files are documented in the [shortcodes](../shortcodes) section. {{% /alert %}}

### Automating formatting and checking

Style should be enforced via the usage of [Prettier](https://prettier.io/).
Prettier can be integrated with
[various editors](https://prettier.io/docs/en/editors.html).

- With VIM/neovim it can be used via a plugin like
  [ALE](https://github.com/dense-analysis/ale) as described in the
  [official documentation](https://prettier.io/docs/en/vim.html).
- With [VisualStudio Code](https://code.visualstudio.com) please see the
  [official documentation](https://prettier.io/docs/en/editors.html#visual-studio-code)

Configuration is provided in `.prettierrc`, options can be set as follows:

```shell
--print-width 80 --tab-width 2 --prose-wrap always
```

When a Pull Request is received, the proposed changes are checked using
[various linters](https://github.com/EGI-Federation/documentation/tree/main/.github/workflows).

## Adding exceptions for style violations

Successfully passing the checks is a firm requirement, but for the following
cases it is possible to
[add exceptions](https://github.com/DavidAnson/markdownlint#configuration) and
bypass **some checks** in markdown files:

- Long lines due to formatting constructs like tables
- When in-line HTML must be used (e.g. in tables, or when no other proper
  solution is available)

{{% alert title="Important" color="warning" %}} Exceptions should only be used
when there are no other choices, and should be confined to the smallest possible
block of markdown code. {{% /alert %}}

### Dealing with long lines due to tables

{{% alert title="Tip" color="info" %}} When having a long table is not absolutely
necessary, it is better to use a different construct to present the information
instead of adding an exception to ignore long lines.
{{% /alert %}}

When a table is the only proper way to present the data, and the table is wider
than 80 characters, it can be preceded by a HTML comment starting with
[markdownlint-disable](https://github.com/DavidAnson/markdownlint#configuration)
to disable the `line-length` check:

```markdown
<!-- markdownlint-disable line-length -->

| Action      | rOCCI                    | OpenStack              | This is a very long column with important data |
| ----------- | ------------------------ | ---------------------- | ---------------------------------------------- |
| List images | `occi -a list -r os_tpl` | `openstack image list` | Lorem ipsum                                    |

<!-- markdownlint-enable line-length -->
```

{{% alert title="Note" color="info" %}} Do not forget to follow up with a HTML
comment starting with
[markdownlint-enable](https://github.com/DavidAnson/markdownlint#configuration)
to re-enable the `line-length` check.
{{% /alert %}}

{{% alert title="Important" color="warning" %}} In case the table leads to the
introduction of scroll bar, please reconsider using another formatting.
{{% /alert %}}

### Dealing with in-line HTML tags

In some specific cases it is impossible to use anything but in-line HTML tags:

- Presentation page leveraging bootstrap CSS classes or other advanced features
- Using special formatting for the information presented (e.g. a list in a
  table cell)

Blocks with in-line HTML tags should be preceded by a HTML comment starting
with [markdownlint-disable](https://github.com/DavidAnson/markdownlint#configuration)
to disable the `no-inline-html` check.

In the following example two checks are disabled at the same time: `line-length`
and `no-inline-html`:

```markdown
<!-- markdownlint-disable line-length no-inline-html -->

| Action      | rOCCI                    | OpenStack              | This is a very long column with important data |
| ----------- | ------------------------ | ---------------------- | ---------------------------------------------- |
| List images | `occi -a list -r os_tpl` | `openstack image list` | <ul><li>Lorem</li><li>ipsum</li></ul>          |

<!-- markdownlint-enable line-length no-inline-html -->
```

{{% alert title="Note" color="info" %}} Do not forget to follow up with a HTML
comment starting with
[markdownlint-enable](https://github.com/DavidAnson/markdownlint#configuration)
to re-enable the `no-inline-html` check.
{{% /alert %}}

{{% alert title="Important" color="warning" %}} Always use the tag that is
providing the proper semantic: e.g. for a list use `<ul>` and `<li>`, not `<br />`.
{{% /alert %}}
