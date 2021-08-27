---
title: "Shortcodes"
description: "Helpers for writing EGI documentation"
type: docs
weight: 40
---

In addition to the formatting support provided by
[markdown](https://spec.commonmark.org/0.29/),
Hugo adds support for _shortcodes_, which are Go templates for easily including
or displaying content (image inclusion, notes, tips, advanced display blocks,
etc.).

For reference, the following shortcodes are available:

- [Hugo's shortcodes](https://gohugo.io/content-management/shortcodes/)
- [Docsy theme shortcodes](https://www.docsy.dev/docs/adding-content/shortcodes/)

## Highighted paragraphs

This is achieved using
[Docsy shortcodes](https://www.docsy.dev/docs/adding-content/shortcodes/#shortcode-helpers).

### Placeholders

The following code:

```markdown
{{%/* pageinfo */%}} This is a placeholder. {{%/* /pageinfo */%}}
```

Will render as:

{{% pageinfo %}} This is a
placeholder. {{% /pageinfo %}}

### Information messages

The following code:

```markdown
{{%/* alert title="Note" color="info" */%}} This is a Note. {{%/* /alert */%}}
```

Will render as:

{{% alert title="Note" color="info" %}} This is a Note. {{% /alert %}}

### Warning messages

The following code:

```markdown
{{%/* alert title="Important" color="warning" */%}} This is a warning.
{{%/* /alert */%}}
```

Will render as:

{{% alert title="Important" color="warning" %}} This is a warning. {{% /alert %}}

## Code or shell snippets

The code or instructions should be surrounded with three backticks, followed by
an optional highlighting type parameter.

The supported languages are dependant on the syntax highlighter, which depends
itself on the mardkown parser.

{{% alert title="Note" color="info" %}} For [Hugo](https://gohugo.io/) the
[goldmark parser](https://github.com/yuin/goldmark) is used and it relies on the
[Prism syntax highlighting](https://prismjs.com/download.html#themes=prism).
{{% /alert %}}

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

### Code in multiple languages

This is also achieved using
[Docsy shortcodes](https://www.docsy.dev/docs/adding-content/shortcodes/#tabbed-panes).

When you need to include code snippets, and you want to provide the same code
in multiple programming languages, you can use a tabbed pane for code snippets:

<!-- markdownlint-disable no-inline-html no-missing-space-atx -->
<!-- markdownlint-disable blanks-around-fences no-space-in-code -->

```go-html-template
{{</* tabpane */>}}
  {{</* tab header="C++" lang="C++" */>}}
    #include <iostream>
    int main()
    {
        std::cout << "Hello World!" << std::endl;
    }
  {{</* /tab */>}}
  {{</* tab header="Java" lang="Java" */>}}
    class HelloWorld {
        static public void main( String args[] ) {
            System.out.println( "Hello World!" );
        }
    }
  {{</* /tab */>}}
  {{</* tab header="Kotlin" lang="Kotlin" */>}}
    fun main(args : Array<String>) {
        println("Hello, world!")
    }
  {{</* /tab */>}}
  {{</* tab header="Go" lang="Go" */>}}
    import "fmt"
    func main() {
        fmt.Printf("Hello World!\n")
    }
  {{</* /tab */>}}
{{</* /tabpane */>}}
```

Will render as:

{{< tabpane >}}
{{< tab header="C++" lang="C++">}}
#include <iostream>
int main()
{
  std::cout << "Hello World!" << std::endl;
}
{{< /tab >}}
{{< tab header="Java" lang="Java">}}
class HelloWorld {
  static public void main( String args[] ) {
    System.out.println( "Hello World!" );
  }
}
{{< /tab >}}
{{< tab header="Kotlin" lang="Kotlin">}}
fun main(args : Array<String>) {
    println("Hello, world!")
}
{{< /tab >}}
{{< tab header="Go" lang="Go">}}
package main
import "fmt"
func main() {
  fmt.Printf("Hello World!\n")
}
{{< /tab >}}
{{< /tabpane >}}

## Content with multiple variants

When you need to include multiple variants of the same content, other than
code snippets in multiple programing languages, you can use the follwing
shortcode:

```go-html-template
{{</* tabpanex */>}}
  {{</* tabx header="Linux" */>}}
    You can list all files in a folder using the command:
    ```shell
    ls -a -l
    ```
  {{</* /tabx */>}}
  {{</* tabx header="Mac" */>}}
    To get a list of all files in a folder, press **Cmd** + **Space** to open
    a spotlight search, type terminal, then press Enter. In the terminal window
    then run the command:
    ```shell
    ls -a -l
    ```
  {{</* /tabx */>}}
  {{</* tabx header="Windows" */>}}
    You can list all files in the current folder using the command:
    ```shell
    dir
    ```
    or you can use PowerShell:
    ```powershell
    Get-ChildItem -Path .\
    ```
  {{</* /tabx */>}}
{{</* /tabpanex */>}}
```

Will render as:

{{< tabpanex >}}
  {{< tabx header="Linux" >}}
    You can list all files in a folder using the command:
    ```shell
    ls -a -l
    ```
  {{< /tabx >}}
  {{< tabx  header="Mac" >}}
    To get a list of all files in a folder, press **Cmd** + **Space** to open a
    spotlight search, type terminal, then press Enter. In the terminal window
    then run the command:
    ```shell
    ls -a -l
    ```
  {{< /tabx >}}
  {{< tabx  header="Windows" >}}
    You can list all files in the current folder using the command:
    ```shell
    dir
    ```
    or you can use PowerShell:
    ```powershell
    Get-ChildItem -Path .\
    ```
  {{< /tabx >}}
{{< /tabpanex >}}

{{% alert title="Tip" color="info" %}} You can include any valid markdown
content in each tab, including code or shell snippets.
{{% /alert %}}

<!-- markdownlint-enable blanks-around-fences no-space-in-code -->
<!-- markdownlint-enable no-inline-html no-missing-space-atx -->
