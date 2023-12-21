## tag waf resources
$region     = "ap-southeast-2"
$wafaclname = "ap02-waf"
$scope      = "REGIONAL"
$d2lenv     = "AP02"

#aws wafv2 get-web-acl --name $wafacl --scope REGIONAL --region $region
#$wafacls = aws wafv2 list-web-acls --scope REGIONAL --region $region
$wafacls = Get-WAF2WebACLsList -Scope $scope -Region $region
$wafacl = $wafacls | Where-Object -Property Name -eq $wafaclname
$wafacl = Get-WAF2WebACL -Scope $scope -Region $region -Id $wafacl.ID -Name $wafaclname
$wafacl.webacl.arn

$tag = New-Object Amazon.WAFV2.Model.Tag
$tag.Key = "Environment"
$tag.Value = $d2lenv

Add-WAF2ResourceTag  -ResourceARN $wafacl.webacl.arn -Region $region -Tag $tag

$tag = New-Object Amazon.WAFV2.Model.Tag
$tag.Key = "SaaSTier1"
$tag.Value = "PlatformServices"

Add-WAF2ResourceTag  -ResourceARN $wafacl.webacl.arn -Region $region -Tag $tag

$tag = New-Object Amazon.WAFV2.Model.Tag
$tag.Key = "Team"
$tag.Value = "CIS - Platform"

Add-WAF2ResourceTag  -ResourceARN $wafacl.webacl.arn -Region $region -Tag $tag

$tag = New-Object Amazon.WAFV2.Model.Tag
$tag.Key = "ManagedBy"
$tag.Value = "Terraform - https://github.com/Brightspace/cis-terraform-environments"

Add-WAF2ResourceTag  -ResourceARN $wafacl.webacl.arn -Region $region -Tag $tag