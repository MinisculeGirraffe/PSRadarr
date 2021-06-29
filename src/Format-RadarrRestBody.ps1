function Format-RestBody {
    param (
        [Parameter(Mandatory = $true)]
        [hashtable]$body
    )
     ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
     return $body
}