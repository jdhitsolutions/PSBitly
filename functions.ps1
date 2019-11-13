# https://dev.bitly.com/v4_documentation.html

#these are the public and exported functions for the module

Function New-BitlyLink {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("PSBitlyLink")]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter the long url to shorten",
            ValueFromPipeline
        )]
        [ValidateNotNullorEmpty()]
        [string]$Url,

        [Parameter(
            Mandatory,
            HelpMessage = "Enter your Bitly API token"
        )]
        [SecureString]$APIKey
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
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

        if ($pscmdlet.ShouldProcess($url)) {
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
        } #whatif
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end
}

Function Get-BitlyLink {
    [cmdletbinding()]
    [OutputType("PSBitlyLink")]

    Param(
        [parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter the bitly link i.e. bit.ly/<short>",
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullorEmpty()]
        [string]$ID,

        [Parameter(
            Mandatory,
            HelpMessage = "Enter your Bitly API token"
        )]
        [ValidateNotNullorEmpty()]
        [SecureString]$APIKey
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
        $Bearer = _ConvertSecureString $APIKey
        $headers = @{Authorization = "Bearer $Bearer" }

        $baseuri = "https://api-ssl.bitly.com/v4/bitlinks"
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
        $irmParams.uri = "$baseuri/$ID"

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
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end
}

Function Set-BitlyLink {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("PSBitlyLink")]

    Param(
        [parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter the bitly link i.e. bit.ly/<short>",
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullorEmpty()]
        [string]$ID,
        [parameter(ValueFromPipelineByPropertyName)]
        [string]$Title,
        [string[]]$Tags,
        [switch]$Archive,
        [Parameter(Mandatory, HelpMessage = "Enter your Bitly API token")]
        [ValidateNotNullorEmpty()]
        [SecureString]$APIKey
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
        $Bearer = _ConvertSecureString $APIKey
        $headers = @{
            'Content-Type' = "application/json"
            Authorization  = "Bearer $Bearer"
        }

        $baseuri = "https://api-ssl.bitly.com/v4/bitlinks"
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
            $irmParams.uri = "$baseuri/$ID"


            if ($PSCmdlet.ShouldProcess($id)) {
                Try {
                    #insert a brief sleep statement so that when piping from New-PSBitly the new link will
                    #have a chance to be registered with Bitly. Otherwise there is a risk of trying to
                    #access and set a link that hasn't been created yet online. This only works with a one-line
                    #expression.
                    if ($MyInvocation.line -match "New-BitlyLink") {
                        Write-Verbose "[PROCESS] Waiting 5 seconds for new link to be registered online."
                        Start-Sleep -seconds 5
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
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end

}

Function Get-BitlyUser {
    [cmdletbinding()]
    [OutputType("PSBitlyUser")]

    Param(
        [Parameter(
            Mandatory,
            HelpMessage = "Enter your Bitly API token"
        )]
        [ValidateNotNullorEmpty()]
        [SecureString]$APIKey
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    } #begin
    Process {
        Write-Verbose "[PROCESS] Getting bitly user information."
        $Bearer = _ConvertSecureString $APIKey
        # uncomment for debugging and testing
        #write-host $Bearer -ForegroundColor green
        $item = Invoke-RestMethod -uri "https://api-ssl.bitly.com/v4/user" -Headers @{Authorization = "Bearer $bearer" }
        Write-Verbose "[PROCESS] Creating PSBitlyUser for $($item.login)"
        _createPSBitlyUser -item $item

    } #process
    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end
}

Function Get-BitlyGroupLinks {
    [cmdletbinding()]
    [OutputType("PSBitlyLink")]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter your Bitly group GUID or ID",
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullorEmpty()]
        [string]$GroupID,

        [Parameter(
            Mandatory,
            HelpMessage = "Enter your Bitly API token"
        )]
        [ValidateNotNullorEmpty()]
        [SecureString]$APIKey,

        [ValidateRange(1, 1000)]
        [int]$Size = 50,

        [string[]]$Tags,
        [Parameter(Helpmessage = "Enter a key word or phrase to filter on")]
        [string]$Filter,
        [datetime]$CreatedBefore,
        [datetime]$CreatedAfter,
        [datetime]$ModifiedAfter
    )

    Begin {
        # $MyInvocation | out-string | write-host -for cyan
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
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
        Write-Verbose "[PROCESS] Using these PSBoundparameters"
        $Myinvocation.BoundParameters | Out-String | Write-Verbose
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
            Write-Verbose "[PROCESS] Using Invoke-Restmethod parameters"
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
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end
}

Function Get-BitlyLinkSummary {
    [cmdletbinding()]
    [outputtype("PSBitlySummary")]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter the bitly link i.e. bit.ly/<short>",
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullorEmpty()]
        [string]$ID,

        [Parameter(
            Mandatory,
            HelpMessage = "Enter your Bitly API token"
        )]
        [ValidateNotNullorEmpty()]
        [SecureString]$APIKey,
        [Parameter(HelpMessage = "Enter a unit of time")]
        [ValidateSet("day", "minute", "hour", "week", "month")]
        [string]$Timespan = "day",
        [Parameter(HelpMessage = "An integer representing the time units to query data for. Use -1 to return all units of time.")]
        [int]$Count = -1,
        [ValidateRange(1, 1000)]
        [int]$Size = 50
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"

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
        $uri = "https://api-ssl.bitly.com/v4/bitlinks/$ID/clicks/summary?unit=$Timespan&units=$count&size=$size"

        $irmParams.uri = $uri

        Try {
            Write-Verbose "[PROCESS] Using Invoke-Restmethod parameters"
            $irmParams | Out-String | Write-Verbose

            $result = Invoke-RestMethod @irmParams

            #write a custom object to the pipeline
            [pscustomobject]@{
                PSTypename  = "PSBitlySummary"
                ID          = $ID
                TotalClicks = $result.total_clicks
                Timespan    = $result.unit
                Count       = $result.units
                Date        = $result.unit_reference -as [DateTime]
            }

        }
        Catch {
            Throw $_
        }

    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end
}

Function Get-URLDetail {
    [cmdletbinding()]
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
        [string]$URL
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"

        #parsedhtml takes too long and fails for sites like GitHub
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
            if ($rx.ismatch($data.content)) {
                $myTitle = $rx.Matches($data.Content).groups[-1].value
            }
            else {
                $myTitle = $null
            }
            [pscustomobject]@{
                PSTypename  = "urlDetail"
                URL         = $URL
                AbsoluteURL = $data.BaseResponse.ResponseUri.AbsoluteUri
                Title       = $myTitle
                Date        = $data.baseResponse.LastModified
            }
        }
        Catch {
            Throw $_
        }

    } #process
    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end
}

Function Save-BitlyToken {
    [cmdletbinding(SupportsShouldProcess)]
    Param()
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
    } #begin

    Process {
        $secure = Read-Host "Enter or copy your Bitly API key or token." -AsSecureString
        $keyPath = Join-Path -Path ~ -ChildPath bitlytoken.xml
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Exporting key to $keyPath"
        If ($PSCmdlet.ShouldProcess($keyPath)) {
            Try {
                $secure | Export-Clixml -Path $keypath -ErrorAction Stop
            }
            catch {
                Throw $_
            }
            $global:PSDefaultParameterValues["*-bitly*:apikey"] = $secure
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Save-BitlyToken