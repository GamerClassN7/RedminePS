function Invoke-RRequest {
    param (
        [Parameter(Mandatory = $true)]
        [string]$method,
        [Parameter(Mandatory = $true)]
        [string]$endpoint,
        [Parameter(Mandatory = $false)]
        [string[]]$query = @()
    )
    begin {

    }
    process {
        $lastResponse = $null
        $dataSelectror = $endpoint -replace ".json", ""
        if ($dataSelectror -like "*/*"){
            $dataSelectror = ($dataSelectror -split "/")[0].Substring(0,($dataSelectror -split "/")[0].Length-1)
        }

        $offset = 0;
        $numberOfRestApiCalls = 0;
        $totalNumberOfRestApiCalls = 0;

        while ($numberOfRestApiCalls -le $totalNumberOfRestApiCalls -or $null -eq $lastResponse) {
            $tempQuery = $query;
            if ($offset -ne 0) {
                $tempQuery += "offset={0}" -f $offset
            }
            $tempUri = Get-RUri -query $tempQuery -endpoint $endpoint

            $apiResponse = Invoke-WebRequest -Uri $tempUri -Method $method -Credential $script:RedmineCredentials -Headers $script:RedmineInvokeHeaders
            if ( $apiResponse.StatusCode -eq 200) {
                $lastResponse = ($apiResponse.Content | ConvertFrom-Json)
                
                if ($lastResponse.total_count -gt 0) {
                    $totalNumberOfRestApiCalls = [math]::ceiling($lastResponse.total_count / $lastResponse.limit)
                }
                                
                $lastResponse.$dataSelectror
                $numberOfRestApiCalls++;
            }
            else {
                break;
            }

            $offset += $lastResponse.limit
        }
    }
}