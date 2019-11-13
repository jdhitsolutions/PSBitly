
#region classes

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

    # I am using a private function, _createPSBitlyUser as a constructor
}

#endregion

# dot source public functions
. $PSScriptRoot\functions.ps1

#dot source private functions
. $PSScriptRoot\private.ps1

#define default display properties
Update-TypeData -TypeName PSBitlyLinks -DefaultDisplayPropertySet "Created", "Link", "CustomLinks", "Title", "Tags", "ID", "Url" -Force
Update-TypeData -TypeName PSBitlyUser -DefaultDisplayPropertySet "Name", "Email", "GroupID", "Created", "Modified" -Force

 $keyPath = Join-Path -Path ~ -ChildPath bitlytoken.xml
if (Test-Path $keyPath) {
    try {
        $APIToken = Import-Clixml -Path $keypath -ErrorAction stop
        $global:PSDefaultParameterValues["*-bitly*:apikey"] = $APIToken
    }
    Catch {
        Write-Warning "Failed to restore bitly API token from $keypath"
        Throw $_
    }

}

