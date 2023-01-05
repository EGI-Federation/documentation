---
title: "Storage accounting"
weight: 35
type: "docs"
description: "Enable Storage Accounting Record (StAR) in your storage element"
---

## Introduction

Storage space usage accounting in APEL is based on the StAR (Storage Accounting
Record) developed during the EMI project in conjunction with the OGF Usage
Record Work Group (UR-WG). The format is documented
[here](http://cds.cern.ch/record/1452920/files/GFD.201.pdf).

EMI delivered StAR solutions for dCache and DPM in EMI-3. In both cases the
storage service queries its database at a site and extracts data to populate
StAR usage records. The site then uses SSM as a transport method to send the
StAR records via the EGI Messaging Service to APEL's central Accounting
Repository.

