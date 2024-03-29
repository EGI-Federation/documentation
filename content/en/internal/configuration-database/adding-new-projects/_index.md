---
title: "Adding a new project"
weight: 90
type: "docs"
description: >-
  How to create a new project in EGI Configuration Database.
---

## Introduction

GOCDB, the software powering the EGI Configuration Database, is multi-tenanted;
it can host multiple projects in the same instance. There are a number of
different deployment scenarios that can be used to support new projects detailed
below. Please contact the EGI Configuration Database admins and EGI Operations
to discuss the options available.

## 1) Add resources (sites/services) to an existing project

- Resources (NGIs, Sites, Services) would be hosted under an existing project,
  e.g. the ‘EGI’ project.
- The new resources would be subject to the rules of the existing project, such
  as site certification status changes and project controlled user memberships.
- The resources could not be filtered using a custom scope tag.

## 2) Add resources (sites/services) to an existing project and add a new Scope tag to represent a sub-grouping

- Resources would be hosted under an existing project, and a new scope tag would
  be added for the purposes of resource filtering.
- Since the resources are still hosted under an existing project, the new
  resources would still be subject to the rules of the existing project, such as
  site certification status changes and project controlled user memberships.
- The resources could be filtered using the new scope tag, but this scope tag
  would not strictly represent a project, rather a sub-grouping under the
  existing project, e.g.

```markdown
get_services&scope=SubGroupX
```

Note, resources can be tagged multiple times to declare support for multiple
projects and sub-groups:

```markdown
get_services&scope=SubGroupX,EGI&scope_match=all
```

## 3) Add resources (sites/services) to a new Project and add a new Scope tag to filter by project

- Resources would be hosted under a new project, and a new scope tag would be
  added named after the project for the purposes of resource filtering.
- The resources would not be subject to the rules of other projects, for
  example, allowing the project to control its site certification status changes
  and project controlled user memberships.
- The resources could be filtered using the scope tag named after the new
  project, e.g.

```markdown
get_services&scope=ProjectX
```

Note, resources can be tagged multiple times to declare support for multiple
projects:

```markdown
get_services&scope=ProjectX,EGI&scope_match=all
```
