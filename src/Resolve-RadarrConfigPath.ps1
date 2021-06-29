function Resolve-RadarrConfigPath {
    if ([System.Environment]::OSVersion.Platform -eq "Win32NT") {
        return "$env:LOCALAPPDATA\PSRadarr\PSRadarrConfig.xml"

    }
    elseif ([System.Environment]::OSVersion.Platform -eq "Unix" -eq $true) {
        return "$env:HOME/.config/powershell/PSRadarrConfig.xml"
    }
    else {
        return $null
    }
}