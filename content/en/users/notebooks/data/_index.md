---
title: "Data Management"
type: docs
description: >
  Managing data on the Notebooks
weight: 10
---

Every user of the EGI Notebooks catch-all instance has a 20GB persistent home to
store any notebooks and associated data. The content of this home directory will
be kept even if your notebook server is stopped (which can happen if there is no
activity for more than 1 hour). **Modifications to the notebooks environment
outside the home directory are not kept** (e.g. installation of libraries). If
you need those changes to persist, let us know via a
[GGUS ticket to the Notebooks Support Unit](https://ggus.eu). You can also ask
for increasing the 20GB home via ticket.

## Getting data in/out

Your notebooks have outgoing internet connectivity so you can connect to any
external service to bring data in for analysis. As with input data, you can
connect to any external service to deposit the notebooks output.

This is convenient for smaller datasets but not practical for larger ones, for
those cases we can offer integration with several data services. These are not
enabled in the catch-all instance but can be made available on demand.

## EGI DataHub

[DataHub](../../datahub) provides a scalable distributed data infrastructure. It
offers a tight integration with Jupyter and notebooks with specific drivers that
make the DataHub Spaces accessible from any notebook.

Whenever you log into the service, supported DataHub spaces will be available
under the `datahub` folder. If you need support for any additional space, please
[open a ticket in GGUS](https://ggus.eu) to add it.

![Datahub folder](datahub-folder.png)

Alternatively, you can also use the [`fs-onedatafs`](https://github.com/onedata/fs-onedatafs)
library from your code. For convenience, the `ONEPROVIDER_HOST` environment variable
will point to the default oneprovider for the Notebooks and the `ONECLIENT_ACCESS_TOKEN`
variable will contain a valid access token for the service.

```python
from fs.onedatafs import OnedataFS

# create the OnedataFS driver using defaults from env
odfs = OnedataFS(os.environ['ONEPROVIDER_HOST'],
                 os.environ['ONECLIENT_ACCESS_TOKEN'],
                 force_direct_io=True)

# use it to open a file
f = odfs.open("<datahub file path>")
```

The `ONEPROVIDER_HOST` and `ONECLIENT_ACCESS_TOKEN` variables are obtained as
part of the login process and made available in the notebooks environment
automatically. You can also specify a different oneprovider host if needed.

## EUDAT B2DROP

[EUDAT B2DROP](https://b2drop.eudat.eu/) offers a WebDAV interface that can be
used to mount your files from the notebooks. Files are accessed as any regular
file from the notebooks interface or from your code. This feature requires users
to create a client in B2DROP and provide the client's credentials to the EGI
notebooks service.

## D4Science Workspace

[D4Science](https://www.d4science.org/) VREs provide a shared workspace via a
dedicated [API](https://gcube.wiki.gcube-system.org/gcube/StorageHub_REST_API).
EGI Notebooks embedded in D4Science VREs will automatically show the user's
workspace at the `workspace` directory. You can browse and use as any regular
file.

## Shared folders

The Notebooks service can enable shared folders for users, either in read-only
or read-write mode. These are specially meant for community instances for easing
the sharing of data between all the users of the service. In the catch-all
instance the `datasets` directory serves as an example of such feature.

## Other services

We are open for integration with other services for facilitating the access to
input and output data. Please contact `support _at_ egi.eu` with your request so
we can investigate the best way to support your needs.
