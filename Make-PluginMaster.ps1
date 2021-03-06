$output = New-Object Collections.Generic.List[object]
$notInclude = "testPlugin", "testPlugin2", "XIVStats";

Get-ChildItem -Path plugins -File -Recurse -Include *.json |
Foreach-Object {
    $content = Get-Content $_.FullName | ConvertFrom-Json

    if ($notInclude.Contains($content.InternalName)) { 
    	$content | add-member -Name "IsHide" -value "True" -MemberType NoteProperty
    }
    else
    {
    	$content | add-member -Name "IsHide" -value "False" -MemberType NoteProperty
    }

    $output.Add($content)
}

$outputStr = $output | ConvertTo-Json
echo $outputStr

Out-File -FilePath .\pluginmaster.json -InputObject $outputStr
