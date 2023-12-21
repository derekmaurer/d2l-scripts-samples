$ip = "192.168.253.1"
$ip = $ip.split(".")
$hexip=""

foreach ($octet in $ip) {
  $octet = "{0:X2}" -f  [int]$octet
  $hexip = $hexip+$octet
}

$hexip