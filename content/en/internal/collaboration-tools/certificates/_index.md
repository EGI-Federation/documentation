---
title: "Certificates"
type: docs
weight: 20
description: Certificate provisioning
---

EGI Foundation is having access to a
[GÉANT Trusted Certificate Service](https://wiki.geant.org/display/TCSNT/)
subscription.

Sectigo is the current Certificate Authority (CA) providing certificates to
GÉANT TCS.

This can be used to issue IGTF-trust (AKA eScience certificates) and
public-trust certificates, for the domains managed by EGI Foundation, like
`egi.eu`.

Operators of central services can request two types of certificates:

- host certificates, with public-trust, and optionally IGTF trust.
- robot email certificates, to be used as client certificate, to authenticate
  using X509 as a service.

> In some specific cases, like for
> [Cloud Compute providers](../../../providers/cloud-compute/) not having access
> to an IGTF CA, it's possible for them to request a robot certificate, as an
> IGTF certificate is required for sending accounting records.

You can contact scs-ra@egi.eu (or operations@egi.eu) if you need support.

## Requesting a new certificate

Open a ticket to Collaboration Tools SU in [EGI Helpdesk](../../helpdesk),
providing:

- Justification of the request.
- Type of certificate (host or robot).
- FQDN of the service.
- Mailing list to be used as contact address that will receive
  [renewal notifications](#renewing-certificates).
- For host certificates: a
  [Certificate Signing Request](#creating-a-certificate-signing-request), or
  mentioning the desire to use the [ACME protocol](#using-acme-protocol).

An operator will follow with the request, and help you getting the certificate.

## Retrieving certificates

- Host certificates will be sent by email, you will receive a notification with
  links allowing to download it.
- For robot certificates, you will receive an invitation by email allowing to
  generate and retrieve it.

## Renewing certificates

Certificates are usually valid for one year. Auto-renewal of certificates is
enabled by default, 30 days before expiration, notifications will be sent to the
contact address provided when requesting the certificate.

The notifications contain links allowing to renew the certificate.

## Creating a Certificate Signing Request

In order to get a certificate, Service Providers may be requested to send a
Certificate Signing Request (CSR).

In the CSR only the Common Name (CN) is important, it should be the (FQDN) of
the service Most of other fields will be replaced by the CA while generating the
certificate.

It can be done via different ways, some are documented below.

### Using a web application

DigiCert provides an online
[web application](https://www.digicert.com/easy-csr/openssl.htm).

### Using CloudFlare cfssl tool

It can be done with the `cfssl` tool from
[CloudFlare](https://github.com/cloudflare/cfssl).

```shell
# Replace #FQDN# by the FQDN of the service
$ cfssl genkey <(echo '{"hosts":["#FQDN#"],"CN"#FQDN#","key":{"algo":"rsa","size":4096}}')
  | cfssljson -bare ##FQDN##.rsa
```

### Using OpenSSL

It can be done using the following `OpenSSL` command (This will generate a
password-protected key.

You will be asked for various questions, but the only important ones are the
Common Name (CN) and Subject Alternative Names (SAN) (in case you want to
request a certificates covering different FQDNs), as other values will be
overwritten by the CA.

```shell
$ openssl req -out CSR.csr -new -newkey rsa:4096 -keyout privateKey.key
```

> Adding the `-nodes` option will disable password protection for the key,
> beware if using it.

### Using ACME protocol

It is possible to automate the certificate request and renewal using the
[ACME protocol](https://datatracker.ietf.org/doc/html/rfc8555) via
[certbot](https://certbot.eff.org/) or similar tools.

Two things should be considered:

- it's not yet possible to get eScience/IGTF-trusted certificates, it's on the
  roadmap but without any firm ETA.
- it's using a different intermediate CA from Sectigo, not the usual GEANT one
  used for TCS, but this shouldn't have much impact for generic/non-eScience
  public services.

The EGI SDIS team will have to create and register an ACME client ID for you.

Once you will have the credential it should be possible to request a
certificate, using the [standard certbot client](https://certbot.eff.org/), as
documented below.

#### Registering the client and saving the credentials locally

This will interactively register your certbot client. Even if the ACME
credentials are shared, only a given client is able to manage the certificates
it requested. Email address is used for urgent renewal and security notices.
This is preferred way if you need to get notifications on certificate expiration
and if you are doing some manual management or testing.

```shell
$ sudo certbot register --no-eff-email \
   --server https://acme.sectigo.com/v2/OV \
   --eab-kid <EAB_KID> \
   --eab-hmac-key <EAB_HMAC_KEY> \
    --email <CONTACT_EMAIL>

# Checking existing account
$ sudo certbot show_account --server https://acme.sectigo.com/v2/OV

# Unregistering an account
# Beware: you won't any more be able to revoke certificate issued with the account
$ sudo certbot unregister --server https://acme.sectigo.com/v2/OV
```

##### Requesting a certificate

```shell
$ sudo certbot certonly --standalone --non-interactive \
   --server https://acme.sectigo.com/v2/OV \
   --domain fakedomaindonotexist.egi.eu
```

##### Revoking a certificate

```shell
$ sudo certbot revoke \
   --server https://acme.sectigo.com/v2/OV \
   --cert-name fakedomaindonotexist.egi.eu
```

#### Registering and requesting a certificate all at once

This is useful when you don't want interactive registration, like for one shot
scripts. Email address is used for urgent renewal and security notices.

> Apparently the notification to use this email is not visible in cert-manager,
> and the first option with explicit registration may be safer to get the
> notifications, if it's a required feature.

```shell
$ sudo certbot certonly --standalone --non-interactive --agree-tos \
   --server https://acme.sectigo.com/v2/OV \
   --eab-kid <EAB_KID> --eab-hmac-key <EAB_HMAC_KEY> \
   --rsa-key-size 4096 \
   --email <CONTACT_EMAIL> \
   --domain fakedomaindonotexist.egi.eu
```

Other usual certbot options should also work. You may also be able to use other
tools that can speak the ACME protocol, it should be standard.
