data "aws_vpc" "deployment_vpc" {
  id = var.vpc_id
}

data "aws_ami" "gateway_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["aws-storage-gateway-*"]
    #values = ["aws-thinstaller-1564432962"]  # used by storage-gw for existing sftp
  }
}



