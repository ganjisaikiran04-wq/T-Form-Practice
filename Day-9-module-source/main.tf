resource "aws_vpc" "VPC_main" {
  cidr_block = var.cidr_block
  tags = {
    Name = "VPC(main)"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.VPC_main.id
  cidr_block        = var.subnet1_cidr_block
  availability_zone = "ap-southeast-2a"
  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.VPC_main.id
  cidr_block        = var.subnet2_cidr_block
  availability_zone = "ap-southeast-2b"
  tags = {
    Name = "subnet2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC_main.id
  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.VPC_main.id
  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route" "route" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_security_group" "sg" {
  name        = var.sg_name
  description = "Security group for EC2 instance"
  vpc_id      = aws_vpc.VPC_main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
}
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ec2_instance_ami
  instance_type = var.ec2_instance_type
  subnet_id     = aws_subnet.subnet1.id
  vpc_security_group_ids = [
  aws_security_group.sg.id
]

  tags = {
    Name = var.ec2_instance_name
  }
}

