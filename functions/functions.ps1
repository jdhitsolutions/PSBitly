# https://dev.bitly.com/v4_documentation.html

#these are the public and exported functions for the module

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
                    _createPSBitlylink $item
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

Function Get-BitlyLink {
    [CmdletBinding()]
    [OutputType("PSBitlyLink")]

    Param(
        [parameter(
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
        [SecureString]$APIKey
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
        $Bearer = _ConvertSecureString $APIKey
        $headers = @{Authorization = "Bearer $Bearer" }

        $BaseUri = "https://api-ssl.bitly.com/v4/bitlinks"
        $irmParams = @{
            ErrorAction      = "Stop"
            uri              = $null
            Headers          = $headers
            Body             = $null
            method           = "Get"
            UseBasicParsing  = $True
            disableKeepAlive = $True
        }

        Write-Verbose "[BEGIN  ] Using base uri $uri"
    } #begin

    Process {

        Write-Verbose "[PROCESS] Getting link $ID"
        $irmParams.uri = "$BaseUri/$ID"

        Try {
            $data = Invoke-RestMethod @irmParams
            #create a custom class-based object for each result
            foreach ($item in $data) {

                Write-Verbose "[PROCESS] Creating an object for $($item.id)"
                #invoke a private function
                _createPSBitlylink $item
            }
        }
        catch {
            Throw $_
        }

    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    } #end
}

Function Set-BitlyLink {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("PSBitlyLink")]

    Param(
        [parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter the bitly link i.e. bit.ly/<short>",
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [String]$ID,
        [parameter(ValueFromPipelineByPropertyName)]
        [String]$Title,
        [string[]]$Tags,
        [Switch]$Archive,
        [Parameter(Mandatory, HelpMessage = "Enter your Bitly API token")]
        [ValidateNotNullOrEmpty()]
        [SecureString]$APIKey
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
        $Bearer = _ConvertSecureString $APIKey
        $headers = @{
            'Content-Type' = "application/json"
            Authorization  = "Bearer $Bearer"
        }

        $BaseUri = "https://api-ssl.bitly.com/v4/bitlinks"
        $irmParams = @{
            ErrorAction      = "Stop"
            uri              = $null
            Headers          = $headers
            Body             = $null
            method           = "Patch"
            UseBasicParsing  = $True
            disableKeepAlive = $True
        }

        Write-Verbose "[BEGIN  ] Using base uri $uri"
    } #begin

    Process {
        $body = @{ }
        if ($title) {
            Write-Verbose "[PROCESS] Adding title: $Title"
            $body.Add("title", $Title)
        }

        if ($tags) {
            Write-Verbose "[PROCESS] Adding tags: $($tags -join ',')"
            $body.Add("tags", $tags)
        }

        if ($archive) {
            $body.Add("archived", $true)
        }

        if ($body.keys.count -gt 0) {

            $irmParams.Body = $body | ConvertTo-Json
            Write-Verbose "[PROCESS] Sending body"
            $irmparams.body | Out-String | Write-Verbose

            Write-Verbose "[PROCESS] Setting link $ID"
            $irmParams.uri = "$BaseUri/$ID"


            if ($PSCmdlet.ShouldProcess($id)) {
                Try {
                    #insert a brief sleep statement so that when piping from New-PSBitly the new link will
                    #have a chance to be registered with Bitly. Otherwise there is a risk of trying to
                    #access and set a link that hasn't been created yet online. This only works with a one-line
                    #expression.
                    if ($MyInvocation.line -match "New-BitlyLink") {
                        Write-Verbose "[PROCESS] Waiting 5 seconds for new link to be registered online."
                        Start-Sleep -Seconds 5
                    }
                    $data = Invoke-RestMethod @irmParams
                    #create a custom class-based object for each result
                    foreach ($item in $data) {

                        Write-Verbose "[PROCESS] Creating an object for $($item.id)"
                        #invoke a private function to create a custom bitly link object
                        _createPSBitlylink $item
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

Function Get-BitlyGroupLinks {
    [CmdletBinding()]
    [OutputType("PSBitlyLink")]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter your Bitly group GUID or ID",
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [String]$GroupID,

        [Parameter(
            Mandatory,
            HelpMessage = "Enter your Bitly API token"
        )]
        [ValidateNotNullOrEmpty()]
        [SecureString]$APIKey,

        [ValidateRange(1, 1000)]
        [Int]$Size = 50,

        [string[]]$Tags,
        [Parameter(HelpMessage = "Enter a key word or phrase to filter on")]
        [String]$Filter,
        [DateTime]$CreatedBefore,
        [DateTime]$CreatedAfter,
        [DateTime]$ModifiedAfter
    )

    Begin {
        # $MyInvocation | Out-String | Write-Host -for cyan
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
        Write-Verbose "[BEGIN  ] Converting APIKey secure string"
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
        Write-Verbose "[PROCESS] Using these PSBoundParameters"
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
            Write-Verbose "[PROCESS] Using Invoke-RestMethod parameters"
            $irmParams | Out-String | Write-Verbose
            $result = Invoke-RestMethod @irmParams

            Write-Verbose "[PROCESS] Retrieved $($result.links.count) links"
            $data = $result.links
            #create a custom class-based object for each result
            foreach ($item in $data) {

                Write-Verbose "[PROCESS] Creating an object for $($item.id)"
                #invoke a private function
                _createPSBitlylink $item
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

Function Save-BitlyToken {
    [CmdletBinding(SupportsShouldProcess)]
    Param()
    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
    } #begin

    Process {
        $secure = Read-Host "Enter or copy your Bitly API key or token." -AsSecureString
        $KeyPath = Join-Path -Path ~ -ChildPath BitlyToken.xml
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Exporting key to $KeyPath"
        If ($PSCmdlet.ShouldProcess($KeyPath)) {
            Try {
                $secure | Export-Clixml -Path $KeyPath -ErrorAction Stop
            }
            catch {
                Throw $_
            }
            $global:PSDefaultParameterValues["*-bitly*:APIKey"] = $secure
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Save-BitlyToken
