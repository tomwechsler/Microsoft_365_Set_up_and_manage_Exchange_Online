Set-Location C:\
Clear-Host

#We need the module (without the parameter for a specific version)
Install-Module -Name ExchangeOnlineManagement -AllowClobber -Force -Verbose

#Let's import the module
Import-Module ExchangeOnlineManagement

#Check the version (if you have not selected a version)
Get-InstalledModule -Name ExchangeOnlineManagement

#Now we connect to Exchange Online
Connect-ExchangeOnline

#This example creates a spam filter policy named Contoso Executives with the following settings
New-HostedContentFilterPolicy -Name "Contoso Executives" -HighConfidenceSpamAction Quarantine -SpamAction Quarantine -BulkThreshold 6

#Create a spam filter rule
New-HostedContentFilterRule -Name "Contoso Executives" -HostedContentFilterPolicy "Contoso Executives" -SentToMemberOf "Contoso Executives Group"

#To return a summary list of all spam filter policies
Get-HostedContentFilterPolicy

Get-HostedContentFilterPolicy -Identity "Contoso Executives" | Format-List

#To view existing spam filter rules
Get-HostedContentFilterRule

Get-HostedContentFilterRule -State Disabled

Get-HostedContentFilterRule -State Enabled

Get-HostedContentFilterRule -Identity "Contoso Executives" | Format-List

#Modify spam filter policies
Set-HostedContentFilterPolicy -Identity "Contoso Executives" <Settings>

#Enable or disable spam filter rules
Disable-HostedContentFilterRule -Identity "Marketing Department"

Enable-HostedContentFilterRule -Identity "Marketing Department"

#Set the priority of spam filter rules
Set-HostedContentFilterRule -Identity "Marketing Department" -Priority 2

#Remove spam filter policies
Remove-HostedContentFilterPolicy -Identity "Marketing Department"

#Remove spam filter rules
Remove-HostedContentFilterRule -Identity "Marketing Department"

#Send a GTUBE message to test your spam policy settings
#Include the following GTUBE text in an email message on a single line, without any spaces or line breaks
XJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34X