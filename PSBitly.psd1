
@{
    RootModule           = 'PSBitly.psm1'
    ModuleVersion        = '0.7.0'
    CompatiblePSEditions = @('Desktop', 'Core')
    GUID                 = '94f535a4-89c1-4044-9cc0-eb7514e2042b'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c) 2019-2023 Jeff Hicks. All rights reserved.'
    Description          = 'Create and manage with Bit.ly shortcut links in PowerShell.'
    PowerShellVersion    = '5.1'
    # TypesToProcess = @()
    FormatsToProcess     = @('formats\psbitlylinks.format.ps1xml', 'formats\urldetail.format.ps1xml')
    FunctionsToExport    = @('Get-BitlyGroupLink', 'Get-BitlyLink', 'Get-BitlyLinkSummary', 'Get-BitlyUser', 'New-BitlyLink', 'Set-BitlyLink',
        'Get-URLDetail', 'Save-BitlyToken', 'Export-BitlyConfiguration')
    CmdletsToExport      = @()
    VariablesToExport    = @()
    AliasesToExport      = @('Export-BitlyToken')

    PrivateData          = @{
        PSData = @{
            Tags       = @("bitly", "bit.ly", "shortener")
            LicenseUri = 'https://github.com/jdhitsolutions/PSBitly/blob/master/license.txt'
            ProjectUri = 'https://github.com/jdhitsolutions/PSBitly'
            # IconUri = ''
            # ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable

}
