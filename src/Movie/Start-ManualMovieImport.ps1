
<#
TODO POST to /manualimport before post to /command
movieId
Path
file id from above command
Language @() @{
    id: 0 
    name: 
    namelower
}

quality @{
    quality@{
        name
        source
        resolution
        id / qualityID? Check API?
        modifier????
    }
    Revision @{
        isrepack // bool but as a string
        real // bool but as an int
        version // bool but as an int??
    }
}

This is so dumb
#>

function Start-ManualMovieImport {
    param (
        [Alias("id")]
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName, ParameterSetName = 'id')]
        [ValidateNotNullOrEmpty()] 
        $path,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName, ParameterSetName = "id")]
        [ValidateNotNullOrEmpty()] 
        $folderName,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName, ParameterSetName = "id")]
        [ValidateNotNullOrEmpty()] 
        $movieId
        
    )
    begin {
        $connection = Get-RadarrConnection
    }

    process {
        $Request = @{
            Uri    = ($connection.URL + "/command")
            Headers = @{
                "x-api-key" = $connection.APIKey
            }
            ContentType = "application/json"
            Body   =  @{
                    name       = 'ManualImport'
                    importMode = "auto"
                    files      = @(
                        @{
                            path       = $path
                            folderName = $folderName
                            movieId    = $movieId
                            quality    = @{
                                "id"         = 0
                                "name"       = "Unknown"
                                "source"     = "unknown"
                                "resolution" = 0
                                "modifier"   = "none"
                            }
                            revision   = @{
                                version = 0
                                real    = 0
                            }
                        }
                    )
                    #Dear fucking god it doesn't actually convert to json properly in the request body unless you do this
                } |ConvertTo-Json -Depth 5 -EnumsAsStrings | Out-String 
            Method = "Post"
        }

        Invoke-RestMethod @Request
    }
}