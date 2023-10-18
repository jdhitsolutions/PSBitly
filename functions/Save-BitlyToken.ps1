Function Save-BitlyToken {
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'prompt')]
    [OutputType('None', 'System.IO.FileInfo')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ParameterSetName = 'token',
            ValueFromPipeline,
            HelpMessage = 'A secure string object of your Bitly API key or token.'
        )]
        [ValidateNotNullOrEmpty()]
        [SecureString]$Token,
        [Parameter(ParameterSetName = 'prompt',
            HelpMessage = 'Enter or copy your Bitly API key or token.'
        )]
        [switch]$Prompt,
        [Parameter(HelpMessage = 'Display the export file.')]
        [switch]$Passthru
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        $KeyPath = Join-Path -Path $HOME -ChildPath BitlyToken.xml
    } #begin

    Process {
        if ( $PSCmdlet.ParameterSetName -eq 'prompt' ) {
            $Token = Read-Host 'Enter or paste your API key here.' -AsSecureString
        }
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Exporting key to $KeyPath"
        If ($PSCmdlet.ShouldProcess($KeyPath)) {
            Try {
                $Token | Export-Clixml -Path $KeyPath -ErrorAction Stop
            }
            catch {
                Throw $_
            }
            $global:PSDefaultParameterValues['*-bitly*:APIKey'] = $Token
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

}
