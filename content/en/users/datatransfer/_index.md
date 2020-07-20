---
title: "Data Transfer"
linkTitle: "Data Transfer"
type: docs
description: "Documentation related to EGI Data Transfer"
weight: 30
---

## Overview 

The EGI Data Transfer Service is based on the FTS3 service, developed at CERN. It allows you to move any type of data files asynchronously from one storage to another. The service includes dedicated interfaces to display statistics of on-going transfers and manage storage resources parameters.

The EGI  Data Transfer is ideal to move large amounts of files or very large files as the service has mechanisms to ensure automatic retry in case of failures and checksumming.

Main characteristics:

 - Able to handle large amounts of files
 - Transfer process with automatic retry
 - Automatic optimization of the transfer according to network topology
 - Files checksumming
 - Multiprotocol support
 - CLI, REST and Web interface

## Components 

FTS3 Server 

: The service is responsible of the aysnchronous execution of the file transfer, checksumming and retries in case of errors

FTS3 REST  

: The REST backend which is contanted by clients via CLI, bindings APIs in order to submit file transfers.




