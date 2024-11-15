resource "aws_vpc" "ec2_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "ec2-vpc"
  }
}

resource "aws_subnet" "ec2_subnet" {
  vpc_id     = aws_vpc.ec2_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true

  tags = {
    Name = "ec2-subnet"
  }
}

resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Security group for EC2 instance"

  vpc_id = aws_vpc.ec2_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-security-group"
  }
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  subnet_id              = aws_subnet.ec2_subnet.id

  key_name               = var.key_name
}
