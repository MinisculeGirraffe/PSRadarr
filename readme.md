# PSRadarr


## Installation

API tokens will be saved in the following directories.
- Windows:
`"$env:LOCALAPPDATA\PSWebexTeams\PSWebexTeamsConfig.xml"`
- MacOS / Linux
`"$env:HOME/.config/powershell/PSWebexTeamsConfig.xml"`


```powershell
#With IP
Set-RadarrConnection -URI http://10.1.30.30:7878/api/v3 -APIKey "KEY"

#With Reverse proxy and modified URL Base
Set-RadarrConnection -URI https://dashboard/radarr/api/v3 -APIKey "KEY"
```

## Usage
Get a listing of all movies in Radarr
```powershell
Get-RadarrMovie
<#
tmdbId title        year hasFile
------ -----        ---- -------
  8848 The Bank Job 2008   False
#>
```
By default only the params tmdbId title year hasFile are displayed, however the entire radarr object is returned from the cmdlet.  For a full listing of the available properties Pipe into select object. See also the Radarr API Schema 
https://radarr.video/docs/api/#/Movie/get-movie-lookup
```powershell
Get-RadarrMovie -tmdbId 3683 | Select-Object *
```

###Lookup Movies by title 

#Only return movies not added to Radarr
Get-RadarrMovieLookup "Space Jam" | ? {($_ | Get-RadarrMovie) -eq $null }
#Only return movies that have been added
Get-RadarrMovieLookup "Space Jam" | Get-RadarrMovie

## Contributing
Pull requests are welcome. 


## License
[MIT](https://choosealicense.com/licenses/mit/)