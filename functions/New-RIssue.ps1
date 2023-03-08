function New-RIssue {
    param (
        [Parameter(Mandatory = $true)]
        [string] $subject = $null,
        [Parameter(Mandatory = $true)]
        [string] $description = $null,
        [Parameter(Mandatory = $true)]
        [string] $project_id = $null,
        [Parameter(Mandatory = $true)]
        [string] $state_id = $null,
        [Parameter(Mandatory = $true)]
        [string] $tracker_id = $null
    )
    begin {
        $body = @{};
        if (-not [string]::IsNullOrEmpty($subject)) {
            $body['subject'] = $subject
        }
        if (-not [string]::IsNullOrEmpty($description)) {
            $body['description'] = $description
        }
        if (-not [string]::IsNullOrEmpty($project_id)) {
            $body['project_id'] = $project_id
        }
        if (-not [string]::IsNullOrEmpty($state_id)) {
            $body['state_id'] = $state_id
        }
        if (-not [string]::IsNullOrEmpty($tracker_id)) {
            $body['tracker_id'] = $tracker_id
        }         
    }
    process {
        $tempBody = (@{"issue" = $body } | ConvertTo-Json)
        $tempUri = Get-RUri -query $tempQuery -endpoint "issues.json"
        $response = Invoke-WebRequest -Uri $tempUri -Method POST -Credential $script:RedmineCredentials -Body $tempBody -ContentType "application/json"

        if ( $response.StatusCode -gt 200 -and $response.StatusCode -lt 300) {
            $lastResponse = ($response.Content | ConvertFrom-Json)
            $lastResponse.issue   
        }
    }
}