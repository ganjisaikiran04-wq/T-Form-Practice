resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
      name = var.vpc_name
    }
}

resource "aws_subnet" "public-subnet-1" {
    vpc_id     = aws_vpc.vpc.id
    cidr_block = var.public-subnet-1_cidr_block
    availability_zone = "ap-southeast-2a"
    tags = {
      name = var.public-subnet-1_name
    }
}

resource "aws_subnet" "public-subnet-2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public-subnet-2_cidr_block
    availability_zone = "ap-southeast-2b"
    tags = {
      name = var.public-subnet-2_name
    }
}

resource "aws_subnet" "private-subnet-1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private-subnet-1_cidr_block
    availability_zone = "ap-southeast-2a"
    tags = {
      name = var.private-subnet-1_name
    }
  
}

resource "aws_subnet" "private-subnet-2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private-subnet-2_cidr_block
    availability_zone = "ap-southeast-2b"
    tags = {
      name = var.private-subnet-2_name
    }
  
}

resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        name = "IGW"
    }
  
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public-subnet-1.id
  tags = {
    name = "NAT"
  }
}

resource "aws_route_table" "pvtrt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "rta3" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.pvtrt.id
}

resource "aws_route_table_association" "rta4" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.pvtrt.id
}

resource "aws_security_group" "sg" {
  name = "sg"
  description = "Allow SSH and HTTP"
  vpc_id = aws_vpc.vpc.id

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
    ami = var.public_ec2_ami_id
    instance_type = var.public_instance_type
    subnet_id = aws_subnet.public-subnet-1.id
    associate_public_ip_address = true
    security_groups = [aws_security_group.sg.id]
    tags = {
        Name = "public-instance"
    }
}

resource "aws_instance" "private_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private-subnet-1.id
  vpc_security_group_ids = [aws_security_group.sg.id]

  user_data = <<EOF
#!/bin/bash

yum update -y
yum install -y httpd

systemctl enable httpd
systemctl start httpd

cat > /var/www/html/index.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Terraform Deployment</title>
<style>
body{
background:#f4f7fb;
font-family:Arial;
text-align:center;
padding-top:50px;
}
.container{
width:70%;
margin:auto;
background:white;
padding:40px;
border-radius:10px;
box-shadow:0 0 15px rgba(0,0,0,.2);
}
</style>
</head>
<body>

<div class="container">

<h1>🚀 Terraform Infrastructure Deployment Successful!</h1>

<h2>Congratulations!</h2>

<p>Your AWS infrastructure has been provisioned successfully using <strong>Terraform</strong>.</p>

<ul style="display:inline-block;text-align:left;">
<li>✅ VPC</li>
<li>✅ Public Subnet</li>
<li>✅ Private Subnet</li>
<li>✅ Internet Gateway</li>
<li>✅ NAT Gateway</li>
<li>✅ Security Group</li>
<li>✅ EC2 Instance</li>
<li>✅ Application Load Balancer</li>
<li>✅ IAM Role</li>
<li>✅ RDS Database</li>
</ul>

<p style="color:green;font-weight:bold;">
Apache is Running Successfully!
</p>

</div>

</body>
</html>
HTML

EOF


}

resource "aws_lb_target_group" "tg" {
  name = "Target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc.id

  health_check {
    path = "/"
    protocol = "HTTP"
    interval = 60
    timeout = 10
    healthy_threshold = 5
    unhealthy_threshold = 5
  }

  tags = {
    Name = "Target-Group"
  }
}

resource "aws_lb" "LB" {
  name = "application-lb"
  internal = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.sg.id]
  subnets = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]

  enable_deletion_protection = false
  tags = {
    Name = "Application-Load-Balancer"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.LB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group_attachment" "tg-attachment" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.private_ec2.id
  port             = 80
}

