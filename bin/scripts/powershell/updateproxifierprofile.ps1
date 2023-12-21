param([string]$profile = "p" , [string]$address = "a")

$xml = New-Object XML                                                                                                                            
$xml.load("$profile")   

$element = $xml.SelectSingleNode("//Address")
write-host Old element : $element.'#text'

$element.InnerText = "$address"

write-host Updated element $element.'#text'

$xml.save("$profile")