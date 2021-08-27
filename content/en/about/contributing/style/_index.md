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
- When introducing services, link to the public page of the service,
if any:

```markdown
[EGI Cloud Compute](https://www.egi.eu/services/cloud-compute/)
```

## Markdown writing guidelines

Documentation pages have to be written in markdown, compliant with
[CommonMark](https://spec.commonmark.org/0.29/) and
[GitHub Flavored Markdown](https://github.github.com/gfm/).

### Basic rules

- Headings must start at level 2 (`##`), as level 1 (`#`) is the title of the page
- Lines should be wrapped at 80 characters
- Sentences must be separated by one space only
- Indent is made with tabs, not with spaces
- Bullet lists should be using `-` not `*`
- Numbered lists should be using `1.` for each line (automatic numbering)
- Indent secondary (and following) level lists with 2 spaces
- Lines must end with a Line Feed character (`\n`)
- Files must end with an empty line, containing only a Line Feed
  character (`\n`)
- Shell examples should include a prompt (`$` or `>`) in front of commands,
  to make it easy to understand which is the command and which is the output
- Long commands in shell examples should be broken into multiple lines, using
  a trailing backslash character (`\`) on each line that continues on the next
- Never break command output in shell examples to multiple lines, instead use
  [style exceptions](#adding-exceptions-for-style-violations) when necessary

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

When a contribution is received (via a pull request), the proposed changes are
checked using [various linters](https://github.com/EGI-Federation/documentation/tree/main/.github/workflows).

## General writing guidelines

Follow the guidelines below to ensure readability and consistency of the EGI
documentation. These are based on the [OpenStack documentation
writing style](https://docs.openstack.org/doc-contrib-guide/writing-style.html)
guidelines, released under a [Creative Commons license](https://creativecommons.org/licenses/by/3.0/).

{{% alert title="Tip" color="info" %}} Short and simple sentences are easier
to read and understand.
{{% /alert %}}

### Use standard English

Use standard British English (UK) throughout all technical
publications. When in doubt about the spelling of a word, consult the
Merriam-Webster’s Collegiate Dictionary and the
[IBM developerWorks editorial style guide](https://www.ibm.com/developerworks/library/styleguidelines/).

### Be clear and concise

Follow the principles of minimalism. If you can describe an idea in one word,
do not use two words. Eliminate all redundant modifiers, such as adjectives
and adverbs.

### Write objectively

Do not use humor, jargon, exclamation marks, idioms, metaphors, and other
colloquialisms.

### Describe the most common use case first

Put the most common case in the main clause and at the beginning of a paragraph
or section. You can introduce additional use cases by starting a sentence with
“however” or “if”.

### Write in active voice

In general, write in active voice rather than passive voice. Active voice
identifies the agent of action as the subject of the verb, usually the user.
Passive voice identifies the recipient (not the source) of the action as the
subject of the verb.

Active-voice sentences clarify the performer of an action and are easier to
understand than passive-voice sentences. Passive voice is usually less engaging
and more complicated than active voice. When you use passive voice, the actions
and responses of the software can be difficult to distinguish from those of the
user. In addition, passive voice usually requires more words than active voice.

<!-- markdownlint-disable line-length -->
{{< tabpanex >}}
  {{< tabx header="Examples" >}}
| Do not use                                                          | Use                                                 |
| --------------------------------------------------------------------|-----------------------------------------------------|
| After the software has been installed, the computer can be started. | After you install the software, start the computer. |
| The Configuration is saved when you click OK.                       | Click OK to save the configuration.                 |
| A server is created by you.                                         | Create a server.                                    |
  {{< /tabx >}}
{{< /tabpanex >}}
<!-- markdownlint-enable line-length -->

However, passive voice is acceptable in the following situations:

<!-- markdownlint-disable line-length -->
- Using active voice sounds like you are blaming the user. For example, you can
  use passive voice in an error message or troubleshooting content when the
  active subject is the user.
{{< tabpanex >}}
  {{< tabx header="Example" >}}
| Do not use                                           | Use                                                     |
| -----------------------------------------------------|---------------------------------------------------------|
| If the build fails, you probably omitted the flavor. | If the build fails, the flavor might have been omitted. |
  {{< /tabx >}}
{{< /tabpanex >}}

- The agent of action is unknown, or you want to de-emphasize the agent of
  action and emphasize the object on which the action is performed.
{{< tabpanex >}}
  {{< tabx header="Example" >}}
| Do not use                                           | Use                                          |
| -----------------------------------------------------|----------------------------------------------|
| The product, OS, or database returns the messages.   | The messages are returned [by the database]. |
  {{< /tabx >}}
{{< /tabpanex >}}

- Recasting the sentence in active voice is wordy or awkward.
{{< tabpanex >}}
  {{< tabx header="Example" >}}
| Do not use                                                                | Use                                                                |
| --------------------------------------------------------------------------|--------------------------------------------------------------------|
| In 2009, engineers developed a software that simplifies the installation. | A software that simplifies the installation was developed in 2009. |
  {{< /tabx >}}
{{< /tabpanex >}}
<!-- markdownlint-enable line-length -->

### Write in second person

Users are more engaged with documentation when you use second person (that is,
you address the user as “you”).

Writing in second person has the following advantages:

- Second person promotes a friendly tone by addressing users directly.
- Using second person with the imperative mood (in which the subject you is
  understood) and active voice helps to eliminate wordiness and confusion about
  who or what initiates an action, especially in procedural steps.
- Using second person also avoids the use of gender-specific, third-person
  pronouns such as he, she, his, and hers. If you must use third person, use
  the pronouns they and their, but ensure that the pronoun matches the
  referenced noun in number.
- Use first person plural pronouns (we, our) judiciously. These pronouns
  emphasize the writer or EGI rather than the user, so before you use
  them, consider whether second person or imperative mood is more
  “user-friendly.” However, use “we recommend” rather than “it is recommended”
  or “EGI recommends”.

{{% alert title="Tip" color="info" %}} You can use “we” in the place of
EGI if necessary.
{{% /alert %}}

Do not use first person to avoid naming the product or to avoid using passive
voice. If the product is performing the action, use third person (the product
as an actor). If you want to de-emphasize the agent of action and emphasize the
object on which the action is performed, use passive voice.

The first-person singular pronoun “I” is acceptable in the question part of
FAQs and when authors of blogs or signed articles are describing their own
actions or opinions.

{{% alert title="Important" color="warning" %}} Do not switch person (point of
view) in the same guide or on the same page.
{{% /alert %}}

<!-- markdownlint-disable line-length -->
{{< tabpanex >}}
  {{< tabx header="Examples" >}}
| Do not use                                                        | Use                                                        |
| ------------------------------------------------------------------|------------------------------------------------------------|
| Creating a server involves specifying a name, flavor, and image.  | To create a server, specify a name, a flavor, and image.   |
| To create a server, the user specifies a name, flavor, and image. | To create a server, you specify a name, flavor, and image. |
  {{< /tabx >}}
{{< /tabpanex >}}
<!-- markdownlint-enable line-length -->

### Use the present simple tense

Users read documentation to perform tasks or gather information. For users,
these activities take place in their present, so the present tense is
appropriate in most cases. Additionally, the present tense is easier to read
than the past or future tense.

<!-- markdownlint-disable line-length -->
{{< tabpanex >}}
  {{< tabx header="Example" >}}
| Do not use | Use |
| -----------|-----|
| The product will prompt you to verify the deletion. After you log in, your account will then begin the verification process. | The product prompts you to verify the deletion. After you log in, your account begins the verification process. |
  {{< /tabx >}}
{{< /tabpanex >}}
<!-- markdownlint-enable line-length -->

{{% alert title="Tip" color="info" %}} Use the future tense only when you need
to emphasize that something will occur later (from the users’ perspective).
{{% /alert %}}

### Do not humanize inanimate objects

Do not give human characteristics to non-human subjects or objects.

{{< tabpanex >}}
  {{< tabx header="Example" >}}
| Do not use            | Use                     |
| ----------------------|-------------------------|
| This guide assumes... | This guide describes... |
  {{< /tabx >}}
{{< /tabpanex >}}

### Avoid personification

Do not express your fears or feelings in technical writing. Avoid the adverbs
such as “probably”, “hopefully”, “basically”, and so on.

### Avoid ambiguous titles

Each title should include a clear description of the page’s or chapter's
subject.

{{< tabpanex >}}
  {{< tabx header="Example" >}}
| Do not use      | Use                    |
| ----------------|------------------------|
| Update metadata | Update object metadata |
  {{< /tabx >}}
{{< /tabpanex >}}

### Eliminate needless politeness

Do not use “please” and “thank you” in technical documentation.

### Write positively

Write in a positive tone. Positive sentences improve readability. Try to avoid
the following words as much as possible:

{{< tabpanex >}}
  {{< tabx header="Examples" >}}
| Do not use      | Use                          |
| ----------------|------------------------------|
| damage          | affect                       |
| catastrophic    | serious                      |
| bad             | serious (or add explanation) |
| fail            | unable to                    |
| kill            | cancel or stop               |
| fatal           | serious                      |
| destroy         | remove or delete             |
| wrong           | incorrect or inconsistent    |
  {{< /tabx >}}
{{< /tabpanex >}}

### Do not use contractions

Generally, do not contract the words.

{{< tabpanex >}}
  {{< tabx header="Examples" >}}
| Do not use | Use      |
| -----------|----------|
| can't      | cannot   |
| don't      | do not   |
  {{< /tabx >}}
{{< /tabpanex >}}

### Do not overuse this, that, these, and it

Use these pronouns sparingly. Overuse contributes to readers’ confusion. To fix
the ambiguity, rephrase the sentence.

<!-- markdownlint-disable line-length -->
{{< tabpanex >}}
  {{< tabx header="Example" >}}
| Do not use | Use |
| -----------|-----|
| The monitoring system should perform regular checks to verify that the Ceph cluster is healthy. This can be achieved using the Ceph health command. | The monitoring system performs regular checks to ensure the Ceph cluster is functioning correctly. Use the Ceph health command to run a health check. |
  {{< /tabx >}}
{{< /tabpanex >}}
<!-- markdownlint-enable line-length -->

{{% alert title="Tip" color="info" %}} You can also fix the ambiguity by
placing a noun modifier immediately after the pronoun.
{{% /alert %}}

### Do not split infinitives

Do not place modifiers between “to” and the verb. Typically, placing an adverb
or an adjective between “to” and a verb adds ambiguity to a sentence.

### Avoid prepositions at the end of sentences

As much as possible, avoid trailing prepositions in sentences by avoiding
phrasal verbs.

<!-- markdownlint-disable line-length -->
{{< tabpanex >}}
  {{< tabx header="Example" >}}
| Do not use                                  | Use                                  |
| --------------------------------------------|--------------------------------------|
| The image registration window will open up. | The image registration window opens. |
  {{< /tabx >}}
{{< /tabpanex >}}
<!-- markdownlint-enable line-length -->

To fix the verb-preposition constructions, replace them with active verbs.

{{< tabpanex >}}
  {{< tabx header="Examples" >}}
| Do not use | Use      |
| -----------|----------|
| written up | composed |
| pop up     | appear   |
  {{< /tabx >}}
{{< /tabpanex >}}

### Use consistent terminology

Use consistent terms across all content. Avoid multiple variations or
spellings to refer to the same service, function, UI element, and so on.

### Use spelling and grammar checking tools

Run text through spelling and grammar checking tools, if available. Correcting
mistakes, especially to larger sections of new content, helps eliminate rework
later.

### Lists

When reading a document for the first time, users scan through pages stopping
only on the content that stands out, such as titles, lists, links, diagrams,
and so on. Lists help to organize options, as well as help readers to find
information easily.

When listing items, follow these guidelines:

- Use a **bulleted list** for options. Create a bulleted list when you need to
  describe more than three options.
- Use a **numbered list** for steps.
- Use a **definition list** to explain terms or describe command-line
  parameters, options, or arguments.
- Use a colon at the end of the sentence that introduces a list.
- Use the same grammatical structure (aka parallel structure) for all items
  in a list.
- Start each option with a capital letter.

When listing options in a paragraph, add _and_ or _or_ before the last item
in a list. Use a serial (Oxford) comma before these conjunctions if they
connect three or more items.

### Punctuation in lists

In bulleted lists:

- If you list individual words or phrases, do not add a period at the end of
  each list item.
- If you use full sentences, add a period at the end of each sentence.
- If your list includes both individual words or phrases and full sentences,
  be consistent and either add or do not add periods to all items.

In numbered lists:

- Add periods at the end of steps.
- If an item of a numbered list is followed by a code block that illustrates
  how to perform the step, use a colon at the end.

## Adding exceptions for style violations

Successfully passing the checks is a firm requirement, but for the following
cases it is possible to
[add exceptions](https://github.com/DavidAnson/markdownlint#configuration) and
bypass **some checks** in markdown files:

- When in-line HTML must be used (e.g. in tables, or when no other proper
  solution is available)
- When the same procedure needs to be described for multiple platforms,
  and the automatic checker flags it as duplicate content

{{% alert title="Important" color="warning" %}} Exceptions should only be used
when there are no other choices, and should be confined to the smallest possible
block of markdown code. {{% /alert %}}

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

<!-- markdownlint-disable line-length no-inline-html -->

```markdown
<!-- markdownlint-disable no-inline-html -->

| Action      | rOCCI                    | OpenStack              | This is a very long column with important data |
| ----------- | ------------------------ | ---------------------- | ---------------------------------------------- |
| List images | `occi -a list -r os_tpl` | `openstack image list` | <ul><li>Lorem</li><li>ipsum</li></ul>          |

<!-- markdownlint-enable no-inline-html -->
```

<!-- markdownlint-enable line-length no-inline-html -->

{{% alert title="Note" color="info" %}} Do not forget to follow up with a HTML
comment starting with
[markdownlint-enable](https://github.com/DavidAnson/markdownlint#configuration)
to re-enable the `no-inline-html` check.
{{% /alert %}}

{{% alert title="Important" color="warning" %}} Always use the tag that is
providing the proper semantic: e.g. for a list use `<ul>` and `<li>`,
not `<br />`.
{{% /alert %}}

### Dealing with duplicate content

When the same procedure needs to be described for multiple platforms, or when
the same code has to be exemplified for multiple languages, it is possible
that the automatic checkers will flag these as duplicates.

For example, describing the following procedure will result in duplicates
being reported:

<!--
// jscpd:ignore-start
-->
<!-- markdownlint-disable line-length -->

```go-html-template
{{</* tabpanex */>}}
{{</* tabx header="Linux" */>}}
  To run the FedCloud client in a container, make sure
  [Docker is installed](https://docs.docker.com/engine/install/#server),
  then run the following commands:
    ```shell
    $ docker pull tdviet/fedcloudclient
    $ docker run -it tdviet/fedcloudclient bash
    '''
{{</* /tabx */>}}
{{</* tabx header="Mac" */>}}
  To run the FedCloud client in a container, make sure
  [Docker is installed](https://docs.docker.com/desktop/mac/install/),
  then run the following commands:
    ```shell
    $ docker pull tdviet/fedcloudclient
    $ docker run -it tdviet/fedcloudclient bash
    '''
{{</* /tabx */>}}
{{</* tabx header="Windows" */>}}
  To run the FedCloud client in a container, make sure
  [Docker is installed](https://docs.docker.com/desktop/windows/install/),
  then run the following commands:
    ```shell
    > docker pull tdviet/fedcloudclient
    > docker run -it tdviet/fedcloudclient bash
    '''
{{</* /tabx */>}}
{{</* /tabpanex */>}}
```

<!-- markdownlint-enable line-length -->
<!--
// jscpd:ignore-end
-->

This type of content should be preceded by a HTML comment that disables the
check for duplicates, and followed by another HTML comment that enables it
again.

```markdown
<!--
// jscpd:ignore-start
-->

...content with duplicates here...

<!--
// jscpd:ignore-end
-->
```
