---
title: "Messaging service"
weight: 30
type: "docs"
description: "Messaging service supporting other central services"
---

## What is it?

The EGI Messaging Service is powered by ARGO Messaging Service (AMS), a
Publish/Subscribe Service, which implements the Google PubSub protocol. It
provides an HTTP API that enables Users/Systems to implement message oriented
service using the Publish/Subscribe Model over plain HTTP.

In the Publish/Subscribe paradigm, Publishers are users/systems that can send
messages to named-channels called Topics. Subscribers are users/systems that
create Subscriptions to specific topics and receive messages.

This central service is used by other EGI central services in order to exchange
messages, like for sending information about accounting or resources available
at a cloud site.

{{% alert title="Note" color="info" %}} Documentation for the ARGO Messaging
Service is available on
[the ARGO documentation site](https://argoeu.github.io/guides/messaging/).
{{% /alert %}}
