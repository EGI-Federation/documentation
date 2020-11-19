---
title: "Style guide"
description: "Style guide for EGI documentation"
type: docs
weight: 40
---

## General recommendations

- All files and folders should be lower case;
- EGI Services should be named exactly as in the
  [EGI Services Portfolio](https://www.egi.eu/services/);
- Acronyms should be used only when it makes sense;
- Service names should never be replaced by acronyms;
- In the introduction of services it is appropriate to have a link to the
  service public page, if any:

  ```markdown
  [EGI Cloud Compute](https://www.egi.eu/services/cloud-compute/)
  ```

## Writing markdown

Files have to be written in Markdown, using code compliant with
[CommonMark](https://spec.commonmark.org/0.29/) and
[GitHub Flavored Markdown](https://github.github.com/gfm/) which is based on
CommonMark.

### Notable points

- Lines should be wrapped at 80 characters.
- Sentences should be separated by one space only.
- Indent is made with tabs not with spaces.
- Indent secondary (and following) level lists with 2 spaces.
- Lines should end with a Line Feed character ("\n")
- Files should end with a Line Feed character ("\n"), but not including an empty
  line.

{{% alert title="Tips" color="info" %}} Syntax examples that can be used in the
files is documented in the [syntax section](../syntax). {{% /alert %}}

### Automating formatting and checking

Style should be enforced via the usage of [Prettier](https://prettier.io/).
Prettier can be integrated with
[various editors](https://prettier.io/docs/en/editors.html).

- With VIM/neovim it can be used via a plugin like
  [ALE](https://github.com/dense-analysis/ale) as documented on the
  [official documentation](https://prettier.io/docs/en/vim.html).
- With VScode one should check
  [official documentation](https://prettier.io/docs/en/editors.html#visual-studio-code)

Configuration is provided in `.prettierrc`, options can be set as follow:

```sh
--print-width 80 --tab-width 2 --prose-wrap always
```

When a Pull Request is received, the proposed changes are checked using
[various linters](https://github.com/EGI-Foundation/documentation/tree/master/.github/workflows).

## Adding exceptions for style violations

Successfully passing the checks is a firm requirement, but for some specific
cases it's possible to add some tags in the file to by pass the checks.

The situation when it's possible to violate the style guide can be:

- long lines due to formatting constructs like tables
- in-line HTML tags that have to be used in tables or when no other proper
  solution is available

{{% alert title="Warning" color="warning" %}} Exceptions should only be used
when there are no other choices, and should be confined to the smallest possible
block of markdown code. {{% /alert %}}

### Dealing with long lines like in tables

{{% alert title="Tips" color="info" %}} Ideally when there is no real interest
for having a long table it's better to move to another way of formatting the
documentation. {{% /alert %}}

Nevertheless when a table is indeed the proper way to present the data, it can
be encapsulated with some specific
[markdownlint](https://github.com/DavidAnson/markdownlint) code disabling the
`line-length` check:

```markdown
<!-- markdownlint-disable line-length -->

| Action      | rOCCI                    | OpenStack              | This is a very long column with important data |
| ----------- | ------------------------ | ---------------------- | ---------------------------------------------- |
| List images | `occi -a list -r os_tpl` | `openstack image list` | Lorem ipsum                                    |

<!-- markdownlint-enable line-length -->
```

{{% alert title="Warning" color="warning" %}} In case the table leads to the
introduction of scroll bar, please reconsider using another formatting.
{{% /alert %}}

### Dealing with in-line HTML tags

In some specific it's not possible to use anything but in-line HTML tags:

- presentation page leveraging bootstrap CSS classes or with advanced features
- adding some specific formatting like a list in a cell of a table.

When this is happening the part with the in-line HTML tags should be decorated
with the proper [markdownlint](https://github.com/DavidAnson/markdownlint) code
disabling the `no-inline-html` check.

In this examples two checks are disabled at the same time: `line-length` and
`no-inline-html`:

```markdown
<!-- markdownlint-disable line-length no-inline-html -->

| Action      | rOCCI                    | OpenStack              | This is a very long column with important data |
| ----------- | ------------------------ | ---------------------- | ---------------------------------------------- |
| List images | `occi -a list -r os_tpl` | `openstack image list` | <ul><li>Lorem</li><li>ipsum</li></ul>          |

<!-- markdownlint-enable line-length no-inline-html -->
```

{{% alert title="Warning" color="warning" %}} Always use the tag that is
providing the proper semantic: for a list use `<ul>` and `<li>`, not `<br />`.
{{% /alert %}}
