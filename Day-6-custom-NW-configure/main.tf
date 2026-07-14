resource "aws_vpc" "name" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "vpc(main)"
    }
  
}

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.subnet1_cidr
    tags = {
        Name = "subnet-1"
    }
}

resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.subnet2_cidr
    tags = {
        Name = "subnet-2"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.name.id
    tags = {
        Name = "igw"
    }
}

resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}       

resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "sg" {
    name = "sg"
    description = "Allow SSH and HTTP"
    vpc_id = aws_vpc.name.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }
    ingress {
        from_port = 80
        to_port = 80
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

resource "aws_instance" "public" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.subnet1.id
    associate_public_ip_address = true
    security_groups = [aws_security_group.sg.id]
    tags = {
        Name = "public-instance"
    }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.subnet2.id
    tags = {
        Name = "nat-gateway"
    }
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }
}
 resource "aws_route_table_association" "private_rta" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.private_rt.id
 }

resource "aws_instance" "private" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.subnet2.id
    security_groups = [aws_security_group.sg.id]
    tags = {
        Name = "private-instance"
    }
}