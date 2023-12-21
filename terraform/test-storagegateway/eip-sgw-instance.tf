resource "aws_eip" "filegateway" {
}

resource "aws_eip_association" "filegateway" {
  allocation_id = aws_eip.filegateway.id
  instance_id = aws_instance.gateway.id
 # provisioner "local-exec" {
 #   command     = "sleep 2m"
 # }
}