function Get-RProjects {
    param (
        [Parameter(Mandatory = $false)]
        [string] $project_id = $null
    )
    begin {}
    process {
        $lastResponse = $null
        $offset = 0;
        
        while ($lastResponse.issues.Length -ne 0 -or $null -eq $lastResponse) {
            $tempQuery = $query
            if ($offset -ne 0) {
                $tempQuery += "offset={0}" -f $offset
            }

            $endpoint = "projects.json"
            if (-not [string]::IsNullOrEmpty($project_id)) {
                $endpoint = "projects/{0}.json" -f $project_id
            }

            $tempUri = Get-RUri -query $tempQuery -endpoint $endpoint
            $tempUri

            $response = Invoke-WebRequest -Uri $tempUri -Method GET -Credential $script:RedmineCredentials -ContentType  'application/json; charset=utf-8'
            if ( $response.StatusCode -eq 200) {
                $lastResponse = ($response.Content | ConvertFrom-Json)
                if (-not [string]::IsNullOrEmpty($project_id)) {
                    $lastResponse.project
                }
                else {
                    $lastResponse.projects
                }
            }
            $offset += $lastResponse.limit
        }
    }
}