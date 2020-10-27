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
  [EGI High Throughput Compute](https://www.egi.eu/services/high-throughput-compute/)
  ```

## Writing markdown

Files have to be written in Markdown, using code compliant with
[CommonMark](https://spec.commonmark.org/0.29/) and
[GitHub Flavored Markdown](https://github.github.com/gfm/) which is based on
CommonMark.

{{% alert title="Note" color="info" %}} Syntax examples that can be used in the
files is documented in the [syntax section](../syntax). {{% /alert %}}

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

### Notable points

- Lines should be wrapped at 80 characters.
- Sentences should be separated by one space only.
- Indent is made with tabs not with spaces.
- Indent secondary (and following) level lists with 2 spaces.
- Lines should end with a Line Feed character ("\n")
- Files should end with a Line Feed character ("\n"), but not including an empty
  line.
