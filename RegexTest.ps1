$Regex1 = '^[a-z]{2,4}\s.{2,}$'

$variable = 'test123 haha wow'

$hashtable = [ordered]@{
    table1 = 'a'
    table2 = 'abc lol fuckthissssssssss'
    table3 = 'i bet this won''t work.'
    table4 = 'but this one will.'
    table5 = 'FUUUUUUUUUUUUUUUUUUU'
    table6 = 'fuuuuuuuuuuuuuuuuuuu'
}

if ($variable -match $Regex1) {
    $variable
}

foreach ($item in $hashtable.Keys) {
    if ($hashtable.Item -match $Regex1) {
        $message = '{0} value is {1}' -f $item, $hashtable[$item]
        Write-Output $message
    }


    

}

#$table1 = ($hashtable).table1

($hashtable).GetEnumerator() | ForEach-Object {
    if ($_.Value -match $Regex1) {
        Write-Output "$($_.Key) matches regex. The value is $($_.Value)."
    }
}

#lol