resource "aws_vpc" "name" {
  cidr_block = var.cidr_block
  tags = {
    name = "my-vpc"
  }
}

resource "aws_subnet" "subnet_1" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.subnet_cidr_block_1
    tags = {
        name = "subnet-1"
    }
}

resource "aws_subnet" "subnet_2" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.subnet_cidr_block_2
    tags = {
        name = "subnet-2"
    }
}

resource "aws_security_group" "name" {
    name = var.security_group_name
    description = var.security_group_description
    vpc_id = aws_vpc.name.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}   

resource "aws_instance" "name" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.subnet_1.id
  vpc_security_group_ids = [aws_security_group.name.id]
  tags = {
    name = "EC2-1"
  }
}
