---
title: "EGI documentation"
description: "Documentation related to EGI activities"
---

<!-- markdownlint-disable no-inline-html -->

{{< blocks/cover title="Welcome to EGI Documentation!" image_anchor="top"
    height="full" color="blue" >}}

  <p class="lead mt-5">
    This website hosts the first version of the new EGI documentation.<br />
    It will be further improved with more sections in the coming months.<br />
    <a href="https://github.com/EGI-Federation/documentation/issues/new">Your
    feedback and suggestions are welcome!</a>
  </p>

<div class="mx-auto">
  <a class="btn btn-lg btn-primary mr-3 mb-4" href="{{< relref "/users" >}}">
    User documentation <i class="fas fa-arrow-alt-circle-right ml-2"></i>
  </a>

  <a class="btn btn-lg btn-primary mr-3 mb-4" href="https://www.egi.eu">
    Learn More about EGI <i class="fas fa-arrow-alt-circle-right ml-2"></i>
  </a>

  <a class="btn btn-lg btn-secondary mr-3 mb-4"
     href="{{< relref "/about/contributing" >}}">
    Contribute <i class="fab fa-github ml-2 "></i>
  </a>
  <p class="lead mt-5">EGI Documentation for users and service providers.</p>

  {{< blocks/link-down color="info" >}}

</div>
{{< /blocks/cover >}}

<div class="mx-auto">
{{< blocks/section color="primary" type="features">}}

{{% blocks/feature icon="fa-user-friends" title="Users" url="/users" %}}
Contains step-to-step documentation on how to use the EGI services.
{{% /blocks/feature %}}

{{% blocks/feature icon="fa-users-cog" title="Providers" url="/providers" %}}
Depicts how to join the EGI infrastructure as a service provider offering
innovative services to the European Research Area. {{% /blocks/feature %}}

{{% blocks/feature icon="fa-cogs" title="Internal services"
    url="/internal" %}}
Hosts the documentation of the EGI services enabling the federation.
{{% /blocks/feature %}}

{{< /blocks/section >}}

</div>

{{< blocks/section color="dark" type="features">}}
<!-- markdown-link-check-disable -->
{{% blocks/feature icon="fa-lightbulb" title="Learn more about EGI!"
    url="https://www.egi.eu" %}}
<!-- markdown-link-check-enable-->
The EGI Federation is supporting lots of different user communities.
{{% /blocks/feature %}}

<!-- markdown-link-check-disable -->
{{% blocks/feature icon="fab fa-github" title="Contributions welcome!"
    url="https://docs.egi.eu/about/contributing" %}}
<!-- markdown-link-check-enable-->
We do a [Pull Request](https://github.com/EGI-Federation/documentation/pulls)
contributions workflow on **GitHub**. New users are always welcome!
{{% /blocks/feature %}}

<!-- markdown-link-check-disable -->
{{% blocks/feature icon="fab fa-twitter" title="Follow us on Twitter!"
    url="https://twitter.com/EGI_eInfra" %}}
<!-- markdown-link-check-enable-->
Find out about new features and how our users are using EGI.
{{% /blocks/feature %}}

{{< /blocks/section >}}
