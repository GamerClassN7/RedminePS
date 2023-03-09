# https://rudimartinsen.com/2018/01/31/creating-a-powershell-module-as-an-api-wrapper/
# https://www.redmine.org/projects/redmine/wiki/Rest_api

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$script:RedmineBaseUri = ""
$script:RedmineCredentials = ""
$script:RedmineInvokeHeaders = @{
    ContentType = "application/json; charset=utf-8"
    Accept = "application/json, text/plain, */*"
} 

# Import Module Functions
Get-ChildItem -Path $PSScriptRoot\functions -Recurse -File | Where-object -Filter { -not $PSItem.Name.StartsWith("dev_")} | ForEach-Object -Process {
    . $PSItem.FullName
    Write-Host $PSItem.FullName
}

# Utils
Export-ModuleMember -Function Connect-RServer
Export-ModuleMember -Function Invoke-RRequest


# Issues
Export-ModuleMember -Function Get-RIssues
Export-ModuleMember -Function New-RIssues
Export-ModuleMember -Function Remove-RIssues

# Projects
Export-ModuleMember -Function Get-RProjects

# Groups
Export-ModuleMember -Function Get-RGroups



