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
                _CreatePSBitlyLink $item
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
