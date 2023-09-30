#these are internal and private helper functions

function _createPSBitlyLink {
    [CmdletBinding()]
    Param(
        [object]$Item
    )

    Write-Verbose "[PRIVATE] CreatePSBitlyLink"
    $new = [PSBitlyLink]::new()

    $new.Archived = $item.archived
    $new.Created = $item.Created_at
    $new.CreatedBy = $item.created_by
    $new.CustomLinks = $item.custom_bitlinks
    $new.ID = $item.ID
    $new.Link = $item.link
    $new.Tags = $item.tags
    $new.Title = $item.Title
    $new.Url = $item.long_url
    $new.DeepLinks = $item.DeepLinks
    $new.references = $item.references
    $new.ClientID = $item.client_id
    $new.raw = $item

    $new
}

Function _createPSBitlyUser {
    [CmdletBinding()]
    Param([object]$Item)

    Write-Verbose "[PRIVATE] CreatePSBitlyUser"
    $new = [PSBitlyUser]::new()

    $new.Created = $item.created
    $new.Email = $item.emails.email
    $new.GroupID = $item.default_group_guid
    $new.Is2FA = $item.is_2fa_enabled
    $new.IsActive = $item.is_active
    $new.IsSSO = $item.is_sso_user
    $new.Login = $item.login
    $new.Modified = $item.modified
    $new.Name = $item.name
    $new.raw = $item

    $new
}

Function _ConvertSecureString {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString]$SecureString
    )
    Try {
        $ErrorActionPreference = "stop"
        $bstr = [System.Runtime.InteropServices.marshal]::SecureStringToBSTR($SecureString)
        [System.Runtime.InteropServices.marshal]::PtrToStringBSTR($bstr)
        #$len = [system.text.encoding]::UTF8.Getbytes($bstr).count
        #[System.Runtime.InteropServices.marshal]::PtrToStringAuto($bstr,$len)
    }
    Catch {
        Write-Warning "Failed to convert secure string back to plain text."
        Throw $_
    }
}

function _ToTitleCase {
    [CmdletBinding()]
    Param(
        [String]$Text
    )

    [System.Globalization.CultureInfo]::CurrentCulture.TextInfo.ToTitleCase($text)

}
