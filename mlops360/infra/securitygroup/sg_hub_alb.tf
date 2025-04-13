resource "aws_security_group" "nsg_hub_public_alb" {
  tags = {
    Name = "nsg-hub-public-alb"
  }
  description = "allow_http-https-traffic"
  egress {
    cidr_blocks = ["${var.hub_vpc_cidr_block}"]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  egress {
    cidr_blocks = ["${var.hub_vpc_cidr_block}"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  name   = "nsg-hub-publuc-alb"
  vpc_id = var.hub_vpc_id
}