function Get-RadarrMovie {
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [int]$tmdbId,
        [string[]]$properties = @('tmdbId', 'title', 'year', 'hasFile')
    )
    begin {
        $connection = Get-RadarrConnection
    }
    process {
        $Request = @{
            Uri    = ($connection.URL + "/movie")
            Body   = Format-RestBody (@{
                    apikey = $connection.APIKey
                    tmdbId = $tmdbId
                })
            Method = "Get"
        }
        return Invoke-RestMethod @Request | Set-VisibleProperties $properties
    }
}

