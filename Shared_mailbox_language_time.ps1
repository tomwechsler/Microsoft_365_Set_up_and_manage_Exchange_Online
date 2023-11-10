#Install the ExchangeOnlineManagement module
Install-Module -Name ExchangeOnlineManagement -Verbose -Force -AllowClobber

#Import the required module
Import-Module ExchangeOnlineManagement

#Create a connection to Exchange Online
Connect-ExchangeOnline

#Create a new shared mailbox
New-Mailbox -Shared -Name "psbox" -PrimarySmtpAddress "psbox@cloudtrain.tech"

#Set the language and time format for the new shared mailbox
Set-MailboxRegionalConfiguration -Identity "psbox" -Language "de-de" -DateFormat "dd.MM.yyyy" -TimeZone "W. Europe Standard Time"

# Get the regional settings for a specific mailbox
$mailboxRegionalConfig = Get-MailboxRegionalConfiguration -Identity "psbox"

$mailboxRegionalConfig

#Get all shared mailboxes
$sharedMailboxes = Get-Mailbox -ResultSize unlimited -Filter {(RecipientTypeDetails -eq 'SharedMailbox')}

#Set the language and time format for all shared mailboxes
foreach ($mailbox in $sharedMailboxes) {
    Set-MailboxRegionalConfiguration -Identity $mailbox.Identity -Language "de-de" -DateFormat "dd.MM.yyyy" -TimeZone "W. Europe Standard Time"
}

#Disconnect the connection to Exchange Online
Disconnect-ExchangeOnline
