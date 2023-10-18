#region classes

Class PSBitlyLink {
    [DateTime]$Created
    [String]$ID
    [String]$Link
    [String[]]$CustomLinks
    [String]$Url
    [String]$Title
    [bool]$Archived
    [String]$CreatedBy
    [String[]]$Tags
    hidden [object[]]$DeepLinks
    hidden [object[]]$References
    hidden [String]$ClientID

    #the Raw property will hold the original result from the API request
    hidden [object]$Raw

    # I am using a private function, _CreatePSBitlyLink as a constructor

}

Class PSBitlyUser {
    [String]$Name
    [DateTime]$Created
    [DateTime]$Modified
    [String]$Email
    [String]$GroupID
    hidden [bool]$IsActive
    hidden [bool]$Is2FA
    hidden [bool]$IsSSO
    hidden [String]$Login

    #the Raw property will hold the original result from the API request
    hidden [object]$Raw

    # I am using a private function, _createPSBitlyUser as a constructor
}

#endregion

# dot source functions
(Get-ChildItem $PSScriptRoot\functions\*.ps1).ForEach({. $_.FullName})

#define default display properties
Update-TypeData -TypeName PSBitlyLinks -DefaultDisplayPropertySet "Created", "Link", "CustomLinks", "Title", "Tags", "ID", "Url" -Force
Update-TypeData -TypeName PSBitlyUser -DefaultDisplayPropertySet "Name", "Email", "GroupID", "Created", "Modified" -Force

$KeyPath = Join-Path -Path $HOME -ChildPath BitlyToken.xml
if (Test-Path -path $KeyPath) {
    #convert path to a full system path
    $cPath = Convert-Path -path $KeyPath
    try {
        $APIToken = Import-Clixml -Path $cPath -ErrorAction stop
        $global:PSDefaultParameterValues["*-bitly*:APIKey"] = $APIToken
    }
    Catch {
        Write-Warning "Failed to restore bitly API token from $KeyPath"
        Throw $_
    }
}
Else {
    #the user can use whatever mechanism they want to store the API Key
}

