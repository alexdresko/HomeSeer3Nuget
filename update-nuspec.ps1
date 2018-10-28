Param(
  [string]$newVersion
)

$file = ".\HomeSeerNuget\HomeSeerNuget.nuspec"

[xml]$xml = get-content -Path $file

if ($newVersion -eq "") {
    $version = [System.Version]::Parse($xml.package.metadata.version)

    $newVersion = "$($version.Major).$($version.Minor).$($version.Build + 1)"
} else {
    $newVersion = $newVersion -replace "(\d*\.\d*\.\d*).*", "`$1"
}

$xml.package.metadata.version = $newVersion

$xml.Save($file)

"Updated $file to $newVersion "