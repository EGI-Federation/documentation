---
title: Frequently Asked Questions
linkTitle: FAQ
weight: 40
type: docs
aliases:
  - /users/notebooks/faq
description: >
  Most frequent questions asked about EGI Notebooks
---

## How do I install library _X_?

You can install new software easily on the notebooks using `conda` or `pip`. The
`%conda` and `%pip`
[magics](https://ipython.readthedocs.io/en/stable/interactive/magics.html#magic-conda)
can be used in a cell of your notebooks to do so, e.g. installing `rdkit`:

```{.pycon}
%conda install rdkit
```

Once installed you can import the library as usual.

{{% alert title="Warning" color="warning" %}} Any modifications to the
libraries/software of your notebooks will be lost when your notebook server is
stopped (automatically after 1 hour of inactivity)! {{% /alert %}}

## Can I request library _X_ to be installed permanently?

Yes! Just let us know what are your needs. You can contact us via:

- Opening a ticket in the [EGI Helpdesk](https://ggus.eu), or
- Creating a [GitHub Issue](https://github.com/EGI-Federation/notebooks/issues)

We will analyse your request and get back to you.
