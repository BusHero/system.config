[CmdletBinding()]
param (
	[Parameter()]
	[string]
	$Path
)

$items = Get-ChildItem -Recurse -Path $path
$size = $items | Measure-Object -Sum Length

$item = Get-Item -Path $Path
@{Size = $size.Sum; Name = $item.Name } | Select-Object -Property *
