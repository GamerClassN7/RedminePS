function Connect-RServer {
    [cmdletbinding()]
    param (
        [string] $uri = $null,
        [PSCredential] $credential = $null
    )

    try {
        $response = Invoke-RestMethod -Uri ("{0}/users.json?name={1}" -f $uri, $credential.UserName) -Credential $credential
        $script:RedmineBaseUri = $uri
        $script:RedmineCredentials = $credential
        return $true
    }
    catch {
        return $false
    }
}