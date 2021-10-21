---
title: "Guidelines for software development"
linkTitle: "Development guidelines"
description: "Guidelines for software development"
weight: 1000
type: "docs"
---

This section contains guidelines for software development to be considered when
developing a product for the EGI Federation.

{{% alert title="Note" color="info" %}} Those guidelines are providing a set of
aspects to consider together with some reference documentation, and are not
meant to be exhaustive, further research is welcome. {{% /alert %}}

### Licensing

- Adopt an [OSI-approved license](https://opensource.org/licenses); we recommend
  a business compatible license such as MIT or Apache 2.0
- The license should provide unlimited access rights to the EGI Community

### Source code access

- Maintain the source code in a publicly-accessible software repository like
  GitHub
- You can request to use the
  [EGI Federation GitHub organisation](https://github.com/EGI-Federation)
  - If using another repository, a copy can be kept synchronized under the
    [EGI Federation GitHub organisation](https://github.com/EGI-Federation)
- All releases must be tagged appropriately

### Code style

- Style guidelines must be defined and documented. A general style guide may be
  made available by EGI as a default.
- If you are extended an existing software component, then you must use the code
  style defined by the related product team
- If you are developing a new component, then you must use the code style
  practices for the programming language of your choice
- Code style compliance should be checked by automated means for every change

### Best practices

- The industry best practices should be adopted
- As far as possible adopt [12 factor application pattern](https://12factor.net)
- Configuration Management modules to deploy and configure the products should
  be provided and distributed through the corresponding distribution channels
  - [Ansible](https://www.ansible.com/) is recommended, roles can be hosted
    under the EGI Federation organization in
    [Ansible Galaxy](https://galaxy.ansible.com/EGI-Foundation/)

### Security best practices

- Security best practices must be taken into account
- Security-related aspects must be considered from the beginning
- Security issues must be addressed in priority and following the
  [EGI SVG recommendations](https://wiki.egi.eu/wiki/SVG) and must take into
  account the points mentioned in the
  [SVG Secure Coding](https://wiki.egi.eu/wiki/SVG:Secure_Coding) and
  [Software Security Checklist](https://wiki.egi.eu/wiki/SVG:Software_Security_Checklist)
- The Open Web Application Security Project ([OWASP](https://owasp.org/))
  provides extensive documentation, standards (such as
  [ASVS](https://owasp.org/www-project-application-security-verification-standard/))
  and tools to ensure that your software has capabilities to defend against
  common attacks.

#### Suggested references

- [Secure Software Development Framework | CSRC](https://csrc.nist.gov/Projects/ssdf)
- [NIST: Cybersecurity](https://www.nist.gov/cybersecurity)
- [Cybersecurity & Infrastructure Security Agency](https://www.cisa.gov/cybersecurity)
- [Microsoft Security Development Lifecycle (SDL)](https://www.microsoft.com/en-us/securityengineering/sdl/)

### Tooling and telemetry

- If the project is an application or an infrastructure component, it should
  follow as close as possible the monitoring guidelines set by the
  [Site Reliability Engineer book](https://sre.google/books/)

### Testing

- Unit tests should be provided
- Unit testing should be automated
- Code coverage should be computed as part of the continuous integration
- When possible functional and integration tests should be automated
- If it’s not possible for some components the product team should provide
  report about those tests for the new releases

### Code Review

- A team of code reviewers shall be specified for each project
- Changes must be reviewed by the code review team prior to be merged using a
  Pull Request-like workflow

### Documentation

- Documentation must be treated like code
  - Written in a plain text-based format
  - Management in a repository and versioning
  - Markdown and reStructuredText formats are recommended
- The documentation for an EGI Service should be submitted for publishing on the
  [EGI Documentation site](https://docs.egi.eu) using the related
  [GitHub repository](https://github.com/EGI-Foundation/documentation)
- A “Community First” approach should be followed
  - Contributing, onboarding and community guidelines should be available from
    the start of the project
- Documentation should be available for
  - Developers
  - Administrators (Deployment and administration)
  - End users

### Artefacts Release and delivery

- Artefacts should be tagged according to
  [Semantic Versioning](https://semver.org/) or to
  [Calendar Versioning](https://calver.org) that can be more appropriate for OS
  images
- Artefacts should have a DOI and associated short writeup (see Documentation
  above)
- Artefacts should be published in publicly available repositories
  - EGI Application Database can be used for this
  - UMD can be used to distribute middleware components
- It should be possible to automatically build production-grade distribution
  artefacts from the repository using provided build scripts and files
- Where appropriate, native packages for EGI Federation-supported Operating
  System should be provided:
  - CentOS 7 (rpm)
  - Ubuntu 20.04 LTS (deb)
- Containers are accepted
  - Containers must be compatible with EGI Cloud services

## Request for information

You can ask for more information about them by contacting us via
[our website](https://www.egi.eu/more-information).
