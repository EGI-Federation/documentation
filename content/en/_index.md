---
title: "EGI documentation"
description: "Documentation related to EGI activities"
---

<!-- markdownlint-disable no-inline-html -->

{{< blocks/cover title="Welcome to EGI Documentation!" image_anchor="top"
    height="full" color="blue" >}}

  <p class="lead mt-3">
    This website hosts the first version of the new EGI documentation.<br />
    It will be further improved with more sections in the coming months.<br />
    <a href="https://github.com/EGI-Federation/documentation/issues/new">Your
    feedback and suggestions are welcome!</a>
  </p>

<div class="mx-auto">
  <a class="btn btn-lg btn-primary mr-3 mb-4" href="{{< relref "/users" >}}">
    User Documentation <i class="fas fa-arrow-alt-circle-right ml-2"></i>
  </a>

  <a class="btn btn-lg btn-primary mr-3 mb-4" href="https://www.egi.eu">
    Learn More about EGI <i class="fas fa-arrow-alt-circle-right ml-2"></i>
  </a>

<a class="btn btn-lg btn-success mr-3 mb-4"
href="{{< relref "/about/contributing" >}}"> Contribute
<i class="fab fa-github ml-2 "></i> </a>

  <p class="lead mt-2">EGI Documentation for users and service providers.</p>

{{< blocks/link-down color="info" >}}

</div>
{{< /blocks/cover >}}

<div class="mx-auto">
{{< blocks/section color="primary" type="features">}}

{{% blocks/feature icon="fa-user-friends" title="User Guide" url="/users" %}}
Contains documentation of the EGI services and step-by-step guides on how to
use them. {{% /blocks/feature %}}

{{% blocks/feature icon="fa-users-cog" title="Service Providers"
url="/providers" %}} Explains how to join the EGI infrastructure as a service
provider to offer your innovative services. {{% /blocks/feature %}}

{{% blocks/feature icon="fa-cogs" title="Internal Services" url="/internal" %}}
Hosts the documentation of the EGI services that power the
cloud services of EGI Federation. {{% /blocks/feature %}}

{{< /blocks/section >}}

</div>

{{< blocks/section color="dark" type="features">}}

<!-- markdown-link-check-disable -->

{{% blocks/feature icon="fa-lightbulb" title="Learn about EGI"
    url="https://www.egi.eu" %}}

<!-- markdown-link-check-enable-->

The EGI Federation is supporting many different user communities and open
science projects. {{% /blocks/feature %}}

<!-- markdown-link-check-disable -->

{{% blocks/feature icon="fab fa-github" title="Contribute!"
    url="https://docs.egi.eu/about/contributing" %}}

<!-- markdown-link-check-enable-->

We do a contributions workflow on GitHub. New users are always welcome!
{{% /blocks/feature %}}

<!-- markdown-link-check-disable -->

{{% blocks/feature icon="fab fa-twitter" title="Follow on Twitter"
    url="https://twitter.com/EGI_eInfra" %}}

<!-- markdown-link-check-enable-->

Find out about new EGI features and see how our users are using EGI services.
{{% /blocks/feature %}}

{{< /blocks/section >}}
