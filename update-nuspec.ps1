Param(
  [string]$newVersion
)

$file = "$PSScriptRoot\HomeSeerNuget\HomeSeerNuget.nuspec"

[xml]$xml = get-content -Path $file

if ($newVersion -eq "") {
    $version = [System.Version]::Parse($xml.package.metadata.version)

    $newVersion = "$($version.Major).$($version.Minor).$($version.Build + 1)"
} else {
    $newVersion = $newVersion -replace "(\d*\.\d*\.\d*).*", "`$1"
}


$xml.package.metadata.version = $newVersion

$info = get-childitem .\HomeSeerNuget\lib -include *.dll -Recurse | foreach-object { "{0}`t{1}`n" -f $_.Name, [System.Diagnostics.FileVersionInfo]::GetVersionInfo($_).FileVersion }

$xml.package.metadata.releaseNotes = $xml.package.metadata.releaseNotes + $info

$xml.Save($file)

"Updated $file to $newVersion "