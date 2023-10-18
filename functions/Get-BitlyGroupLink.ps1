Function Get-BitlyGroupLink {
    [CmdletBinding()]
    [OutputType('PSBitlyLink')]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'Enter your Bitly group GUID or ID',
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [String]$GroupID,

        [Parameter(
            Mandatory,
            HelpMessage = 'Enter your Bitly API token'
        )]
        [ValidateNotNullOrEmpty()]
        [SecureString]$APIKey,

        [ValidateRange(1, 1000)]
        [Int]$Size = 50,

        [string[]]$Tags,
        [Parameter(HelpMessage = 'Enter a key word or phrase to filter on')]
        [String]$Filter,
        [DateTime]$CreatedBefore,
        [DateTime]$CreatedAfter,
        [DateTime]$ModifiedAfter
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
        Write-Verbose '[BEGIN  ] Converting APIKey secure string'
        $Bearer = _ConvertSecureString $APIKey

        $Headers = @{
            Authorization = "Bearer $Bearer"
        }

        $irmParams = @{
            Headers          = $Headers
            ErrorAction      = 'Stop'
            uri              = $null
            Method           = 'Get'
            UseBasicParsing  = $True
            disableKeepAlive = $True
        }
        $output = [System.Collections.Generic.List[object]]::New()
    } #begin

    Process {
        Write-Verbose '[PROCESS] Using these PSBoundParameters'
        $MyInvocation.BoundParameters | Out-String | Write-Verbose
        Write-Verbose "[PROCESS] Getting bitly group links for $GroupID"

        $Uri = "https://api-ssl.bitly.com/v4/groups/$GroupID/bitlinks?size=$size"

        if ($tags) {
            foreach ($tag in $tags) {
                $uri += "&tag=$tag"
            }
        }
        if ($filter) {
            $uri += "&query=$filter"
        }
        if ($CreatedBefore) {
            $before = Get-Date $CreatedBefore -UFormat %s
            $uri += "&created_before=$before"
        }
        if ($CreatedAfter) {
            $after = Get-Date $CreatedAfter -UFormat %s
            $uri += "&created_after=$after"
        }

        if ($ModifiedAfter) {
            $after = Get-Date $ModifiedAfter -UFormat %s
            $uri += "&created_after=$after"
        }

        $irmParams.uri = $uri

        Try {
            Write-Verbose '[PROCESS] Using Invoke-RestMethod parameters'
            $irmParams | Out-String | Write-Verbose
            $result = Invoke-RestMethod @irmParams

            Write-Verbose "[PROCESS] Retrieved $($result.links.count) links"
            $data = $result.links
            #create a custom class-based object for each result
            foreach ($item in $data) {
                Write-Verbose "[PROCESS] Creating an object for $($item.id)"
                #invoke a private function
                $link = _CreatePSBitlyLink $item
                $output.Add($link)
            }
        }
        Catch {
            Throw $_
        }
    } #process

    End {
        if ($output.count -gt 0) {
            $output | Sort-Object Created
        }
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    } #end
}
