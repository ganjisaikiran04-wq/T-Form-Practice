resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "vpc-2   "
    }
  
}

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "subnet-1"
    }
}
