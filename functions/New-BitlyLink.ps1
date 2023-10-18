Function New-BitlyLink {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("PSBitlyLink")]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter the long url to shorten",
            ValueFromPipeline
        )]
        [ValidateNotNullOrEmpty()]
        [String]$Url,

        [Parameter(
            Mandatory,
            HelpMessage = "Enter your Bitly API token"
        )]
        [SecureString]$APIKey
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
        $Bearer = _ConvertSecureString $APIKey
        $headers = @{
            'Content-Type' = "application/json"
            Authorization  = "Bearer $Bearer"
        }

        $uri = "https://api-ssl.bitly.com/v4/bitlinks"

        $irmParams = @{
            ErrorAction      = "Stop"
            uri              = $uri
            Headers          = $headers
            Body             = $null
            method           = "Post"
            UseBasicParsing  = $True
            disableKeepAlive = $True
        }

        Write-Verbose "[BEGIN  ] Using uri $uri"
    } #begin

    Process {
        Write-Verbose "[PROCESS] Creating bitly link for $url"
        $body = @{
            long_url = $url
        }

        $irmParams.Body = $body | ConvertTo-Json
        Write-Verbose "[PROCESS] Sending body"
        $irmparams.body | Out-String | Write-Verbose

        if ($PSCmdlet.ShouldProcess($url)) {
            Try {
                $data = Invoke-RestMethod @irmParams
                #create a custom class-based object for each result
                foreach ($item in $data) {

                    Write-Verbose "[PROCESS] Creating an object for $($item.id)"
                    #invoke a private function
                    _CreatePSBitlyLink $item
                }
            }
            catch {
                Throw $_
            }
        } #WhatIf
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    } #end
}
