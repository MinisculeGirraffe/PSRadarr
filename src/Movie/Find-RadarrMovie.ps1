function Find-RadarrMovie {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()] 
        [string]$term,
        [string[]]$properties = @('tmdbId', 'title', 'year', 'overview', 'monitored'),
        [bool]$IgnoreMonitored = $false
    )
    begin {
        $connection = Get-RadarrConnection
    }
    process {
        $Request = @{
            Uri    = ($connection.URL + "/movie/lookup")
            Body   = Format-RestBody (@{
                    apikey = $connection.APIKey
                    term   = $term
                })
            Method = "Get"
        } 
        (Invoke-RestMethod @Request | Set-VisibleProperties $properties) | ForEach-Object {
            if (($_.monitored -eq $true) -and ($IgnoreMonitored -eq $true)) {
                Write-Verbose
                Write-Host "Ignoring result $($_.tmdbId) as it is already in our library "
            }
            else {
                return $_
            }
        } 
    }
}