---
title: "Getting Started"
dtitle: "Getting Started"
linkTitle: "Getting Started"
type: docs
weight: 10
description: >
  What does a user need to know to try HTC?
---

### Request for information
You can ask for more information about the service at: [here](https://www.egi.eu/more-information/)

### Order EGI HTC service 
You can order EGI HTC service from:
- [EOSC Marketplace](https://marketplace.eosc-portal.eu/services/egi-high-throughput-compute)
- [EGI Marketplace](https://marketplace.egi.eu/32-high-throughput-compute)

#### Payments Model
The payment models of EGI HTC service can:  
- Sponsored use for policy-based access
- [Pay-as-you-go](https://wiki.egi.eu/wiki/VT_EGI_Pay-for-Use_Service/Price_Overview) for market-based access

#### What happens after you place an order
EGI user support team will handle your order within 5 working days.

We normally contact you to have a short virtual meeting in order to better understand your requirements: 
- What is your research project background (science domain, partners countries, user bases, pay-for-use or not, etc.). These will help us identify bester resources matching your needs.
- What is your requirements details (how much CPU cores, RAM per CPU, software services, how long do you need, etc. )

If we are able to support your case, there will be two options:
1. We will try to map you to an existing EGI community VO. Domain specific and regional VOs can be browsed at [Operation Portal](https://operations-portal.egi.eu/vo/). If there is a suitable one, we will contact the VO managers to join you to the VO and grant you the access to the resources attached to that VO.  
2. If there are no suitable VOs existing, we need to create a new VO for your community. The procedure is as follows:
    * We will contact our provider and negotiate resources for you. 
    * If there are providers happy to support you, we will sign SLA with you
    * A new VO will be created for your community

At the same time, we will ask you to get a [EUGridPMA](https://www.eugridpma.org/) Certificate.

### Get a Certificate
[List of EGI recognised CAs](http://www.eugridpma.org/members/worldmap/), as well as detailed information on how to request certificates from a particular CA. Click your country on the map and find your nearby CA, follow the instructions to send a request. 
Once received the request, the CA will have to confirm your authenticity through your certificate. This usually involves a physical meeting or a phone call with a Registration Authority (RA). A RA is delegated by the CA to verify the legitimacy of a request, and approve it if it is valid. The RA is usually someone at your home institute, and will generally need some kind of ID to prove your identity. Many CAs now allow online applications that make the process much easier. There are still CAs requesting physically visiting, in this case, you have to visit the organisation in person with a valid ID.  

More information can be found at [info](https://wiki.egi.eu/wiki/USG_Getting_Certificate#Requesting_the_Certificate). 

#### Install a Certificate
After approval, the certificate is generated and delivered to you. This can be done via e-mail, or by giving instructions to you to download it from a web page. 

##### Browser installation
Install the certificate in your browser. If you don’t know how to upload your certificate in your browser have a look at the [examples](https://ca.cern.ch/ca/Help/).
##### Install a Grid Host Certificate 
To use EGI HTC service/Grid tools, you must save your certificate to disk. 
The received certificate will usually be in one of two formats: 
- _Privacy Enhanced Mail Security Certificate (PEM)_ with extension `.pem` or 
- _Personal Information Exchange File (PKCS12)_ with extensions `.p12` or `.pfx`. 

The latter is the most common for certificates exported from a browser (e.g. Internet Explorer, Mozilla and Firefox), but the `PEM` format is currently needed on EGI user interface. The certificates can be converted from one format to the other using the `openssl` command.
If the certificate is in `PKCS12` format, then it can be converted to `PEM` using `pkcs12` 

1. First you will need to create the private key, use `-nocerts`. Open your desktop terminal, enter the following command: 
`$ openssl pkcs12 -nocerts -in my_cert.p12 -out userkey.pem`

where:

File Name    | Discription
-------------|-------------------------------
my_cert.p12  |is the input PKCS12 format file;  
userkey.pem  |is the output private key file; 
usercert.pem |is the output PEM certificate file.

When prompted to `“Enter Import Password”`, simply press enter since no password should have been given when exporting from keychain.
When prompted to `“Enter PEM pass phrase”`, enter the pass phrase of your choice, e.g. `1234`.

2. Now you can create the certificate, use `-clcerts`,  (use `-nokeys` here will not output private key), and the command is:
`$ openssl pkcs12 -clcerts -nokeys -in my_cert.p12 -out usercert.pem`
When prompted to `“Enter Import Password”`, simply press enter since no password should have been given when exporting from keychain.

For further information on the options of the pkcs12 command, consult
`$ man pkcs12`
It is strongly recommended that the names of all these files are kept as shown.
Once in PEM format, the two files, `userkey.pem` and `usercert.pem`, should be copied to a _User Interface (UI)_. For example, the ‘standard’ location for Mac would be `.globus` directory in your `$HOME`. I.e. `$HOME/.globus/`

More information can be found at: [info](https://ca.cern.ch/ca/Help/)

### Register to a VO 
Visit [Operation Portal](https://operations-portal.egi.eu) with the web-browser containing your personal certificate. Search for existing VOs

1. If there are any community VOs matching your requirements (with _Registry System_ is _VOMS_), then click _Action_-> _Details_ to look at the VO information. In the _VO Id Card_ page, click the link for _Enrollment Url_, it will take you to the VO VOMS page. __You should have already discussed with the EGI support team, they would help you to contact the VO managers and get approval for your access.__  
![Register to a VO](../htc_vo_registeration.png)
1. If there are no relevant VOs, you can send a request [to register a new VO](ttps://operations-portal.egi.eu/vo/registration). (Note, for EGI HTC service, you should request for `VOMS configuration`, once VO is configured, you will be notified about your VO VOMS link). More information can be found at [Guideline for VO registration](https://wiki.egi.eu/wiki/PROC14_VO_Registration). **Again, this is usually guided by the EGI support team. You should already have a meeting with them to discuss your requirements. They will help you to get resources from EGI HTC providers, and sign [SLA](https://wiki.egi.eu/wiki/EGI_OLA_SLA_framework#Service_Level_Agreemens) with you.** 
1. Request your VO membership at VO VOMS page. You will have to enter required information and then wait for approval. For example, you can [register to the EGI catch-all vo _fedcloud.egi.eu_](https://perun.metacentrum.cz/perun-registrar-cert/?vo=fedcloud.egi.eu):
![Register to fedcloud vo](../htc_regiter_fedcloud_vo.png)

### First job submission 
#### Creating a X.509 proxy certificate
Once you have the VO information configured (`vomses` and `.lsc`) and your certificate available in your `$HOME/.globus` directory you can create a VOMS proxy to be used with clients with:

`voms-proxy-init --voms <name of the vo>`

#### Job Submission using EGI Workload Manager Service
[Workload Manager](https://www.egi.eu/services/workload-manager/) services act as brokers for the computing resources. The current EGI workload manager service is based on DIRAC technology. The Distributed Infrastructure with Remote Agent Control (DIRAC) project, http://diracgrid.org , which was originally developed for distributing data from the LHCb project at CERN. DIRAC is an interware, mostly written in Python, that provides command-line, web and API interfaces to grid computing and storage resources.

##### DIRAC4EGI Web Portal 
The EGI Woakload Manager (old name DIRAC4EGI), is an EGI instance of DIRAC service. To connect to the web portal, browse to https://dirac.egi.eu/DIRAC/. 

![DIRAC4EGI web portal](../dirac4egi_web_portal.png)
- If you are a new user, you can see the welcome page where you can find links to [user documentations](https://dirac.readthedocs.io/en/latest/UserGuide/WebAppUserGuide/index.html).
- _VO options_: you can switch to different VOs that you have membership
- _Log In options_: the service supports both X509. Certificate and Check-in log-in
- _View options_: allow to choose either desktop or tabs layout
- _Menu_: a list of tools that enable to the selected VO

###### Upload Proxy
Before submitting your job, you need to upload your Proxy. Go to _Menu_ -> _Tools_ -> _Proxy Upload_, enter your certificates `.p12` file and the pass, click _Upload_.

![DIRAC4EGI upload proxy](../dirac4egi_upload_proxy.png)

###### Job Submission
Go to _Menu_ -> _Tools_ -> _Job Launchpad_.  First check the _Proxy Status_, click it until it shows `Valid` in green color. In the Job Launchpad, you can select your jobs from the list; add parameters, indicating the output Sandbox location. Now, select _Helloworld_ from the  job list, and click _Submit_, you just launch your very first job to EGI HTC cluster. 

![DIRAC4EGI job submission](../dirac4egi_job_submission.png)

###### Monitor Job status
Go to _Menu_ -> _Applications_ -> _Job Monitor’. The left panel gives all kinds of search options for your jobs. Set your search criteria, and click ‘Submit’, the jobs will list on the right panel. Try the various options to view different information about the jobs.
![DIRAC4EGI Job monitoring](../dirac4egi_job_monitoring.png)

###### Get Results from Sandbox
On the _Job Monitor_ panel, once the job has been successfully processed, the _Status_ of the job will change to green. Right click the job, select _Sandbox_ -> _Get Output file(s)_, you can get the result file(s).

###### Full User Guide for DIRAC Web Portal
For further instructions, please refer to [DIRAC Web Portal Guide](https://dirac.readthedocs.io/en/latest/UserGuide/WebAppUserGuide/index.html)

##### DIRAC Client Tool
Download the DIRAC Client installation script
```{.console}
$ mkdir DIRAC
$ cd DIRAC/
$ curl https://raw.githubusercontent.com/DIRACGrid/DIRAC/integration/Core/scripts/dirac-install.py -o dirac-install
...
$ chmod +x dirac-install
```

DIRAC team prepared default settings for the VOs that requested to use the service. Run the script using the EGI default configuration:

`$ ./dirac-install -V egi`

Once the client software is installed, it should be configured in order to access the DIRAC4EGI service

`$ source bashrc`

__Note__:  This procedure is no longer valid for Mac.  The only way you can run the client DIRAC on a Mac is to use it with a [Docker container](https://docs.docker.com/docker-for-mac/install/). Once the Docker container is installed on your Mac you can run the DIRAC client, for example, in the following way:
 ```{.console}
$ docker run -it -v $HOME/.globus:/root/.globus -v $HOME:$HOME diracgrid/client:egi /bin/bash
$ source /opt/dirac/bashrc
```
 
After that you have a shell with the DIRAC environment.

To proceed further a temporary proxy of the user certificate should be created. This is necessary to get information from the central Configuration Service:

`$ dirac-proxy-init -x`

Now the client can be configured to work in conjunction with the DIRAC4EGI service

`$ dirac-configure defaults-egi.cfg`

Generate the proxy containing the credentials of your VO. Specify the VO in the `--group` option:

`$ dirac-proxy-init --debug --group fedcloud_user -U --rfc`

Submit the job:

`$ dirac-wms-job-submit my_job.jdl`

Basically, a job file is a JDL file, e.g. `my_job.jdl. `
```{.console}
[ 	
  JobName = "Simple_Job";
  Executable = "/bin/ls";
  Arguments = "-ltr";
  StdOutput = "StdOut";
  StdError = "StdErr";
  OutputSandbox = {"StdOut","StdErr"};
] 
 ```
More information about JDL Language and simple job Management can be found at: [JDL and Job Management](https://dirac.readthedocs.io/en/latest/UserGuide/Tutorials/JDLsAndJobManagementBasic/index.html)

Check the job status
```{.console}
$ dirac-wms-job-status 53039045`
$ JobID=53039045 Status=Waiting; MinorStatus=Pilot Agent Submission; Site=ANY;
```
For other comments, check the full DIRAC [workload management comments list](https://dirac.readthedocs.io/en/latest/UserGuide/CommandReference/WorkloadManagement/index.html) 

##### Technical Support 
- The full DIRAC User Guide: https://dirac.readthedocs.io/en/latest/UserGuide/
- For technical issue and bug report, please submit a ticket in [helpdesk.egi.eu](https://ggus.eu/?mode=ticket_submit), in the _Assign to support unit_, indicate _Workload Manager (DIRAC)_ 


