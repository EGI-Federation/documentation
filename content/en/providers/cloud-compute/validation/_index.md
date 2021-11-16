---
title: "Installation Validation"
weight: 60
type: "docs"
description: >
  Validate your installation
---

Once the site services are registered in GOCDB (and flagged as \"monitored\")
they will appear in the EGI service monitoring tools. EGI will check the status
of the services (see
[Infrastructure Status](https://wiki.egi.eu/wiki/Federated_Cloud_infrastructure_status)
for details). Check if your services are present in the EGI service monitoring
tools and passing the tests; if you experience any issues (services not shown,
services are not OK\...) please contact back EGI Operations or your reference
Resource Infrastructure.

Extra checks for your installation:

- Check in [ARGO-Mon2](https://argo-mon2.egi.eu/nagios) that your services are
  listed and are passing the tests. If all the tests are OK, your installation
  is already in good shape.

- Check that you are publishing cloud information in your site BDII: :

  <!-- markdownlint-disable line-length -->
  ```shell
  ldapsearch -x -h <site bdii host> -p 2170 -b Glue2GroupID=cloud,Glue2DomainID=<your site name>,o=glue
  ```
  <!-- markdownlint-enable line-length -->

- Check that all the images listed in the AppDB for the VOs you support (e.g.
  [AppDB page for fedlcoud.egi.eu VO](https://appdb.egi.eu/store/vo/fedcloud.egi.eu))
  are listed in your BDII. This sample query will return all the template IDs
  registered in your BDII: :

  <!-- markdownlint-disable line-length -->
  ```shell
  ldapsearch -x -h <site bdii host> -p 2170 -b Glue2GroupID=cloud,Glue2DomainID=<your site name>,o=glue objectClass=GLUE2ApplicationEnvironment GLUE2ApplicationEnvironmentRepository
  ```
  <!-- markdownlint-enable line-length -->

- Try to start one of those images in your cloud. You can do it with
  [onetemplate instantiate]{.title-ref} or OCCI commands, the result should be
  the same.

- Execute the
  [site certification manual tests](https://docs.egi.eu/providers/operations-manuals/howto04_site_certification_manual_tests/#check-the-functionality-of-the-cloud-elements)
  against your endpoints.

- Check in the [accounting portal](http://accounting.egi.eu/) that your site is
  listed and the values reported look consistent with the usage of your site.
