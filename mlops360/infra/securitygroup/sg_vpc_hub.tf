resource "aws_security_group" "nsg_vpc_hub" {
  tags = {
    Name = "nsg-vpc-hub"
  }
  description = "default VPC security group"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "tcp"
    to_port     = 65535
  }


  ingress {
    cidr_blocks = ["${var.hub_vpc_cidr_block}"]
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
  }

  ingress {
    from_port = 0
    protocol  = "-1"
    self      = true
    to_port   = 0
  }

  name   = "nsg-vpc-hub"
  vpc_id = var.hub_vpc_id
}