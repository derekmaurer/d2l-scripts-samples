$domains = "int.d2l","rhu.int.d2l","aas1.int.d2l","aas2.int.d2l","aew1.int.d2l","acc1.int.d2l","aue1.int.d2l"

foreach ($domain in $domains) {

    $gpos = $gpos + (Get-GPO -all -Domain $domain| sort -Property DisplayName)
    
    }

$gpos | out-gridview