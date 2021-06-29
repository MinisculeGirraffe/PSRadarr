function Set-RadarrConnection {
    param (
        [Parameter(Mandatory = $true)]
        $URL,
        [Parameter(Mandatory = $true)]
        $APIKey
    )
    try {
        $configpath = Resolve-RadarrConfigPath
        if ($null -eq $configpath) { throw "Unable to resolve config path" }
    }
    catch {
        exit 
    }

    #The folder the config file is in
    $configContainer = Split-Path $configpath
    #If the folder doesn't exist
    if ((Test-Path $configContainer) -eq $false) {
        #create the folder
        New-Item -Path $configContainer -Name (Split-Path $configContainer -Leaf) -ItemType Directory
    }

    $Config = @{
        URL = $URL
        APIKey = $APIKey
    }

    [void]($config | Export-Clixml -Path $configpath)

}