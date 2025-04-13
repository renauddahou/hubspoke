resource "aws_security_group" "nsg_hub_vpn" {
  tags = {
    Name = "nsg-hub-vpn"
  }
  description = "Access Admin Users"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "tcp"
    to_port     = 65535
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "udp"
    to_port     = 65535
  }


  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acces Point-to-Site VPN"
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "acces BDD PostgreSQL"
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "acces BDD mysql"
    from_port   = 3306
    protocol    = "tcp"
    to_port     = 3306
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acces Point-to-Site VPN"
    from_port   = 1194
    protocol    = "udp"
    to_port     = 1194
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Access SSH"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acces Point-to-Site VPN"
    from_port   = 443
    protocol    = "udp"
    to_port     = 443
  }
  name   = "nsg-hub-gvpn"
  vpc_id = var.hub_vpc_id
}
