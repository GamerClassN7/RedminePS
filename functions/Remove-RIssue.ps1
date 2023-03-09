function Remove-RIssues {
    param (
        [Parameter(Mandatory = $true)]
        [string] $issue_id
    )
    begin {}
    process {     
        $endpoint = "issues/{0}.json" -f $issue_id
        $tempUri = Get-RUri -query $tempQuery -endpoint $endpoint
        $response = Invoke-WebRequest -Uri $tempUri -Method DELETE -Credential $script:RedmineCredentials -ContentType  'application/json; charset=utf-8'
        
        if ( $response.StatusCode -eq 200) {
            $true
        } else {
            $false
        }
    }
}