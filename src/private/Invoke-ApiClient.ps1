# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Invoke-ApiClient {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Uri,
        [Parameter(Mandatory)]
        [string]$Method,
        [string]$Body,
        [string]$OutFile
    )
    
    if (-not $Script:Configuration) {
        Get-RolConfiguration | Out-Null
    }

    if (-not $Script:Configuration['ApiKey'] -or -not $Script:Configuration['BaseUrl']) {
        throw 'PsRol is not configured. Run Set-RolConfiguration first.'
    }
    $RequestUri = $Script:Configuration['BaseUrl'] + $Uri

    $Params = @{
        Uri     = $RequestUri
        Method  = $Method
        Headers = @{'ApiKey' = $Script:Configuration['ApiKey'] }
    }
    
    if (-not [string]::IsNullOrEmpty($Body)) {
        $Params.Add('Body', $Body)
        $Params.Add('ContentType', 'application/json')
    }
    
    $Body | Write-Debug

    try {
        $WebResponse = Invoke-WebRequest @Params
    }
    # Catch HTTP responses explicitly
    catch [Microsoft.PowerShell.Commands.HttpResponseException] {
        
        # If Not Found (404), return $null. This will be handled by the calling function
        if ($PSItem.Exception.Response.StatusCode -eq [System.Net.HttpStatusCode]::NotFound) {
            return
        }

        # Convert the JSON Error Body from the API to an object
        $ErrorBodyFromApi = $PSItem.ErrorDetails.Message | ConvertFrom-Json

        # Create the error object
        $WriteError = @{
            Message   = '{0} - {1} - {2}' -f $ErrorBodyFromApi.path, $ErrorBodyFromApi.status, ($ErrorBodyFromApi.error ?? 'null')
            Exception = $PSItem.Exception
        }
        Write-Error @WriteError
        return
    }
    # Catch all other exceptions
    catch {
        Write-Error -Message $PSItem.Exception.Message -Exception $PSItem.Exception
        return
    }

    $BinaryContentTypes = @('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'application/ms-excel')
    
    $MediaType = [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse($WebResponse.Headers.'Content-Type')
    switch ($MediaType.MediaType) {
        'application/json' { return $WebResponse.Content | ConvertFrom-Json -Depth 10 }
        { $PSItem -in $BinaryContentTypes } { 
            if (-not ([String]::IsNullOrEmpty($OutFile))) {
                [System.IO.File]::WriteAllBytes($OutFile, $WebResponse.RawContentStream.ToArray())
                return $OutFile
            }
            Write-Error -Message 'Received binary data, this must be saved using the OutFile parameter'
        }
        Default {
            Write-Error -Message $('Unexpected Media Type: {0}' -f $MediaType.MediaType) -Exception $([InvalidOperationException]::new($('Unexpected Media Type: {0}' -f $MediaType.MediaType)))
        }
    }
}