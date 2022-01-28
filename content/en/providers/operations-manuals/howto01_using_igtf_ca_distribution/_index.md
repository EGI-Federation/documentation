---
title: HOWTO01 Using IGTF CA distribution
weight: 100
type: "docs"
description: "Using the IGTF CA distribution"
---

To ensure interoperability within and outside of EGI, the
[Policy on Acceptable Authentication Assurance](https://documents.egi.eu/document/2930)
defined a common set of trust anchors (in a PKIX implementation "Certification
Authorities") that all sites in EGI should install. In short, all CAs accredited
to the [Interoperable Global Trust Federation](http://www.igtf.net/) under the
[classic](https://www.igtf.net/ap/classic/),
[MICS](https://www.igtf.net/ap/mics/) or [SLCS](https://www.igtf.net/ap/slcs/)
_Authentication Profiles_ are approved for use in EGI. When installing the
'combined-assurance' bundle, also [IOTA](https://www.igtf.net/ap/iota/) issuers
complying with assurance level DOGWOOD are included. Of course, sites may add
additional CAs as long as the integrity of the infrastructure as a whole is not
compromised. Also, if there are site or national policies/regulations that
prevent you from installing a CA, these regulations take precedence -- but you
then must inform the EGI Security Officer (see
[EGI CSIRT](https://confluence.egi.eu/display/EGIBG/CSIRT)) about this
exception.

## Version 1.114 - changelog and information

The changelog contains important notices about the release, as well as a list of
changes to the trust fabric.

- Review the
  [release notes](http://repository.egi.eu/sw/production/cas/1/current/README.txt)
- 1.114 was released on **2022-01-17** as a **regular** update with expedited
  release
- With the introduction of combined assurance/adequacy, the EGEE compatibility
  RPM (lcg-CA) can no longer be supported, and - when still installed - will be
  obsoleted. The proper dependency packages are: ca-policy-_body_-_class_ and
  these have been installed automatically as dependencies since 2010.

## Installation

To install the EGI trust anchors on a system that uses the RedHat Package
Manager (RPM) based package management system, we provide a convenience package
to manage the installation. To install the currently valid distribution, all RPM
packages are provided at

```text
http://repository.egi.eu/sw/production/cas/1/current/
```

The current version is based on the
[IGTF release](https://dl.igtf.net/distribution/igtf/current/) with the same
version number. Install the meta-package `ca-policy-egi-core` (or
`ca-policy-egi-cam`) and its dependencies to implement the core EGI policy on
trusted CAs.

### Using YUM package management

Add the following
[repo-file](http://repository.egi.eu/sw/production/cas/1/current/repo-files/EGI-trustanchors.repo)
to the `/etc/yum.repos.d/` directory:

```ini
[EGI-trustanchors] name=EGI-trustanchors
baseurl=http://repository.egi.eu/sw/production/cas/1/current/
gpgkey=http://repository.egi.eu/sw/production/cas/1/GPG-KEY-EUGridPMA-RPM-3
gpgcheck=1
enabled=1
```

and then update your installation. How to update depends on your previous
activity:

- **if you have previously ever installed the `lcg-CA` package**, remove any
  references to `http://linuxsoft.cern.ch/LCG-CAs/current` from your YUM setup,
  and run

```shell
yum clean cache metadata
yum update lcg-CA
```

- and you are done. This will update the packages installed to the latest
  version, and also install the new `ca-policy-egi-core` package as well as a
  `ca-policy-lcg` package. All packages encode the same set of dependencies

- **if you are upgrading from a previous EGI version only**, just run

```shell
yum update ca-policy-egi-core
```

- although at times you may need to clean the yum cache using

```shell
yum clean cache metadata
```

- **if you are installing the EGI trust anchors for the first time**, run

```shell
yum install ca-policy-egi-core
```

### Using the distribution on a Debian or Debian-derived platform

The 1.39+ releases experimentally add the option to install the trust anchors
from Debian packages using the APT dependency management system. Although care
has been taken to ensure that this distribution is installable and complete, no
guarantees are given, but you are invited to report your issues through GGUS.
You may have to wait for a subsequent release of the Trust Anchor release to
solve your issue, or may be asked to use a temporary repository. To use it:

- Install the EUGridPMA PGP key for apt:

```shell
wget -q -O - \
  https://dist.eugridpma.info/distribution/igtf/current/GPG-KEY-EUGridPMA-RPM-3 \
  | apt-key add -
```

- Add the following line to your sources.list file for APT:

```shell
#### EGI Trust Anchor Distribution ####
deb http://repository.egi.eu/sw/production/cas/1/current egi-igtf core
```

- Populate the cache and install the meta-package

```shell
apt-get update apt-get install ca-policy-egi-core
```

### Using the distribution on other (non-RPM) platforms

The trust anchors are provided also as simple 'tar-balls' for installation on
other platforms. Since there is no dependency management in this case, please
review the release notes carefully for any security issues or withdrawn CAs. The
tar files can be found in the EGI repository at

```text
http://repository.egi.eu/sw/production/cas/1/current/tgz/
```

Once you have downloaded the directory, you can unpack all the CA tar,gz as
follows to your certificate directory:

```shell
for tgz in $(ls  <ca download dir>); do
  tar xzf <ca download dir>/$tgz --strip-components=1 \
    -C /etc/grid-security/certificates
done
```

### Installing the distribution using Quattor

Quattor templates are povided as drop-in replacements for both QWG and CDB
installations. Update your software repository (re-generating the repository
templates as needed) and obtain the new CA templates from:

- `http://repository.egi.eu/sw/production/cas/1/current/meta/ca-policy-egi-core.tpl`
  for QWG
- `http://repository.egi.eu/sw/production/cas/1/current/meta/pro_software_meta_ca_policy_egi_core.tpl`
  for CDB

Make sure to mirror (or refer to) the new repository at
`http://repository.egi.eu/sw/production/cas/1/current/` and create the
appropriate repository definition file.

For WLCG sites that are migrating from the lcg-CA package: the WLCG policy
companion of the EGI templates can be found at
[QWG](http://lcg-ca.web.cern.ch/lcg-ca/distribution/current/meta/ca-policy-lcg.tpl)
and
[CDB](http://lcg-ca.web.cern.ch/lcg-ca/distribution/current/meta/pro_software_meta_ca_policy_lcg.tpl)
and can be included in the profile in parallel with the EGI core template. All
packages needed are also included in the EGI repository, so only a single
repository reference is necessary.

## Trust Anchor structure for differentiated (collaborative) assurance

EGI is moving towards support for 'differentiated' or collaborative assurance,
where different elements of trust are provided by several collaborating parties:
the identity providers, user home organisations, and research communities. This
means that trust anchors with varying trust assurance profiles will be
distributed for use in distinct EGI usage scenarios. Starting mid-2017 (release
1.82 or above) initially two profiles will be supported. For a discussion on the
impact, see [EGI document 2745](https://documents.egi.eu/document/2745).

### Notice for sites in EGI that support WLCG

The WLCG collaboration - having so requested EGI and in line with long-term EGI
developments in AAI - has included a specific CA to its own trust anchor
distribution. Sites that are also part of WLCG should install BOTH the
"egi-core" AND "lcg" meta-packages, according to your policies. Note that your
organisation or NGI may also have a specific policy and may have added or
removed CAs compared to the EGI core policy. Sites that need compliance with the
WLCG policy should install BOTH packages, or you will miss out the CERN WLCG
IOTA CA specific exception see
[EGI document: Considerations on the coexistence of controlled and flexible community models](https://documents.egi.eu/document/2745)
for details and the
[WLCG statement](http://lcg-ca.web.cern.ch/lcg-ca/doc/WLCG-CERN-IOTA-statement-MB.pdf).

The EGI production repository contains all relevant packages for both policies
(and the WLCG repository contains also all EGI packages). There is no reason to
reconfigure repository locations. Specifically installing (adding) also the
`ca-policy-lcg` package may be necessary for system configurations built after
May 2009.

### Combined Assurance/Adequacy Model

In the first quarter of 2017, full support for differentiated assurance profiles
(combined assurance/adequacy model, also called "cam") will be introduced in the
EGI trust fabric infrastructure. This will take the form of an additional trust
anchor meta-package, and replaces the specific policy mechanism described above.
Such full support also required _new software and configuration at each resource
centre_. You must deploy the additional trust anchor meta-packages and the new
local policies in unison, and never install the _cam_ package without such
software support.

To enable the combined assurance/adequacy model policy, use:

```shell
yum install ca-policy-egi-cam
```

or the equivalent for your distribution or operating system. A tarball
installation is also available.

#### Implementation notes for trust anchor releases post 1.86

Not installing the new "cam" package does not have any detrimental effect on
current users - only a new class of users (that can only obtain an opaque
identifiers and do not do full vetting at their electronic identity provider)
could be affected, and then only those users that are member of one of the
communities that has part of the combined-assurance programme: LCG-Atlas,
LCG-Alice, LCG-LHCb, and LCG-CMS.

Also technically this means that you must **only** install the new
`ca-policy-egi-cam` packages if you **also** at the _same time_ implement
VO-specific authorization controls in your software stack. This may require
reconfiguration or a software update:

- for dCache : full support is expected in release v3.1. Meanwhile, if you
  support enumerated communities for at the DOGWOOD assurance level, you can
  upgrade to at least release 2.16 and configure negative controls to limit the
  set of acceptable VOs for those principals whose credential policy OID equals
  `1.2.840.113612.5.2.2.6`. See [dCache.org](http://www.dCache.org/) for details
  or ask your software provider. In future releases, differentiated access to
  storage based on the assurance level can be added - for now decisions are best
  implemented as binary choices (either 'in' or 'out') for gLExec/LCMAPS : all
  necessary software is included in UMD-3 and UMD-4, for EL6, EL7, and
  Debian-based distributions. You can use the example configuration file
  included in the `ca-policy-egi-cam` package under `/usr/share/doc` and see for
  more details
  [the VO-CA-AP Wiki](http://wiki.nikhef.nl/grid/Lcmaps-plugins-vo-ca-ap).
  Authorization based on VO and CA combinations are binary (either 'in' or
  'out') for Argus : install at least version 1.7.1 and follow the instructions
  at
  [the Argus documentation to enable the new PIP and include new policies in the PAP](http://argus-documentation.readthedocs.io/en/latest/release_notes/v_1_7_1.html)

**When in doubt** just only install the regular `ca-policy-egi-core` package.
This is what you get anyway when you upgrade using standard tools, and there are
no changes in this case. The `ca-policy-egi-core` package is approved for all
VOs membership and assurance models.

## Patches and work-arounds

### mod_ssl renegotiation timeouts

We provide here a workaround for the issue
[summarised in comment \#57 of bug \#48458](https://savannah.cern.ch/bugs/?func=detailitem&item_id=48458#comment57).
The following rpm has been added to the repository:
`dummy-ca-certs-20090630-1.noarch.rpm`. Please note that:

- This rpm is not added to the `ca-policy-egi-core`, `lcg-CA` or `ca-policy-lcg`
  metapackage dependencies
- If you want to install it you should run: `yum install dummy-ca-certs`
- The RPM contains 60 expired CAs that cannot be used for validation, but will
  ensure the `mod_ssl` renegotiation buffer is large enough

For Quattor (QWG and CDB) setups, add

```quattor
pkg_repl("dummy-ca-certs","20090630-1","noarch");
```

to your templates, preferably in a file _different_ from the
automatically-generated `egi-ca-policy-core.tpl` template.

### Reminder notice for VOMS AA operators

Several updates to this trust anchor distribution incorporate changes to the
name of the issuing authority, but the name of the end-entities and the users
remains exactly the same. To make the change transparent, all operators of VOMS
and VOMS-Admin services are requested to enable the subject-only name resolution
mechanisms in VOMS and VOMS Admin

- on the VOMS core Attribute Authority service, configure the `-skipcacheck`
  flag on start-up. In YAIM this is done by setting `VOMS_SKIP_CA_CHECK` to
  true. See
  [VOMS Yaim Guide](https://wiki.italiangrid.it/twiki/bin/view/VOMS/VOMSYAIMGuide)
- update VOMS-Admin to version \>= 3.3.2, and set `voms.skip_ca_check=True` in
  the service properties. For more info, read the
  [release notes](http://italiangrid.github.io/voms/release-notes/voms-admin-server/3.3.2/)

## Concerns, issues and verification

If you experience problems with the installation or upgrade of your trust
anchors, or with the repository, please report such an issue through the GGUS
system. For issues with the contents of the distribution, concerns about the
trust fabric, or with questions about the integrity of the distribution, please
contact the EGI IGTF liaison at `egi-igtf-liaison@nikhef.nl`.

You can verify the contents of the EGI Trust Anchor (CA) release with those of
the
[International Grid Trust Federation](https://dist.eugridpma.info/distribution/igtf/current/),
or its [mirror](https://www.apgridpma.org/distribution/). See the IGTF and
EUGridPMA web pages for additional information.

Make sure to verify your trust anchors with [TACAR](https://www.tacar.org/), the
[TERENA](http://www.terena.org) Academic CA Repository, where applicable.
