---
---
title: "Clients"
linkTitle: "Clients"
type: docs
description: "Documentation related to EGI Data Transfer Clients"
weight: 30
---

## Overview 

The EGI Data Transfer Service is based on the FTS3 service, developed at CERN. It allows you to move any type of data files asynchronously from one storage to another. The service includes dedicated interfaces to display statistics of on-going transfers and manage storage resources parameters.

The EGI  Data Transfer is ideal to move large amounts of files or very large files as the service has mechanisms to ensure automatic retry in case of failures and checksumming.


## Features

Simplicity

: Easy user interfaces for submitting transfers:  CLI, Python Bindings, WebFTS and Web Monitoring.  

Reliability

: Checksums and retries are provided per transfer

Flexibility

: Multiprotocol support (Webdav/https, GridFTP, xroot, SRM). 

Intelligence

: Parallel transfers optimization to get the most from network without burning the storages. Priorities/Activities support for transfers classification. 

## Components 

FTS3 Server 

: The service is responsible of the aysnchronous execution of the file transfer, checksumming and retries in case of errors

FTS3 REST  

: The RESTFul server which is contanted by clients via REST APIs, CLI and Python bindings


FTS3 Monitoring  

: A Web interface to  monitor transfers actovity and server parameters
 

WebFTS

: A web interface that provides a file transfer and management solution in order to allow users to invoke reliable, managed data transfers on distributed infrastructures




