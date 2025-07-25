---
title: "Installation Validation"
weight: 40
type: "docs"
description: >
  Validate your installation
---

Once the site services are registered in GOCDB (and flagged as \"monitored\")
they will appear in the EGI service monitoring tools. EGI will check the status
of the services. Check if your services are present in the EGI service
monitoring tools and passing the tests; if you experience any issues (services
not shown, services are not OK\...) please contact back EGI Operations or your
reference Resource Infrastructure.

Extra checks for your installation:

- Check in [ARGO](https://argo.egi.eu/egi/CriticalUncert) that your services are
  listed and are passing the tests. If all the tests are OK, your installation
  is already in good shape.

- Check that all the images listed in the AppDB for the VOs you support (e.g.
  [AppDB page for vo.access.egi.eu VO](https://appdb.egi.eu/store/vo/vo.access.egi.eu))
  are listed in your BDII. This sample query will return all the template IDs
  registered in your BDII: :

  ```shell
  ldapsearch -x -h <site bdii host> -p 2170 -b Glue2GroupID=cloud,Glue2DomainID=<your site name>,o=glue objectClass=GLUE2ApplicationEnvironment GLUE2ApplicationEnvironmentRepository
  ```

- Try to start one of those images in your cloud. You can do it with
  [onetemplate instantiate]{.title-ref} or OCCI commands, the result should be
  the same.

- Execute the
  [site certification manual tests](../../../providers/operations-manuals/howto04_site_certification_manual_tests/#check-the-functionality-of-the-cloud-elements)
  against your endpoints.

- Check in the [accounting portal](https://accounting.egi.eu/) that your site is
  listed and the values reported look consistent with the usage of your site.
