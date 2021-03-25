---
title: "Training instance"
type: docs
description: >
  Notebooks for training events
weight: 30
---

EGI provides a training instance of the Notebooks service for training events.

To get started:

1. Go to <https://training.notebooks.egi.eu>.

   {{% alert title="Note" color="warning" %}} This instance may not use the same
   software version as in production and may not be always available, as it is
   typically configured only for specific training events. {{% /alert %}}

1. Start the authentication process by clicking on **Start your notebooks!**
   button

   ![image](training-front.png)

1. Select the Identity Provider you belong to from the discovery page. If this
   is the first time you access an EGI service, Check-in will guide you through
   a registration process.

   ![Check-in auth](checkin.png)

1. You will see the Jupyter interface once your personal server is started

   ![Classic Jupyter Notebook](classic.png)

## Launching a notebook

Click on the New \> Python 3 option to launch your notebook with Python 3
kernel. When you create this notebook, a new tab will be presented with a
notebook named `Untitled.ipynb`. You can easily rename it by right-clicking on
the current name.

![New notebook](new-classic.png)

### Structure of a notebook

The notebook consists of a sequence of cells. A cell is a multiline text input
field, and its contents can be executed by using `Shift-Enter`, or by clicking
either the "Play" button in the toolbar, or Cell -\> Run in the menu bar.

The execution behaviour of a cell is determined by the cell's type.

There are three types of cells: cells, markdown, and raw cells. Every cell
starts off being a code cell, but its type can be changed by using a drop-down
on the toolbar (which will be "Code", initially).

#### Code cells

A code cell allows you to edit and write new code, with full syntax highlighting
and tab completion. The programming language you use depends on the kernel.

When a code cell is executed, its content is sent to the kernel associated with
the notebook. The results that are returned from this computation are then
displayed in the notebook as the cell's output. The output is not limited to
text, with many other possible forms of output are also possible, including
figures and HTML tables.

#### Markdown cells

You can document the computational process in a literate way, alternating
descriptive text with code, using rich text. This is accomplished by marking up
text with the Markdown language. The corresponding cells are called Markdown
cells. The Markdown language provides a simple way to perform this text markup,
that is, to specify which parts of the text should be emphasized (italics),
bold, form lists, etc.

If you want to provide structure for your document, you can also use markdown
headings. Markdown headings consist of 1 to 6 hash `#` signs followed by a space
and the title of your section. The markdown heading will be converted to a
clickable link for a section of the notebook. It is also used as a hint when
exporting to other document formats, like PDF.

When a Markdown cell is executed, the Markdown code is converted into the
corresponding formatted rich text. Markdown allows arbitrary HTML code for
formatting.

#### Raw cells

Raw cells provide a place in which you can write output directly. Raw cells are
not evaluated by the notebook.

### Keyboard shortcuts

All actions in the notebook can be performed with the mouse, but keyboard
shortcuts are also available for the most common ones. These are some of the
most common:

- `Shift-Enter`: run cell. Execute the current cell, show any output, and jump
  to the next cell below. If `Shift-Enter` is invoked on the last cell, it
  creates a new cell below. This is equivalent to clicking the Cell -\> Run menu
  item, or the Play button in the toolbar.
- `Esc`: Command mode. In command mode, you can navigate around the notebook
  using keyboard shortcuts.
- `Enter` : Edit mode. In edit mode, you can edit text in cells.

## Hands-on

We pre-populate your home directory with some sample notebooks to get started,
below you can find links to other notebooks that we have used in past trainings
that may be useful to explore the system:

1. [A very basic notebook to get started](https://github.com/EGI-Federation/training-notebooks-di4r-2018/blob/master/00-first-notebook.ipynb)
2. [Getting data and doing a simple plot](https://github.com/EGI-Federation/training-notebooks-climate-change/blob/master/cckp_historical_temperature.ipynb).
3. [Connect to NOAA\'s GrADS Data Server to plot wind speed](https://github.com/EGI-Federation/training-notebooks-di4r-2018/blob/master/02-wind-nowcast.ipynb).
4. [Installing new libraries](https://github.com/EGI-Federation/training-notebooks-di4r-2018/blob/master/03-customizing.ipynb).
5. [Interact with Check-in](https://github.com/EGI-Federation/training-notebooks-di4r-2018/blob/master/04-check-in.ipynb)
