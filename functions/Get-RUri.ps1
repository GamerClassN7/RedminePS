function Get-RUri {
    param (
        [string[]]$query = @(),
        [string]$endpoint = $null
    )
    $tempUri = $script:RedmineBaseUri +  $endpoint
    if ($tempQuery.Length -gt 0) {
        $tempUri += ("?" + $tempQuery -join "&")
    }
    $tempUri
}