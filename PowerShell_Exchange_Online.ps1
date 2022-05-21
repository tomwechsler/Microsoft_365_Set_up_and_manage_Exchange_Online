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

#To see the values of these organizational limits
Get-TransportConfig | Format-List

Get-TransportConfig | Select-Object ExternalPostmasterAddress

(Get-TransportConfig).ExternalPostmasterAddress

#This example sets the external postmaster address to the value:support@cloudgrid.ch
Set-TransportConfig -ExternalPostmasterAddress support@cloudgrid.ch

#Did it work?
Get-TransportConfig | Format-List ExternalPostmasterAddress

#This example returns the external postmaster address to the default value
Set-TransportConfig -ExternalPostmasterAddress $null

#Did it work?
Get-TransportConfig | Format-List ExternalPostmasterAddress

#Let's look at the settings of the organization for SendFromAliasEnabled
Get-OrganizationConfig | Format-List

Get-OrganizationConfig | Select-Object SendFromAliasEnabled

(Get-OrganizationConfig).SendFromAliasEnabled

#Enable Send from Alias in Microsoft 365 tenant
Set-OrganizationConfig -SendFromAliasEnabled $True

#Did it work?
(Get-OrganizationConfig).SendFromAliasEnabled

#When the sender adds a distribution group that has more members than the configured large audience size, they are shown the Large Audience MailTip
#Let's look at the settings of the organization for MailTipsLargeAudienceThreshold
Get-OrganizationConfig | Format-List

(Get-OrganizationConfig).MailTipsLargeAudienceThreshold

#We set the value to 5
Set-OrganizationConfig -MailTipsLargeAudienceThreshold 5