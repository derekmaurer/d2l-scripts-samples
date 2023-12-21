#data "aws_security_group" "deployment-bastion" {
#  name = "devops-production-deployment-bastion"
#}

resource "aws_security_group_rule" "ingress_80" {
  description       = "For activation"
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.storage_gateway.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = [var.deployment_cidr]
}

resource "aws_security_group_rule" "ingress_22" {
  description       = "For debug"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.storage_gateway.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = [var.deployment_cidr]
}


resource "aws_security_group_rule" "egress_all" {
  description       = "egress"
  from_port         = 0
  protocol          = "ALL"
  security_group_id = aws_security_group.storage_gateway.id
  to_port           = 65535
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "storage_gateway" {
  name        = "${var.gateway_name}-instance-sg"
  description = "Allow inbound NFS traffic"
  vpc_id      = data.aws_vpc.deployment_vpc.id

  tags = {
    Name = "${var.gateway_name}-instance-sg"
  }

}

resource "aws_security_group" "deployment_storage_gateway_access" {
  name        = "${var.gateway_name}-access"
  description = "Attach this group to your instances to get access to the storage gateway via NFS."
  vpc_id      = data.aws_vpc.deployment_vpc.id

  tags = {
    Name = "${var.gateway_name}-access-sg"
  }

}

resource "aws_security_group_rule" "ingress_2049_tcp_product" {
  description              = "For NFS"
  from_port                = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.storage_gateway.id
  to_port                  = 2049
  type                     = "ingress"
  source_security_group_id = aws_security_group.deployment_storage_gateway_access.id
}

resource "aws_security_group_rule" "ingress_2049_udp_product" {
  description              = "For NFS"
  from_port                = 2049
  protocol                 = "udp"
  security_group_id        = aws_security_group.storage_gateway.id
  to_port                  = 2049
  type                     = "ingress"
  source_security_group_id = aws_security_group.deployment_storage_gateway_access.id
}

resource "aws_security_group_rule" "ingress_111_tcp_product" {
  description              = "For NFS"
  from_port                = 111
  protocol                 = "tcp"
  security_group_id        = aws_security_group.storage_gateway.id
  to_port                  = 111
  type                     = "ingress"
  source_security_group_id = aws_security_group.deployment_storage_gateway_access.id
}

resource "aws_security_group_rule" "ingress_111_udp_product" {
  description              = "For NFS"
  from_port                = 111
  protocol                 = "udp"
  security_group_id        = aws_security_group.storage_gateway.id
  to_port                  = 111
  type                     = "ingress"
  source_security_group_id = aws_security_group.deployment_storage_gateway_access.id
}

resource "aws_security_group_rule" "ingress_20048_tcp_product" {
  description              = "For NFS"
  from_port                = 20048
  protocol                 = "tcp"
  security_group_id        = aws_security_group.storage_gateway.id
  to_port                  = 20048
  type                     = "ingress"
  source_security_group_id = aws_security_group.deployment_storage_gateway_access.id
}

resource "aws_security_group_rule" "ingress_20048_udp_product" {
  description              = "For NFS"
  from_port                = 20048
  protocol                 = "udp"
  security_group_id        = aws_security_group.storage_gateway.id
  to_port                  = 20048
  type                     = "ingress"
  source_security_group_id = aws_security_group.deployment_storage_gateway_access.id
}

resource "aws_security_group_rule" "ingress_443_tcp_product" {
  description              = "https"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deployment_storage_gateway_access.id
  to_port                  = 443
  type                     = "ingress"
  source_security_group_id = aws_security_group.storage_gateway.id
}

resource "aws_security_group_rule" "ingress_1026_tcp_product" {
  description              = "activation"
  from_port                = 1026
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deployment_storage_gateway_access.id
  to_port                  = 1026
  type                     = "ingress"
  source_security_group_id = aws_security_group.storage_gateway.id
}

resource "aws_security_group_rule" "ingress_1027_tcp_product" {
  description              = "activation"
  from_port                = 1027
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deployment_storage_gateway_access.id
  to_port                  = 1027
  type                     = "ingress"
  source_security_group_id = aws_security_group.storage_gateway.id
}

resource "aws_security_group_rule" "ingress_1028_tcp_product" {
  description              = "activation"
  from_port                = 1028
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deployment_storage_gateway_access.id
  to_port                  = 1028
  type                     = "ingress"
  source_security_group_id = aws_security_group.storage_gateway.id
}

resource "aws_security_group_rule" "ingress_1031_tcp_product" {
  description              = "activation"
  from_port                = 1031
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deployment_storage_gateway_access.id
  to_port                  = 1031
  type                     = "ingress"
  source_security_group_id = aws_security_group.storage_gateway.id
}

resource "aws_security_group_rule" "ingress_2222_tcp_product" {
  description              = "activation"
  from_port                = 2222
  protocol                 = "tcp"
  security_group_id        = aws_security_group.deployment_storage_gateway_access.id
  to_port                  = 2222
  type                     = "ingress"
  source_security_group_id = aws_security_group.storage_gateway.id
}
