Function Get-BitlyLinkSummary {
    [CmdletBinding()]
    [OutputType("PSBitlySummary")]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter the bitly link i.e. bit.ly/<short>",
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [String]$ID,

        [Parameter(
            Mandatory,
            HelpMessage = "Enter your Bitly API token"
        )]
        [ValidateNotNullOrEmpty()]
        [SecureString]$APIKey,
        [Parameter(HelpMessage = "Enter a unit of time")]
        [ValidateSet("Day", "Minute", "Hour", "Week", "Month")]
        [String]$TimeSpan = "Day",
        [Parameter(HelpMessage = "An integer representing the time units to query data for. Use -1 to return all units of time.")]
        [Int]$Count = -1,
        [ValidateRange(1, 1000)]
        [Int]$Size = 50
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"

        $Bearer = _ConvertSecureString $APIKey
        $Headers = @{
            Authorization = "Bearer $Bearer"
        }

        $irmParams = @{
            Headers          = $Headers
            ErrorAction      = "Stop"
            uri              = $null
            Method           = "Get"
            UseBasicParsing  = $True
            disableKeepAlive = $True
        }
    } #begin

    Process {
        Write-Verbose "[PROCESS] Getting click summary for $ID"
        #  https://dev.bitly.com/api-reference#getClicksForBitlink
        $uri = "https://api-ssl.bitly.com/v4/bitlinks/$ID/clicks/summary?unit=$($TimeSpan.tolower())&units=$count&size=$size"

        $irmParams.uri = $uri

        Try {
            Write-Verbose "[PROCESS] Using Invoke-RestMethod parameters"
            $irmParams | Out-String | Write-Verbose

            $result = Invoke-RestMethod @irmParams

            #write a custom object to the pipeline
            [PSCustomObject]@{
                PSTypename  = "PSBitlySummary"
                ID          = $ID
                Title       = (Get-BitlyLink -id $ID -APIKey $APIKey).Title
                TotalClicks = $result.total_clicks
                TimeSpan    = (_ToTitleCase $TimeSpan)
                Count       = $result.units
                Date        = $result.unit_reference -as [DateTime]
            }

        }
        Catch {
            Throw $_
        }

    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    } #end
}
