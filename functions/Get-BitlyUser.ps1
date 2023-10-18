Function Get-BitlyUser {
    [CmdletBinding()]
    [OutputType("PSBitlyUser")]

    Param(
        [Parameter(
            Mandatory,
            HelpMessage = "Enter your Bitly API token"
        )]
        [ValidateNotNullOrEmpty()]
        [SecureString]$APIKey
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    } #begin
    Process {
        Write-Verbose "[PROCESS] Getting bitly user information."
        $Bearer = _ConvertSecureString $APIKey
        # uncomment for debugging and testing
        #Write-Host $Bearer -ForegroundColor green
        $item = Invoke-RestMethod -Uri "https://api-ssl.bitly.com/v4/user" -Headers @{Authorization = "Bearer $bearer" }
        Write-Verbose "[PROCESS] Creating PSBitlyUser for $($item.login)"
        _createPSBitlyUser -item $item

    } #process
    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    } #end
}
