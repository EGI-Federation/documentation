---
title: "Syntax"
description: "Syntax guide for EGI documentation"
type: docs
weight: 50
---

[Hugo](https://gohugo.io/getting-started/configuration-markup/), the tool used
to generate the static site from the source code, is using
[goldmark](https://github.com/yuin/goldmark/) to parse and render markdown.

It's compliant with [CommonMark](https://spec.commonmark.org/0.29/) and
[GitHub Flavored Markdown](https://github.github.com/gfm/) which is also based
on CommonMark.

Markdown provides various elements, and Hugo adds the support of _shortcodes_ a
feature allowing to use templates for easily including or displaying content,
from image inclusion to advanced display structures.

For references The following shortcodes are available:

- [Hugo's shortcodes](https://gohugo.io/content-management/shortcodes/)
- [Docsy theme shortcodes](https://www.docsy.dev/docs/adding-content/shortcodes/)

### Adding sections

To create a new section in the documentation (visible in left-side navigation
tree), you have to create new folders under `/content/<language>` and add a file
`_index.md` to that folder. The beginning of the markdown file contains a
[front matter](https://gohugo.io/content-management/front-matter/) in YAML, JSON
or TOML, holding the metadata of the page:

```yaml
---
title: "Syntax"
description: "Syntax guide for EGI documentation"
type: docs
weight: 30
---
```

The parameter `weight` controls the order of the chapters on the same level in
the left-side navigation tree. Chapters will appear in descending order of their
weight.

The navigation tree officially supports a depth of three (3) levels using the
method described above. If you need to add a fourth level of chapters, in the
folder of the chapter on the third level, add markdown files for the pages that
should be on the fourth level, with a front matter like this:

```yaml
---
title: "Page Guide"
description: "Deepest page in the documentation"
type: docs
weight: 50
no_list: true
---
```

### Linking to another page

You can use the path to the other page:

```markdown
This is a link to [another page](../my-other-page).
```

### Linking to another section in the same page

You need to use an anchor targeting the section name, putting it in lower case
and adding dashes to separate words:

```markdown
This is a test of linking to a specic [section](#the-section-header)

## The section header

Second section content.
```

### Adding an information or warning message

This is achieved using
[Docsy shortcodes](https://www.docsy.dev/docs/adding-content/shortcodes/).

#### General message

The following code:

```markdown
{{%/* pageinfo */%}} This is a placeholder. {{%/* /pageinfo */%}}
```

Will render as:

{{% pageinfo %}} This is a
placeholder. {{% /pageinfo %}}

#### Note or information message

The following code:

```markdown
{{%/* alert title="Note" color="info" */%}} This is a Note. {{%/* /alert */%}}
```

Will render as:

{{% alert title="Note" color="info" %}} This is a Note. {{% /alert %}}

#### Warning message

The following code:

```markdown
{{%/* alert title="Warning" color="warning" */%}} This is a warning.
{{%/* /alert */%}}
```

Will render as:

{{% alert title="Warning" color="warning" %}} This is a warning. {{% /alert %}}

### Code or shell snippets

The code or instructions should be surrounded with three backticks and include
the file type as a parameter.

The supported languages are dependant on the syntax highlighter, which depends
itself on the mardkown parser.

{{% alert title="Note" color="info" %}} For [Hugo](https://gohugo.io/) the
[goldmark parser](https://github.com/yuin/goldmark) is used and it relies on the
[Prism syntax highlighting](https://prismjs.com/download.html#themes=prism).
{{% /alert %}}

The list of languages supported by chroma can be found in their
[GitHub repository](https://github.com/alecthomas/chroma#supported-languages).

The following code should be used for a shell excerpt:

````markdown
```shell
ssh-keygen -f fedcloud
echo $HOME
```
````

Will render as:

```shell
ssh-keygen -f fedcloud
echo $HOME
```

### Including images

The image files should be stored next to the markdown file that is including
them.

{{% alert title="Note" color="info" %}} The image files should have a meaningful
name (like `datahub-replica-management.png`). {{% /alert %}}

The following code is used to include an image, providing a meaningful
alternative text:

```markdown
![Viewing file distribution over the Oneproviders](datahub-replica-management.png)
```
