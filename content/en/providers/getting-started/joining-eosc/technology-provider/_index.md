---
title: "Joining as a Technology Provider (TP)"
weight: 100
description:
  "Guidelines for Technology Providers to join the EOSC Compute Platform"
type: "docs"
---

## Introduction

Technology Providers develop or deliver technology and software for specific
user communities or customisation for specific requirements. In our case,
they maintain the middleware which the RCs install and that allows the users
to exploit the compute, storage, data, and cloud resources.

## Integration of middleware stack

To assure production quality of the EGI Infrastructure, every middleware stack
(Compute, Storage, etc.) installed on and delivered by the RCs needs to fulfil
a number of requirements.

For this purpose a [procedure](https://confluence.egi.eu/x/DCImBg) was defined
to ensure that any single aspect of the integration of the new piece of
middleware with the infrastructure is covered before the conclusion of the
process.

After the creation of the request in the
[EGI Helpdesk](https://helpdesk.egi.eu/), with details about the technology,
the contacts, the expected customers, and the motivation, the integration steps
cover the following areas (where possible, steps can be done in parallel):

- [Underpinning Agreement](https://ims.egi.eu/display/EGIG/Underpinning+agreement)
(UA) between EGI Foundation and the technology provider
  - it could be either the
  [Corporate-level Technology Provider Underpinning Agreement](https://documents.egi.eu/document/2589)
  or a customised version.
- Configuration Management: mapping of the new technology in the Configuration
  Management Database (CMDB)
- Information System: evaluating if the new technology should publish
  information in the Information System according to the
  [GLUE Schema](http://www.ogf.org/documents/GFD.147.pdf).
- Monitoring: the new technology should allow external monitoring. If particular
  aspects of the technology need to be monitored, specific monitoring probes
  should be provided by the TPs and deployed on the
  [EGI Monitoring service](https://argo.egi.eu/).
- Support: the Support Unit where incidents and service requests will be
  addressed needs to be defined in the EGI Helpdesk, associated to the
  [Quality of Support](https://confluence.egi.eu/x/ygCrB) defined in the UA.
- Accounting: the need to gather usage data, which depends on the technology
  itself and on the infrastructure requirements and will be published in the
  [EGI Accounting Portal](https://accounting.egi.eu/).
- Integration in UMD: the Unified Middleware Distribution is the integrated set
  of software components contributed by Technology Providers and packaged for
  deployment as production quality services in EGI.
- Documentation: exhaustive documentation for RC administrators and users should
  be provided and may be added to the [EGI Documentation](https://docs.egi.eu/).
- Security: a security assessment of the software is required according to a
  number of guidelines defined by the EGI Security team.
