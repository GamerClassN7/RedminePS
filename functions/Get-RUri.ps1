function Get-RUri {
    param (
        [string[]]$query = @(),
        [Parameter(Mandatory = $true)]
        [string]$endpoint = $null
    )
    $tempUri = $script:RedmineBaseUri +  $endpoint
    if ($tempQuery.Length -gt 0) {
        $tempUri += ("?" + $tempQuery -join "&")
    }
    $tempUri
}