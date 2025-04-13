resource "aws_key_pair" "nat_intance_keypair" {
  key_name   = "nat-intance-keypair"
  public_key = file("${path.module}/.ssh/id_rsa.pub")
}



resource "aws_instance" "nat_hub_instance" {
  ami                         = "ami-0005e0cfe09cc9050"
  instance_type               = "t2.micro"
  subnet_id                   = var.sn_hub_private_fw_a_id
  key_name                    = aws_key_pair.nat_intance_keypair.key_name
  associate_public_ip_address = false # 🚫 Pas d’IP publique
  security_groups             = [var.nsg_vpc_hub_id]
  source_dest_check           = false

  tags = {
    Name  = "NAT-Instance"
    Infra = "HUB"
  }
}



