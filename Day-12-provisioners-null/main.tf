# VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Public Subnet 1
resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "public-subnet-1"
  }
}

# Public Subnet 2
resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-southeast-2b"

  tags = {
    Name = "public-subnet-2"
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Route Table Association for Public Subnet 1
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

# Route Table Association for Public Subnet 2
resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

# Security Group
resource "aws_security_group" "main" {
  name        = "main-sg"
  description = "Security group for internet access"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "main-sg"
  }
}
#key pair 
resource "aws_key_pair" "key" {
  public_key = file("C:/Users/saiki/.ssh/id_ed25519.pub")
  key_name = "key-1"
}

# EC2 Instance with public IP
resource "aws_instance" "server" {
  ami                         = "ami-09c56fed07bc3afe5"
  instance_type               = "t3.micro"
  key_name = aws_key_pair.key.id
  subnet_id                   = aws_subnet.public_1.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.main.id]

  tags = {
    Name = "public-ec2"
  }
}

resource "null_resource" "scrip" {
  
    connection {
        host = aws_instance.server.public_ip
        user = "ec2-user"
        private_key = file("C:/Users/saiki/.ssh/id_ed25519")
    }
    provisioner "file" {
        source = "test.sh"
        destination = "/home/ec2-user/test.sh"
      
    }
    provisioner "remote-exec" {
      inline = [
        "bash /home/ec2-user/test.sh" # Assuming dev.sh is already on the instance
      ]
    }

  #triggers = {
   #  script_hash = filemd5("test.sh") # Rerun only if script changes
#}

   triggers = {
     always_run = "${timestamp()}" # This will ensure the provisioner runs every time you apply, as the timestamp will always change.
   }
   lifecycle {
     create_before_destroy = true
   }
}


