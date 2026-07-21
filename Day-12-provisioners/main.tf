resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-southeast-2a"
  tags = {
    name = "public-subnet"
  }

}

resource "aws_subnet" "subnet_2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-2b"
  tags = {
    name = "public-subnet-2"
  }

}

resource "aws_internet_gateway" "IG" {
    vpc_id = aws_vpc.main.id
  
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.main.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }
  
}

resource "aws_route_table_association" "RTA" {
  subnet_id = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "RTA2" {
  subnet_id = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "SG" {
    name = "my-sg"
    vpc_id = aws_vpc.main.id

    ingress {
      description = "Allow SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_key_pair" "key" {
  public_key = file("C:/Users/saiki/.ssh/id_ed25519.pub")
  key_name = "key-1"
  
}

resource "aws_instance" "ec2" {
    ami = "ami-09c56fed07bc3afe5"
    instance_type = "t3.micro"
    key_name = aws_key_pair.key.key_name
    subnet_id = aws_subnet.subnet_1.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.SG.id]
    tags = {
        name = "linux-server"
    }

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      timeout     = "5m"
      private_key = file("C:/Users/saiki/.ssh/id_ed25519")
    }

    provisioner "file" {
      source      = "${path.module}/file1"
      destination = "/home/ec2-user/file1"  # destination path on the remote instance
    }

    provisioner "remote-exec" {
      inline = [
        "touch /home/ec2-user/file2",
        "echo 'hello from 10:30 am batch' >> /home/ec2-user/file2"
      ]
    }

    provisioner "local-exec" {
       command = "touch file3"
    }
}