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


#Use the New-DistributionGroup cmdlet to create distribution groups and mail-enabled security groups.
#This example creates a mail-enabled security group named Managers without specifying any members
New-DistributionGroup -Name "Managers" -Type "Security"

#This example creates a distribution group named ITDepartment and specifies the members.
New-DistributionGroup -Name "ITDepartment" -Members chris@cloudgrid.ch,michelle@cloudgrid.ch,laura@cloudgrid.ch,julia@cloudgrid.ch

#The IgnoreNamingPolicy switch specifies whether to prevent this group from being affected by your organization's group naming policy
New-DistributionGroup -Name "Verteiler-Alle" -IgnoreNamingPolicy


#Configure the external postmaster address in Exchange Online
#Let's look at the values of the Organization
Get-TransportConfig | Format-List

#Is there a value at ExternalPostmasterAddress
Get-TransportConfig | Select-Object ExternalPostmasterAddress

#No value means that the postmaster address is used
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


#Change how long permanently deleted items are kept
#Let's look at Jon's Mailbox
Get-Mailbox -Identity "jon.prime" | Select-Object RetainDeletedItemsFor

#Set Jon Prime's mailbox to keep deleted items for 30 days
Set-Mailbox -Identity "jon.prime" -RetainDeletedItemsFor 30

#Did it work?
Get-Mailbox -Identity "jon.prime" | Select-Object RetainDeletedItemsFor

#Set all user mailboxes in the organization to keep deleted items for 30 days
Get-Mailbox -ResultSize unlimited -Filter "RecipientTypeDetails -eq 'UserMailbox'" | Set-Mailbox -RetainDeletedItemsFor 30

#Did it work?
Get-Mailbox -ResultSize unlimited -Filter "RecipientTypeDetails -eq 'UserMailbox'" | Format-List Name,RetainDeletedItemsFor

#But what about the mailboxes that are newly created?
#Let's take a look at the mailbox plans
Get-MailboxPlan | Format-Table -AutoSize

#What is the value in these plans?
Get-MailboxPlan | Select-Object Name, RetainDeletedItemsFor

#Let us now set the value to 30 for all plans
Get-MailboxPlan | Set-MailboxPlan -RetainDeletedItemsFor 30

#Did it work?
#Now when a new mailbox is created, the deleted objects are kept for 30 days
Get-MailboxPlan | Select-Object Name, RetainDeletedItemsFor


#Enable plus addressing in Exchange Online
#Is this function already activated?
Get-OrganizationConfig | Select-Object AllowPlusAddressInRecipients

#To enable plus addressing in your organization
Set-OrganizationConfig -AllowPlusAddressInRecipients $true

#Did it work?
Get-OrganizationConfig | Select-Object AllowPlusAddressInRecipients


#Configure Focused Inbox for everyone in your organization
#What is the current value? No value is returned, the feature is active
Get-OrganizationConfig | Format-List Focused*

#We can turn off this feature for the whole organization
Set-OrganizationConfig -FocusedInboxOn $false

#Did it work?
Get-OrganizationConfig | Format-List Focused*
