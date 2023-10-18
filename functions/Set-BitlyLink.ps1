Function Set-BitlyLink {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('PSBitlyLink')]

    Param(
        [parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'Enter the bitly link i.e. bit.ly/<short>',
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [String]$ID,
        [parameter(ValueFromPipelineByPropertyName)]
        [String]$Title,
        [string[]]$Tags,
        [Switch]$Archive,
        [Parameter(Mandatory, HelpMessage = 'Enter your Bitly API token')]
        [ValidateNotNullOrEmpty()]
        [SecureString]$APIKey
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
        $Bearer = _ConvertSecureString $APIKey
        $headers = @{
            'Content-Type' = 'application/json'
            Authorization  = "Bearer $Bearer"
        }

        $BaseUri = 'https://api-ssl.bitly.com/v4/bitlinks'
        $irmParams = @{
            ErrorAction      = 'Stop'
            uri              = $null
            Headers          = $headers
            Body             = $null
            method           = 'Patch'
            UseBasicParsing  = $True
            disableKeepAlive = $True
        }

        Write-Verbose "[BEGIN  ] Using base uri $uri"
    } #begin

    Process {
        $body = @{ }
        if ($title) {
            Write-Verbose "[PROCESS] Adding title: $Title"
            $body.Add('title', $Title)
        }

        if ($tags) {
            Write-Verbose "[PROCESS] Adding tags: $($tags -join ',')"
            $body.Add('tags', $tags)
        }

        if ($archive) {
            $body.Add('archived', $true)
        }

        if ($body.keys.count -gt 0) {

            $irmParams.Body = $body | ConvertTo-Json
            Write-Verbose '[PROCESS] Sending body'
            $irmParams.body | Out-String | Write-Verbose

            Write-Verbose "[PROCESS] Setting link $ID"
            $irmParams.uri = "$BaseUri/$ID"

            if ($PSCmdlet.ShouldProcess($id)) {
                Try {
                    #insert a brief sleep statement so that when piping from New-PSBitly the new link will
                    #have a chance to be registered with Bitly. Otherwise there is a risk of trying to
                    #access and set a link that hasn't been created yet online. This only works with a one-line
                    #expression.
                    if ($MyInvocation.line -match 'New-BitlyLink') {
                        Write-Verbose '[PROCESS] Waiting 5 seconds for new link to be registered online.'
                        Start-Sleep -Seconds 5
                    }
                    $data = Invoke-RestMethod @irmParams
                    #create a custom class-based object for each result
                    foreach ($item in $data) {

                        Write-Verbose "[PROCESS] Creating an object for $($item.id)"
                        #invoke a private function to create a custom bitly link object
                        _CreatePSBitlyLink $item
                    }
                }
                Catch {
                    Throw $_
                }
            } #should process
        }
        else {
            Write-Warning "You didn't specify any changes for this link."
        }

    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    } #end

}
