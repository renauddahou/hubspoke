
resource "aws_security_group" "nsg_hub_public_fw" {
  tags = {
    Name = "nsg-hub-public-fw"
  }

  tags_all = {
    Name = "nsg-hub-public-fw"
  }

  description = "Allow-firewall-access"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    from_port       = 0
    protocol        = "-1"
    security_groups = [aws_security_group.nsg_hub_public_alb.id, aws_security_group.nsg_hub_vpn.id]
    to_port         = 0
  }

  name   = "nsg-hub-public-fw"
  vpc_id = var.hub_vpc_id
}