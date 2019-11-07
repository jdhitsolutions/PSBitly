
#region main code

<#

Name            TypeNameOfValue
----            ---------------
created_at      System.String
id              System.String
link            System.String
custom_bitlinks System.Object[]
long_url        System.String
title           System.String
archived        System.Boolean
created_by      System.String
client_id       System.String
tags            System.Object[]
deeplinks       System.Object[]
references      System.Management.Automation.PSCustomObject


#>

Class PSBitlyLink {

    [datetime]$Created
    [string]$ID
    [string]$Link
    [string[]]$CustomLinks
    [string]$Url
    [string]$Title
    [bool]$Archived
    [string]$CreatedBy
    [string[]]$Tags
    hidden [object[]]$DeepLinks
    hidden [object[]]$References
    hidden [string]$ClientID

    #the Raw property will hold the original result from the API request
    hidden [object]$Raw

    # I am using a private function, _createPSBitlyLink as a constructor

}

Class PSBitlyUser {

    [string]$Name
    [datetime]$Created
    [datetime]$Modified
    [string]$Email
    [string]$GroupID
    hidden [bool]$IsActive
    hidden [bool]$Is2FA
    hidden [bool]$IsSSO
    hidden [string]$Login

    #the Raw property will hold the original result from the API request
    hidden [object]$Raw
}

# dot source public functions
. $PSScriptRoot\functions.ps1

#dot source private functions
. $PSScriptRoot\private.ps1

#define default display
Update-Typedata -TypeName PSBitlyLinks -DefaultDisplayPropertySet "Created", "Link", "CustomLinks", "Title", "Tags", "ID", "Url" -Force
Update-Typedata -TypeName PSBitlyUser -DefaultDisplayPropertySet "Name", "Email", "GroupID", "Created", "Modified" -Force

#endregion

#TODO - get tags by Group\
#TODO - get summary click referral details
#TODO - Verify archiving is an option that still works
#TODO - help documents
