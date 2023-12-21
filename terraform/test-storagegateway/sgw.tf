
resource "aws_storagegateway_gateway" "nfs_file_gateway" {
  gateway_ip_address   = aws_instance.gateway.private_ip
  gateway_name         = var.gateway_name
  gateway_timezone     = var.gateway_time_zone
  gateway_type         = "FILE_S3"
}

#data "aws_storagegateway_local_disk" "cache" {
#  disk_path   = "/dev/xvdf"
#  node_path   = "/dev/xvdf"
#  gateway_arn = "${aws_storagegateway_gateway.nfs_file_gateway.id}"
#}

#resource "aws_storagegateway_cache" "nfs_cache_volume" {
#  disk_id     = "${data.aws_storagegateway_local_disk.cache.id}"
#  gateway_arn = "${aws_storagegateway_gateway.nfs_file_gateway.id}"
#}



resource "aws_storagegateway_nfs_file_share" "same_account" {
  client_list  = var.client_access_list
  gateway_arn  = aws_storagegateway_gateway.nfs_file_gateway.id
  role_arn     = aws_iam_role.gateway.arn
  location_arn = aws_s3_bucket.bucket.arn
}
