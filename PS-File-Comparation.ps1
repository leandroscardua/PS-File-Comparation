#Global Variables

$FNSS = "FoldernameSourceServer"
$SS = "SourceServer"
$DS1 = "DestinationServer1"
$DS2 = "DestinationServer2"

#####################################################

$SourceDocs = Get-ChildItem -Recurse –Path \\"$SS"\C$\Websites\"$FNSS" | foreach  {Get-FileHash –Path $_.FullName}

$DestDocs1 = Get-ChildItem -Recurse –Path \\"$DS1"\C$\Websites\"$FNSS" | foreach  {Get-FileHash –Path $_.FullName}

$DestDocs2 = Get-ChildItem -Recurse –Path \\"$DS2"\E$\Websites\"$FNSS" | foreach  {Get-FileHash –Path $_.FullName}

#####################################################


$result1 = (Compare-Object -ReferenceObject $SourceDocs -DifferenceObject $DestDocs1  -Property hash -PassThru).Path 

if ($result1) { Write-Host "The objects are different on :$DS1, Follows the list with the files on the source server $SS :" $result1 }
if (!$result1) { Write-Host "The objects are the same on $DS1 " }



####################################################


$result2 = (Compare-Object -ReferenceObject $SourceDocs -DifferenceObject $DestDocs2  -Property hash -PassThru).Path

if ($result2) { Write-Host "The objects are different on :$DS1, Follows the list with the files on the source server $SS :" $result2 }
if (!$result2) { Write-Host "The objects are the same on $DS2" }
