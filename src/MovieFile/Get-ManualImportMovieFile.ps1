function Get-ManualImportMovieFile {
    param (
        [Alias("id")]
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName, ParameterSetName = 'id')]
        [ValidateNotNullOrEmpty()] 
        [int]$movieId,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName, ParameterSetName = "id")]
        [ValidateNotNullOrEmpty()] 
        [string]$folderName,
        $filterExistingFiles = $true
    )
    begin {
        $connection = Get-RadarrConnection
    }

    process {
        $Request = @{
            Uri    = ($connection.URL + "/manualimport")
            Body   = Format-RestBody (@{
                    apikey              = $connection.APIKey
                    movieId             = $movieId
                    folder              = $folderName
                    filterExistingFiles = [string]$filterExistingFiles
                })
            Method = "Get"
        }
        Invoke-RestMethod @Request
    }
}