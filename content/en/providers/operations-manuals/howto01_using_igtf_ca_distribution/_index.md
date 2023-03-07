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

## Release notes

Review the
[release notes](http://repository.egi.eu/sw/production/cas/1/current/README.txt)
containing important notices about the current release, as well as a list of
changes to the trust fabric.

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
[EGI-trustanchors]
name=EGI-trustanchors
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
$ yum clean cache metadata
$ yum update lcg-CA
```

- and you are done. This will update the packages installed to the latest
  version, and also install the new `ca-policy-egi-core` package as well as a
  `ca-policy-lcg` package. All packages encode the same set of dependencies

- **if you are upgrading from a previous EGI version only**, just run

```shell
$ yum update ca-policy-egi-core
```

- although at times you may need to clean the yum cache using

```shell
$ yum clean cache metadata
```

- **if you are installing the EGI trust anchors for the first time**, run

```shell
$ yum install ca-policy-egi-core
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
$ wget -q -O - \
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
$ apt-get update
$ apt-get install ca-policy-egi-core
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
$ for tgz in $(ls  <ca download dir>); do
    tar xzf <ca download dir>/$tgz --strip-components=1 \
      -C /etc/grid-security/certificates
  done
```

### Installing the distribution using Quattor

Quattor templates are provided as drop-in replacements for both QWG and CDB
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

## Combined Assurance/Adequacy Model

The release contains a "cam" (combined assurance/adequacy) package based on the
approved policy on differentiated assurance. Technically, this means that you
must **ONLY** install the new `ca-policy-egi-cam` packages if you **ALSO** at
the same time implement VO-specific authorization controls in your software
stack. This may require reconfiguration or a software update. Otherwise, just
only install or update the regular `ca-policy-egi-core` package. There are no
changes in this case. The `ca-policy-egi-core` package is approved for all VOs
membership and assurance models. No configuration change is needed.

### Acceptable Authentication Assurance

If a VO registration service or e-infrastructure registration service is
accredited by EGI to meet the approved authentication assurance, an IGTF
"DOGWOOD" accredited Authority - used solely in combination with said
registration service - is also adequate for user authentication. See
[the policy](https://documents.egi.eu/document/2930) for details.

This additional restriction policy must be implemented by each service in the
authorization software. The "combined assurance" model package **MUST NOT** be
installed unless the additional authorization is in place. You will need to
reconfigure and may need to install upgrades. Not installing the new "cam"
package does not have any detrimental effect on current users - only a new class
of users (that can only obtain an opaque identifiers and do not do full vetting
at their electronic identity provider) could be affected, and then only those
users that are member of one of the communities that has part of the
combined-assurance programme: LCG-Atlas, LCG-Alice, LCG-LHCb, and LCG-CMS.

## Patches and workarounds

### Reminder notice for VOMS AA operators

Several updates to this trust anchor distribution incorporate changes to the
name of the issuing authority, but the name of the end-entities and the users
remains exactly the same. To make the change transparent, all operators of VOMS
and VOMS-Admin services are requested to enable the subject-only name resolution
mechanisms in VOMS and VOMS Admin, see additional documentation in
[VOMS services configuration reference](https://italiangrid.github.io/voms/documentation/sysadmin-guide/3.0.14/configuration.html):

- on the VOMS core Attribute Authority service, configure the `-skipcacheck`
  flag on start-up.
- Set `voms.skip_ca_check=True` in the service properties.

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
