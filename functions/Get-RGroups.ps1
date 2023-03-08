function Get-RGroups {
    param ()
    begin {}
    process {
        $lastResponse = $null
        $offset = 0;
        
        while ($lastResponse.issues.Length -ne 0 -or $null -eq $lastResponse) {
            $tempQuery = $query
            if ($offset -ne 0) {
                $tempQuery += "offset={0}" -f $offset
            }

            $tempUri = Get-RUri -query $tempQuery -endpoint "groups.json"
            $response = Invoke-WebRequest -Uri $tempUri -Method GET -Credential $script:RedmineCredentials -ContentType  'application/json; charset=utf-8'
            if ( $response.StatusCode -eq 200) {
                $lastResponse = ($response.Content | ConvertFrom-Json)
                $lastResponse.groups
            }
            $offset += $lastResponse.limit
        }
    }
}