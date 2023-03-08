# https://rudimartinsen.com/2018/01/31/creating-a-powershell-module-as-an-api-wrapper/
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$script:RedmineBaseUri = ""
$script:RedmineCredentials = ""
$script:RedmineInvokeHeaders = @{
    ContentType = "application/json"
} 

#Import Module Functions
Get-ChildItem -Path $PSScriptRoot\functions -Recurse -File | Where-object -Filter { -not $PSItem.Name.StartsWith("dev_")} | ForEach-Object -Process {
    . $PSItem.FullName
    Write-Host $PSItem.FullName
}

