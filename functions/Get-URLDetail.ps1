Function Get-URLDetail {
    [CmdletBinding()]
    [OutputType("urlDetail")]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter a web URL",
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidatePattern("^http")]
        [alias("link")]
        [String]$URL
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"

        #parsed html takes too long and fails for sites like GitHub
        $iwrParams = @{
            ErrorAction      = "Stop"
            DisableKeepAlive = $True
            UseBasicParsing  = $True
            Uri              = $null
        }
    } #begin

    Process {
        Write-Verbose "[PROCESS] Getting details for $URL"
        $iwrParams.uri = $url

        try {
            $data = Invoke-WebRequest @iwrParams
            Write-Verbose "[PROCESS] Analyzing $($data.BaseResponse.ResponseUri.AbsoluteUri)"

            [regex]$rx = "\<title\>(?<pgTitle>.*)\<\/title\>"
            if ($rx.IsMatch($data.content)) {
                $myTitle = $rx.Matches($data.Content).groups[-1].value
            }
            else {
                $myTitle = $null
            }

            #The web request result differs between Windows PowerShell and PowerShell 7.x
            if ($PSVersionTable.PSVersion.Major -eq 7) {
                $date = $data.BaseResponse.content.headers.LastModified.LocalDateTime
                $absolute = $data.BaseResponse.RequestMessage.RequestUri.AbsoluteUri
            }
            else {
                $date = $data.baseResponse.LastModified
                $absolute = $data.BaseResponse.ResponseUri.AbsoluteUri
            }
            [PSCustomObject]@{
                PSTypename  = "urlDetail"
                URL         = $URL
                AbsoluteURL = $absolute
                Title       = $myTitle
                Date        = $date
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
