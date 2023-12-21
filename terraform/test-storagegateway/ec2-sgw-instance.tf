resource "aws_instance" "gateway" {
  ami                  = data.aws_ami.gateway_ami.image_id
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.gateway.name
  # Refer to AWS File Gateway documentation for minimum system requirements.
  ebs_optimized = true
  subnet_id     = var.subnet_id

  root_block_device {
    volume_size           = "80"
    volume_type           = "gp2"
    encrypted             = true
    kms_key_id            = data.aws_kms_key.shared_key.arn 
  }

  tags = {
    Name = "drm-labtest-20210903-gw"
  }

  key_name = var.key_name

  vpc_security_group_ids = [ aws_security_group.storage_gateway.id ]

  #depends_on = [aws_vpc_endpoint.sgw]

}