<# 
.SYNOPSIS
Short script description 
.DESCRIPTION
Description what the script does and possible how it does
.EXAMPLE
Example for the command
#>
[CmdletBinding()]
Param (
    $in = "D:\Dropbox\Program Files\Get-InternetPrices\Get-InternetPrices.csv",
    $out = "$PSScriptRoot/Get-InternetPrices.out"
)
$InputFile = Import-Csv -Delimiter "`t" -Path $in
$InputFile | ForEach-Object {
    $Object = Invoke-WebRequest -Uri $_.URL
    
    if ($Object.Content -match ($_.Catch)) {    
        $price=[math]::round(($Matches[1] -replace "\s",""),2)        
        if ($price -le $_.Threshold) {
            Write-Host -ForegroundColor green "Buy me! " -NoNewline
            Write-Host "$($_.Product) is available for " -NoNewline
            Write-Host -ForegroundColor green "$price" -NoNewline
            Write-Host " $($_.Currency) on $($_.Shop), threshold is $($_.Threshold) $($_.URL)"
        } else {
            Write-Host -ForegroundColor red "Expensive! " -NoNewline
            Write-Host "$($_.Product) is available for " -NoNewline
            Write-Host -ForegroundColor red "$price" -NoNewline
            Write-Host " $($_.Currency) on $($_.Shop), threshold is $($_.Threshold) $($_.URL)"
        }
    }
}
pause