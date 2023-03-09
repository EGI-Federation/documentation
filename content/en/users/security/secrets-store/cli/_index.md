---
title: Secrets Store Command-Line Interface
linkTitle: Command Line
type: docs
weight: 20
description: >
  Command-line interfaces for accessing EGI Secrets Store
---

Multiple tools and command-line interfaces are available for accessing and
working with EGI Secrets Store.

The [FedCloud client](#access-via-fedcloud-client)
is strongly recommended as it is tightly integrated with the service, it works
out of the box without additional configuration, has a simple syntax and
supports advanced features such as client-side encrypted secrets.

The [Hashicorp Vault client](#access-via-vault-client) can be used to access
advanced Vault features not exposed via other tools.

## Prerequisites

To access the EGI Secrets Store service from the command-line you need a valid
[EGI Check-in](../../../aai/check-in) access token. Get it either from the
[EGI Check-in Token Portal](https://aai.egi.eu/token), or from the
**oidc-agent** (see [here](../../../getting-started/cli#authentication) for
details), then set it to an environment variable:

{{< tabpanex >}} {{< tabx header="Mac / Linux" >}}

```shell
$ export OIDC_ACCESS_TOKEN=<token>
```

{{< /tabx >}} {{< tabx header="Powershell" >}}

```powershell
> $env:OIDC_ACCESS_TOKEN="<token>"
```

{{< /tabx >}} {{< tabx header="Windows" >}}

```shell
> set OIDC_ACCESS_TOKEN=<token>
```

{{< /tabx >}}{{< /tabpanex >}}

## Access via FedCloud client

The [FedCloud client](../../../getting-started/cli) is integrated with the EGI
Secrets Store service, so that users can access the service immediately with
simple commands. Below is a quickstart to using the service.

### Basic usage

Let's assume you want to create a secret `my_app_secrets` and store passwords
for two services in it:

{{< tabpanex >}} {{< tabx header="Mac / Linux" >}}

```shell
$ fedcloud secret put my_app_secrets \
       mysql_password=123456 \
       redis_password=abcdef
```

{{< /tabx >}} {{< tabx header="Powershell" >}}

```powershell
> fedcloud secret put my_app_secrets `
       mysql_password=123456 `
       redis_password=abcdef
```

{{< /tabx >}} {{< tabx header="Windows" >}}

```shell
> fedcloud secret put my_app_secrets ^
       mysql_password=123456 ^
       redis_password=abcdef
```

{{< /tabx >}}{{< /tabpanex >}}

Listing all your secrets is very simple:

```shell
$ fedcloud secret list
my_app_secrets
```

Using any of the keys (actually, their values) is straightforward too:

{{< tabpanex >}} {{< tabx header="Mac / Linux" >}}

```shell
# Get all keys and their values
$ fedcloud secret get my_app_secrets
key             value
--------------  -------
redis_password  abcdef
mysql_password  123456

# Get the value of a specific key from a secret
$ fedcloud secret get my_app_secrets mysql_password
123456

# Using the value of a specific key from a secret
$ export ADMIN_PASSWORD=$(fedcloud secret get my_app_secrets admin_password)
$ echo $ADMIN_PASSWORD
abcdef
```

{{< /tabx >}} {{< tabx header="Powershell" >}}

```powershell
# Get all keys and their values
> fedcloud secret get my_app_secrets
key             value
--------------  -------
redis_password  abcdef
mysql_password  123456

# Get the value of a specific key from a secret
> fedcloud secret get my_app_secrets mysql_password
123456

# Using the value of a specific key from a secret
> $env:ADMIN_PASSWORD=$(fedcloud secret get my_app_secrets admin_password)
> echo $env:ADMIN_PASSWORD
abcdef
```

{{< /tabx >}} {{< tabx header="Windows" >}}

```shell
:: Get all keys and their values
> fedcloud secret get my_app_secrets
key             value
--------------  -------
redis_password  abcdef
mysql_password  123456

:: Get the value of a specific key from a secret
> fedcloud secret get my_app_secrets mysql_password
123456

:: Using the value of a specific key from a secret
> set ADMIN_PASSWORD=(fedcloud secret get my_app_secrets admin_password)
> echo %ADMIN_PASSWORD%
abcdef
```

{{< /tabx >}}{{< /tabpanex >}}

Deleting a secret is easy, but it is irreversible:

```shell
$ fedcloud secret delete my_app_secrets
```

### Secret values from small text files

If the secret value starts with `@` the content of the file with that name is
used as the value of the key. The following example creates a secret named
`certificate` for storing the certificate file and its keyfile:

```shell
$ fedcloud secret put certificate cert=@hostcert.pem key=@hostkey.pem
```

You can get the certificate and its keyfile (e.g. when you want to use it on a
virtual machine) as follows:

```shell
$ fedcloud secret get certificate cert > hostcert.pem
$ fedcloud secret get certificate key  > hostkey.pem
```

{{% alert title="Note" color="info" %}} The size of the secret object (all the
values in it) is limited to 512kB, which is sufficient for storing tokens,
certificates, configuration files and so on. For larger datasets, please use
[encrypted cloud storage](../../../data/storage/block-storage#storage-encryption).
{{% /alert %}}

### Secret values from small binary files

It is recommended to store secret values as text for compatibility and ease of
manipulation. However, the FedCloud client supports storing small binary files
as secret values by encoding/decoding the binary data to ASCII via base64.

Add option `--binary-file` or `-b` when using binary files as the secret value:

```shell
$ fedcloud secret put secret-image image=@secret-image.png -b
$ fedcloud secret get secret-image image -b > received-image.png
```

### Modifying existing secrets

Secret values in secret objects cannot be edited individually. However, you
can get the contents of existing secret objects, change them locally, and put
the new contents back, overwriting the old secret. Some examples are shown
below.

{{% alert title="Important" color="warning" %}} You will probably want to
take care of securely disposing of the local temporary file(s) involved in
the update. Omitted here for brevity.{{% /alert %}}

{{< tabpanex >}} {{< tabx header="Mac / Linux" >}}

For a secret named `certificate` containing two keys named `cert` and `key`:

```shell
$ fedcloud secret get certificate
key             value
--------------  -------
cert            ...
key             ...
```

To add new values to an existing secret:

```shell
$ fedcloud secret get certificate -f json > certificate.json
$ fedcloud secret put certificate @certificate.json \
            another_cert=@usercert.pem \
            another_key=@userkey.pem
```

To delete values from an existing secret:

```shell
$ fedcloud secret get certificate -f json | 
            jq 'del (.another_cert, .another_key)' \
            > certificate.json
$ fedcloud secret put certificate @certificate.json
```

To replace existing values in an existing secret:

```shell
$ fedcloud secret get certificate -f json > certificate.json
$ fedcloud secret put certificate @certificate.json \
            cert=@new_hostcert.pem \
            key=@new_hostkey.pem
```

{{< /tabx >}} {{< tabx header="Powershell" >}}

For a secret named `certificate` containing two keys named `cert` and `key`:

```powershell
> fedcloud secret get certificate
key             value
--------------  -------
cert            ...
key             ...
```

To add new values to an existing secret:

```powershell
> fedcloud secret get certificate -f json > certificate.json
> fedcloud secret put certificate @certificate.json `
            another_cert=@usercert.pem `
            another_key=@userkey.pem
```

To delete values from an existing secret:

```powershell
$ fedcloud secret get certificate -f json | ` 
            jq 'del (.another_cert, .another_key)' `
            > certificate.json
$ fedcloud secret put certificate @certificate.json
```

To replace existing values in an existing secret:

```powershell
$ fedcloud secret get certificate -f json > certificate.json
$ fedcloud secret put certificate @certificate.json `
            cert=@new_hostcert.pem `
            key=@new_hostkey.pem
```

{{< /tabx >}} {{< tabx header="Windows" >}}

For a secret named `certificate` containing two keys named `cert` and `key`:

```shell
> fedcloud secret get certificate
key             value
--------------  -------
cert            ...
key             ...
```

To add new values to an existing secret:

```shell
> fedcloud secret get certificate -f json > certificate.json
> fedcloud secret put certificate @certificate.json ^
            another_cert=@usercert.pem ^
            another_key=@userkey.pem
```

To delete values from an existing secret:

```shell
> fedcloud secret get certificate -f json ^
            | jq 'del (.another_cert, .another_key)' ^
            > certificate.json
> fedcloud secret put certificate @certificate.json
```

To replace existing values in an existing secret:

```shell
> fedcloud secret get certificate -f json > certificate.json
> fedcloud secret put certificate @certificate.json ^
            cert=@new_hostcert.pem ^
            key=@new_hostkey.pem
```

{{< /tabx >}}{{< /tabpanex >}}

### Export and import secrets

FedCloud client can output secrets in [YAML](https://yaml.org) or
[JSON](https://json.org) format for further processing when using option
`--output-format` or `-f`:

```shell
$ fedcloud secret get my_secrets -f json
$ fedcloud secret get my_secrets -f yaml > my_secrets.yaml
```

The YAML or JSON files created by FedCloud client can be imported back into EGI
Secrets Store by using a single key and adding `@` before its name, followed by
the filename to load the value(s) from:

```shell
$fedcloud secret put my_other_secrets @my_other_secrets.yaml
```

As the YAML format is a superset of JSON, it is expected by default, unless the
filename has _.json_ extension. Try to export your secrets to both formats to
see the differences between them.

Importing secret objects from files in text format with `key=value` lines is
not supported, as the format is error-prone, especially for multi-line secret
values or values with special characters. You can replace `=` with `:` for
converting simple text files to YAML files.

{{% alert title="Tip" color="info" %}} Do not forget that in YAML files a
blank space is required after the `:` separating keys and values.{{% /alert %}}

{{% alert title="Note" color="info" %}} There is a difference between
`cert=@hostcert.pem` for reading the content of the file _hostcert.pem_ as
the value for the key `cert`, and `@my_secrets.yaml` for reading the whole
secret object with all key:value pairs from the YAML file.{{% /alert %}}

### Client-side encrypted secrets

EGI Secret Store encrypts secret objects both in transit and at rest. For
highly-sensitive secrets, you can opt to also encrypt your secret values
on the client-side, before storing them in EGI Secrets Store.

The client-side encryption is done on the fly by the FedCloud client if an
encryption key (passphrase) is provided via option `--encrypt-key` or `-e`:

```shell
$ fedcloud secret put sensitive data=@sensitive-data.txt -e password
```

Decryption is done in a similar way, just by providing the passphrase via
option `--decrypt-key` or `-d`. The secret values will be decrypted on the fly
if the passphrase is correct:

```shell
$ fedcloud secret get sensitive data -d password
```

{{% alert title="Note" color="info" %}} Only secret values are encrypted, not
the (names of) the keys.{{% /alert %}}

Verifying what is actually stored in a secret can be done without providing
the passphrase:

```shell
$ fedcloud secret get sensitive data
gAAAAAB...............................
```

{{% alert title="Note" color="info" %}} The encryption/decryption is done with
the standard Python cryptography library. Security experts are invited to review
the code (available on
[GitHub](https://github.com/tdviet/fedcloudclient/blob/master/fedcloudclient/secret.py#L159))
and provide feedback and suggestions for improvements.{{% /alert %}}

### Reading data from standard inputs

Reading data from `stdin` may help in creating shorter scripts and to avoid
storing secrets in intermediate files on disk, for security reasons. The symbol
`-` in input parameters means the data will be read from the standard input in
the same way as `@` can be used to read from files. For example:

To read entire secret from standard input, which must to be in JSON or YAML
format:

```shell
$ echo '{"mysql_pwd":"123"}' | fedcloud secret put my_secrets -
```

To read only a secret value from standard input:

```shell
$ echo "abcdef" | fedcloud secret put my_secrets admin_password=-
```

To copy a secret object export it to JSON, then import it as a new copy:

```shell
$ fedcloud secret get my_secrets -f json |
  fedcloud secret put my_secret_copy -
```

To add new values to an existing secret, without using intermediate files:

{{< tabpanex >}} {{< tabx header="Mac / Linux" >}}

```shell
$ fedcloud secret get certificate -f json |
  fedcloud secret put certificate - \
              another_cert=@usercert.pem \
              another_key=@userkey.pem
```

{{< /tabx >}} {{< tabx header="Powershell" >}}

```powershell
> fedcloud secret get certificate -f json | `
  fedcloud secret put certificate - `
              another_cert=@usercert.pem `
              another_key=@userkey.pem
```

{{< /tabx >}} {{< tabx header="Windows" >}}

```shell
> fedcloud secret get certificate -f json | ^
  fedcloud secret put certificate - ^
              another_cert=@usercert.pem ^
              another_key=@userkey.pem
```

{{< /tabx >}}{{< /tabpanex >}}

## Access via Vault client

To access EGI Secrets Store using the Vault client, visit the
[Vault project's site](https://www.vaultproject.io/downloads), download the
correct version for your operating system, and install it.

{{< tabpanex >}} {{< tabx header="Mac" >}}

To install the Vault client:

```shell
$ brew tap hashicorp/tap
$ brew install hashicorp/tap/vault
```

{{< /tabx >}} {{< tabx header="Ubuntu / Debian" >}}

To install the Vault client:

```shell
$ wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
$ echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
$ sudo apt update && sudo apt install vault
```

{{< /tabx >}} {{< tabx header="CentOS / RHEL" >}}

To install the Vault client:

```shell
$ sudo yum install -y yum-utils
$ sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
$ sudo yum -y install vault
```

{{< /tabx >}} {{< tabx header="Amazon Linux" >}}

To install the Vault client:

```shell
$ sudo yum install -y yum-utils shadow-utils
$ sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
$ sudo yum -y install vault
```

{{< /tabx >}} {{< tabx header="Fedora" >}}

To install the Vault client:

```shell
$ sudo dnf install -y dnf-plugins-core
$ sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
$ sudo dnf -y install vault
```

{{< /tabx >}}{{< /tabpanex >}}

To create/read secrets and to manage the EGI Secrets Store service, you
need a Vault token. You can get one from your EGI Check-in access token.

{{< tabpanex >}} {{< tabx header="Mac / Linux" >}}

To get a Vault token:

```shell
$ export VAULT_ADDR=https://vault.services.fedcloud.eu:8200
$ export VAULT_TOKEN=$(vault write auth/jwt/login jwt=$OIDC_ACCESS_TOKEN |
           grep -Po 'token\s+\K[^\s]+$')
```

{{< /tabx >}} {{< tabx header="Powershell" >}}

To get a Vault token:

```powershell
> $env:VAULT_ADDR="https://vault.services.fedcloud.eu:8200"
> $env:VAULT_TOKEN=$(vault write auth/jwt/login jwt=$env:OIDC_ACCESS_TOKEN `
           | Select-String -Pattern "(?<=token\s+)[^\s]+(?=$)" `
           | %{$_.Matches.value})
```

{{< /tabx >}} {{< tabx header="Windows" >}}

To get a Vault token:

```shell
> set VAULT_ADDR=https://vault.services.fedcloud.eu:8200
> for /f "delims=" %a in ('vault write auth/jwt/login "jwt=%OIDC_ACCESS_TOKEN%" ^| findstr /r /c:"token[ ][ ]*[^^ ]*"') do @set VAULT_TOKEN=%a:token=%
> set VAULT_TOKEN=%VAULT_TOKEN: =%
```

{{< /tabx >}}{{< /tabpanex >}}

For convenience, add the path to your secret space to an environment
variable:

{{< tabpanex >}} {{< tabx header="Mac / Linux" >}}

```shell
$ export VAULT_HOME=/secrets/$(curl -X POST https://aai.egi.eu/auth/realms/egi/protocol/openid-connect/userinfo -H "Authorization: Bearer $OIDC_ACCESS_TOKEN" | jq -r .voperson_id)
```

{{< /tabx >}} {{< tabx header="Powershell" >}}

```powershell
> $env:VAULT_HOME=/secrets/$(curl -X POST https://aai.egi.eu/auth/realms/egi/protocol/openid-connect/userinfo -H "Authorization: Bearer $env:OIDC_ACCESS_TOKEN" | jq -r .voperson_id)
```

{{< /tabx >}} {{< tabx header="Windows" >}}

```shell
> for /f "delims=" %a in ('curl -X POST https://aai.egi.eu/auth/realms/egi/protocol/openid-connect/userinfo -H "Authorization: Bearer %OIDC_ACCESS_TOKEN%" ^| jq -r .voperson_id') do set VAULT_HOME="/secrets/%a"
```

{{< /tabx >}}{{< /tabpanex >}}

### List secrets

After setting the environment variables `VAULT_TOKEN` and `VAULT_HOME`, you can
list the secrets in your personal secret space:

{{< tabpanex >}} {{< tabx header="Mac / Linux" >}}

To list your secrets:

```shell
$ vault list $VAULT_HOME
```

{{< /tabx >}} {{< tabx header="Powershell" >}}

To list your secrets:

```powershell
> vault list $env:VAULT_HOME
```

{{< /tabx >}} {{< tabx header="Windows" >}}

To list your secrets:

```shell
> vault list %VAULT_HOME%
```

{{< /tabx >}}{{< /tabpanex >}}

### Create secret

To create a new secret named `test` in your personal secret space, containing a
key `my-key` having the value `test value` use the command below.

{{% alert title="Important" color="warning" %}} The command below will replace,
without warning, a previous secret named `test`, including all its keys, with a
new one that will only include the keys you provide as part of the command.
{{% /alert %}}

{{< tabpanex >}} {{< tabx header="Mac / Linux" >}}

To create or update a secret:

```shell
$ vault write $VAULT_HOME/test "my-key=test value" db-pass=1234
```

{{< /tabx >}} {{< tabx header="Powershell" >}}

To create or update a secret:

```powershell
> vault write $env:VAULT_HOME/test "my-key=test value" db-pass=1234
```

{{< /tabx >}} {{< tabx header="Windows" >}}

To create or update a secret:

```shell
> vault write %VAULT_HOME%/test "my-key=test value" db-pass=1234
```

{{< /tabx >}}{{< /tabpanex >}}

{{% alert title="Tip" color="info" %}} Use quotes if the key or value includes
whitespaces. You can include in the same quote both the key and the value.
{{% /alert %}}

{{% alert title="Note" color="info" %}} You can add as many key to a secret as
needed, but keep in mind that they will always be handled (read, written, or
deleted) atomically.{{% /alert %}}

### Read secret

To read a secret named `test` from your personal secret space use the commands
below.

{{< tabpanex >}} {{< tabx header="Mac / Linux" >}}

To read all keys from a secret:

```shell
$ vault read $VAULT_HOME/test
Key                 Value
---                 -----
refresh_interval    768h
my-key              test value
db-pass             1234
```

To read specific keys from a secret:

```shell
$ vault read -field="my-key" $VAULT_HOME/test
test value
```

{{< /tabx >}} {{< tabx header="Powershell" >}}

To read all keys from a secret:

```powershell
> vault read $env:VAULT_HOME/test
Key                 Value
---                 -----
refresh_interval    768h
my-key              test value
db-pass             1234
```

To read specific keys from a secret:

```powershell
$ vault read -field="my-key" $env:VAULT_HOME/test
test value
```

{{< /tabx >}} {{< tabx header="Windows" >}}

To read all keys from a secret:

```shell
> vault read %VAULT_HOME%/test
Key                 Value
---                 -----
refresh_interval    768h
my-key              test value
db-pass             1234
```

To read specific keys from a secret:

```shell
$ vault read -field="my-key" %VAULT_HOME%/test
test value
```

{{< /tabx >}}{{< /tabpanex >}}

{{% alert title="Tip" color="info" %}} Alternative commands `kv put` and
`kv get` exist for `vault write` and `vault read`. Be sure to check out the
[full list of Vault commands](https://www.vaultproject.io/docs/commands)
for more information.{{% /alert %}}
