---
title: "Messaging service"
weight: 30
type: "docs"
description: "Messaging service supporting other central services"
---

## What is it?

The EGI Messaging Service is powered by ARGO Messaging Service (AMS), a
real-time messaging service that allows the user to send and receive messages
between independent applications.

It's a Publish/Subscribe Service implementing the Google PubSub protocol and
providing an HTTP API that enables Users/Systems to implement message oriented
service using the Publish/Subscribe Model over plain HTTP.

This central service is used by other EGI central services in order to exchange
messages, like for sending information about accounting or resources available
at a cloud site. More specifically, the services that use the Messaging service
are:

- **AAI Federation Registry**: uses the service to exchange information among
  the different components (examples: SimpleSamlPHP, MITREid, Keycloak).
- **Operations Portal**: reads the alarms from predefined topics, stores them in
  a database and displays them in the operations portal.
- **Accounting**: uses the service as a transport layer for collecting
  accounting data from the sites. The accounting information is gathered from
  different collectors into a central accounting repository where it is
  processed to generate statistical summaries that are available through the
  [EGI Accounting Portal](../accounting).
- **FedCloud**: used the service as a transport layer for the cloud information
  system. It makes use of the `ams-authN`. The entry point for users, topics and
  subscriptions is the [Configuration Database](../configuration-database).
- **ARGO Availability and Reliability Monitoring Service**: It uses the service
  to send the messages from the monitoring engine to other components.

## Features

- **Ease of use**: it supports an HTTP API and a python library so as to easily
  integrate with the service.
- **Push Delivery**: the service instantly pushes asynchronous event
  notifications when messages are published to the message topic. Subscribers
  are notified when a message is available.
- **Replay messages**: replay messages that have been acknowledged by seeking a
  timestamp.
- **Schema Support**: on demand mechanism that enables a) the definition of the
  expected payload schema, b) the definition of the expected set of attributes
  and values and c) the validation for each message if the requirements are met
  and immediately notify the client.
- **Replicate messages on multiple topics**: Republisher script that consumes
  and publishes messages for specific topics (e.g. sites).

It supports both push and pull message delivery. In push delivery, the Messaging
Service initiates requests to the subscriber application to deliver messages. In
pull delivery, the subscription application initiates requests to the server to
retrieve messages.

Apart from the main service a number of valuable components are also supported.
These components are extensively used by the connected services.

- **Argo-ams-library**: a simple library written in python to interact with the
  ARGO Messaging Service.
- **Argo-AuthN**: Argo-authN is a new Authentication Service. This service
  provides the ability to different services to use alternative authentication
  mechanisms without having to store additional user info or implement new
  functionalities. The authentication service holds various information about a
  service’s users, hosts, API URLs, etc, and leverages them to provide its
  functionality.
- **AMS Metrics**: Metrics about the service

## Architecture

Instead of focusing on a single Messaging service specification for handling the
logic of publishing/subscribing to the broker network, the service focuses on
creating nodes of Publishers and Subscribers as a Service. In the
Publish/Subscribe paradigm, Publishers are users/systems that can send messages
to named-channels called Topics. Subscribers are users/systems that create
Subscriptions to specific topics and receive messages.

As shown in Figure below, the current deployment of messaging service comprises
a haproxy server, which acts as a load balancer for the 3 AMS servers running in
the backend.

![Overview of the messaging service architecture](messaging-diagram.png)

## Using the Messaging Service

{{% alert title="Note" color="info" %}} Documentation for the ARGO Messaging
Service is available on
[the ARGO documentation site](https://argoeu.github.io/guides/messaging/).
{{% /alert %}}
