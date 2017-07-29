# biztalk-provisioner
Automated provisioner for BizTalk Server.

## Notes

### Needs to run on Windows + Powershell

Many steps of the Vagrantfile require Powershell, so do not run this Vagrantfile on Linux or Cygwin. Ideally you should use Powershell to run `vagrant up`.

## Troubleshooting

### Error: "Unencrypted traffic is currently disabled in the client configuration"

If you encounter this error during provisioning:

```
[ec2-13-126-116-43.ap-south-1.compute.amazonaws.com] Connecting to remote server ec2-13-126-116-43.ap-south-1.compute.amazonaws.com failed with the
following error message : The WinRM client cannot process the request. Unencrypted traffic is currently disabled in the client configuration. Change the client
configuration and try the request again. For more information, see the about_Remote_Troubleshooting Help topic.
```

First [enable Powershell Remoting](https://technet.microsoft.com/en-us/library/ff700227.aspx) on your client machine.

**Note:** For Powershell remoting to be configured correctly, your client machine's Network Type needs to be set to Domain or Private.

Else you will encounter this error:

```
PS C:\Users\savis\work\agilityroots\biztalk-provisioner> winrm quickconfig
WinRM firewall exception will not work since one of the network connection types on this machine is set to Public. Change the network connection type to either Domain or Private and try again.
```

Next, execute the following commands. This will enable Unencrypted Traffic. *Note: only for development purposes.*

[reference.](https://stackoverflow.com/a/1473707/682912)

```
PS C:\Users\savis\work\agilityroots\biztalk-provisioner> cd WSMan:\
PS WSMan:\> cd .\localhost\Client\
PS WSMan:\localhost\Client> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Client

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   NetworkDelayms                                 5000
System.String   URLPrefix                                      wsman
System.String   AllowUnencrypted                               false
Container       Auth
Container       DefaultPorts
System.String   TrustedHosts                                   ec2-13-126-116-43.ap-south-1.compute.amazonaws.com


PS WSMan:\localhost\Client> Set-Item .\AllowUnencrypted $true
PS WSMan:\localhost\Client> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Client

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   NetworkDelayms                                 5000
System.String   URLPrefix                                      wsman
System.String   AllowUnencrypted                               true
Container       Auth
Container       DefaultPorts
System.String   TrustedHosts                                   ec2-13-126-116-43.ap-south-1.compute.amazonaws.com
```
