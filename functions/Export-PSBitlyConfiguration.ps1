Function Export-BitlyConfiguration {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('None', 'System.IO.FileInfo')]
    Param(
        [Parameter(Mandatory, HelpMessage = 'Enter your Bitly API token')]
        [ValidateNotNullOrEmpty()]
        [SecureString]$APIKey,
        [Switch]$PassThru
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"
    } #begin

    Process {
        $PSBitlyConfigPath = Join-Path $home -ChildPath ".psbitlyconfig.json"
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Exporting configuration to $PSBitlyConfigPath"
        Get-BitlyUser -APIKey $APIKey | Select-Object -Property Name,Email,GroupID,Created,Modified |
        ConvertTo-Json | Out-File -FilePath $PSBitlyConfigPath -Encoding UTF8 -Force
        if ($PassThru) {
            Get-Item $PSBitlyConfigPath
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Export-PSBitly