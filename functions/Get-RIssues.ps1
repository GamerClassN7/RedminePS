function Get-RIssues {
    param (
        [Parameter(Mandatory = $false)]
        [string] $issue_id = $null,
        [Parameter(Mandatory = $false)]
        [string] $project_id = $null,
        [Parameter(Mandatory = $false)]
        [string] $tracker_id = $null,
        [Parameter(Mandatory = $false)]
        [string] $assigned_to_id = $null,
        [Parameter(Mandatory = $false)]
        [string] $status_id = $null
    )
    begin {
        $uri = "{0}issues.json" -f $script:RedmineBaseUri

        $query = @();
        if (-not [string]::IsNullOrEmpty($issue_id)) {
            $query += "issue_id={0}" -f $issue_id
        }
        if (-not [string]::IsNullOrEmpty($project_id)) {
            $query += "project_id={0}" -f $project_id
        }
        if (-not [string]::IsNullOrEmpty($tracker_id)) {
            $query += "tracker_id={0}" -f $tracker_id
        }
        if (-not [string]::IsNullOrEmpty($assigned_to_id)) {
            $query += "assigned_to_id={0}" -f $assigned_to_id
        }
        if (-not [string]::IsNullOrEmpty($status_id)) {
            $query += "status_id={0}" -f $status_id
        }
    }
    process {
        $lastResponse = $null
        $offset = 0;
        
        while ($lastResponse.issues.Length -ne 0 -or $null -eq $lastResponse) {
            $tempQuery = $query
            if ($offset -ne 0) {
                $tempQuery += "offset={0}" -f $offset
            }

            $tempUri = $uri
            if ($tempQuery.Length -gt 0) {
                $tempUri += ("?" + $tempQuery -join "&")
            }

            $response = Invoke-WebRequest -Uri $tempUri -Method GET -Credential $script:RedmineCredentials
            if ( $response.StatusCode -eq 200) {
                $lastResponse = ($response | ConvertFrom-Json)
                $lastResponse.issues
            }
            $offset += $lastResponse.limit
        }
    }
}