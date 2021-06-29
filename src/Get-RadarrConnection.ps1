function Get-RadarrConnection {
    param (
    )
    try {
        $configpath = Resolve-RadarrConfigPath
        if ($null -eq $configpath) { throw "Unable to resolve config path" }
    }
    catch { exit }
    return Import-Clixml $configpath
}