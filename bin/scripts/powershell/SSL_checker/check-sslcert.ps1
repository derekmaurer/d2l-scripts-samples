
#Requires -version 2.0
 
param(
 [parameter(mandatory=$true,helpmessage="IP address or hostname to resolve remote system")][string]$ipaddr,
 [parameter(mandatory=$true,helpmessage="TCP port number that SSL application is listening on")][int]$port,
 [parameter(helpmessage="Hostname on certificate")][string]$myhostname=$ipaddr,
 [parameter(helpmessage="Verbose")][alias('fulldetail')][switch]$V
 
)


function stripcomma([string]$tempstring) {
 write-debug "In Function StripComma $($tempstring)"
 return $tempstring.replace(',',';') 
 
}

function convertoid([string]$oid) {
 write-debug "In function ConvertToOID: $($oid)"
 #strip off oid component common to all crypto types
 $oidstr = $oid.replace("1.2.840.113549.1.","")
 
 #pull out first number
 $firstval = $oidstr.substring(0,$oidstr.indexof('.'))
 
 #pull out second number for more detail
 $sub = $oidstr.substring(2)
 if ($sub.indexof('.') -gt 0) {
  $sub = $sub.substring(0,$sub.indexof('.')) 
 }
 
 if ($firstval -eq "1") {
  $format = "PKCS-1"
  switch ($sub) {
   "1" { return ($format + " RSA Encryption") }
   "2" { return ($format + " MD2 with RSA") }
   "3" { return ($format + " rsadsi md4 with RSA")}
   "4" { return ($format + " MD5 with RSA") }
   "5" { return ($format + " SHA-1 with RSA") }
   "6" { return ($format + " rsaOAEPEncryptionSet")}
   "11" { return ($format + " sha256 with RSA") }
  }
 } elseif ($firstval -eq "5") {
  $format = "RSA PKCS5"
  switch ($sub) {
   "1" { return ($format + " rsadsi pbe with MD2 DES-CBC")}
   "3" { return ($format + " rsadsi pbe with MD5 DES-CBC")}
   "4" { return ($format + " pbe with MD2 and RC2_CBC")}
   "6" { return ($format + " pbe with MD5 and RC2_CBC")}
   "9" { return ($format + " pbe with MD5 and XOR")}
   "10" { return ($format + " pbe with SHA1 and DES-CBC")}
   "11" { return ($format + " pbe with SHA1 and RC2_CBC")}
   "12" { return ($format + " id-PBKDF2 key derivation function")}
   "13" { return ($format + " id-PBES2  PBES2 encryption")}
   "14" { return ($format + " id-PBMAC1 message auth scheme")}
   
  }
 } elseif ($firstval -eq "7" ) {
  $format = "PKCS-7"
  switch ($sub) {
   "1" { return ($format + " data")}
   "2" { return ($format + " signed data")}
   "3" { return ($format + " enveloped data")}
   "4" { return ($format + " signed and enveloped data")}
   "5" { return ($format + " digested data")}
   "6" { return ($format + " encrypted data")}
  }
 } elseif ($firstval -eq "12") {
  return ("PKCS-12")
 } elseif ($firstval -eq "15") {
  return ("PKCS-15") 
 } else {
  return $oid 
 }
   
 
}

######
#MAIN#
######

#open TCP connection
try {
 $conn = new-object system.net.sockets.tcpclient($ipaddr,$port) 
 
 try {
  #create ssl stream on existing tcp connection
  $stream = new-object system.net.security.sslstream($conn.getstream())
  #send hostname on cert to try SSL negotiation
  $stream.authenticateasclient($myhostname) 
  
  $cert = $stream.get_remotecertificate()
  $cert2 = New-Object system.security.cryptography.x509certificates.x509certificate2($cert)    #can get much more information with this class    

  $validto = [datetime]::Parse($cert.getexpirationdatestring())
  $validfrom = [datetime]::Parse($cert.geteffectivedatestring())
  
  if ($V) {
   new-object psobject -property @{ 
    Connection = "Success"
    Machine = $ipaddr
    CertFormat = ($cert.getformat())
    CertExpiration = $validto
    CertIssueDate = $validfrom
    CertIssuer = ($cert.get_issuer())
    SerialNumber = ($cert.getserialnumberstring())
    CertSubject = (stripcomma $cert.get_subject())
    CertType =  (convertoid $cert.getkeyalgorithm())
   }
  } else {
   #non verbose
   New-Object psobject -Property @{
    Connection = "Success"
    Machine = $ipaddr
    CertExpiration = $validto
   }
  }

 } catch {
  #if SSL connection failed, cert may be invalid or name on cert didn't match, fails either way
  throw $_
 } finally {
  Write-Debug "In finally: closing connection"
  $conn.close()
 }
} catch {
 Write-Verbose "Error occurred connecting to $($ipaddr)"
 New-Object PSObject -Property @{
  Machine = $ipaddr
  Connection = "Failure"
  Status = $_.exception.innerexception.message
 }
 
}
