# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Invoke-ApiClient {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Uri,
        [Parameter(Mandatory)]
        [string]$Method,
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$Body,
        [string]$OutFile
    )

    $Configuration = Get-RolConfiguration
    $RequestUri = $Configuration["BaseUrl"] + $Uri

    $Params = @{
        Uri = $RequestUri
        Method = $Method
        Headers = @{'ApiKey' = $Configuration['ApiKey']}
    }
    
    if ($null -ne $Body) {
        $Params.Add('Body', $Body)
        $Params.Add('ContentType', 'application/json')
    }
    
    $WebResponse = Invoke-WebRequest @Params
    
    $MediaType = [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse($WebResponse.Headers.'Content-Type')
    switch ($MediaType.MediaType) {
        'application/json' { return $WebResponse.Content | ConvertFrom-Json -Depth 10}
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' { 
            if(-not ([String]::IsNullOrEmpty($OutFile))) {
                [System.IO.File]::WriteAllBytes($OutFile, $WebResponse.RawContentStream.ToArray())
                return $OutFile
            }
            Write-Error -Message 'Received binary data, this must be saved using the OutFile parameter'
        }
        Default {}
    }
}