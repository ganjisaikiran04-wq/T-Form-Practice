locals {
  ingress_rules = {
    22 = ["122.174.61.84/32"]
    80 = ["0.0.0.0/0"]
    443 = ["0.0.0.0/0"]
    3000 = ["122.174.61.85/32", "122.174.61.86/32"]
    8080 = ["122.174.61.87/32"]
    8082 = ["122.174.61.88/32"]
    9000 = ["122.174.61.89/32", "122.174.61.90/32"]
  }
}

resource "aws_security_group" "SG" {
  name        = "My-SG"
  description = "Allow inbound traffic"

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = "Port ${ingress.key}"
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ingress.value
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My-SG"
  }
}

resource "aws_security_group" "SG_2" {
  name        = "My-SG-2"
  description = "Allow inbound traffic"

  ingress = [
    for port, cidrs in {
      22   = ["122.174.61.84/32"]
      80   = ["0.0.0.0/0"]
      443  = ["0.0.0.0/0"]
      3000 = ["122.174.61.85/32", "122.174.61.86/32"]
      8080 = ["122.174.61.87/32"]
      8082 = ["122.174.61.88/32"]
      9000 = ["122.174.61.89/32", "122.174.61.90/32"]
    } : {
      description      = "Inbound rule for port ${port}"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = cidrs
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My-SG-2"
  }
}
