provider "aws" {
  region = "us-east-2"
}
variable "key_name" {
    default = "key_1"
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_instance" "web" {
  ami                         = "ami-03657b56516ab7912"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet_public.id
  vpc_security_group_ids      = [aws_security_group.sg_22_80.id]
  associate_public_ip_address = true
  key_name      = aws_key_pair.generated_key.key_name
  user_data = " ${file("Bash_install_Ngnx.sh")} "
}

output "public_ip" {
  value = aws_instance.web.public_ip
}
