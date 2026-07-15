resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
    tags = {
        Name = "vpc-main"   
    }
}

resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-southeast-2a"
    tags = {
        Name = "subnet-1"
    }
}

resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-2b"
    tags = {
        Name = "subnet-2"
    }
}

resource "aws_security_group" "sg" {
  name        = "allow_mysql"
  description = "Allow MySQL inbound traffic"
  vpc_id      = aws_vpc.name.id

  ingress {
    from_port   = 3306
    to_port     = 3306
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
    from_port   = 6379
    to_port     = 6379
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
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  tags = {
    Name = "My DB Subnet Group"
  }
}

resource "aws_db_instance" "mydb" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  identifier           = "mydatabase"
  username             = "admin"
  password             = "Cloud123"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.sg.id]
  skip_final_snapshot   = true
  maintenance_window     = "Mon:00:00-Mon:03:00"
  publicly_accessible     = true
  backup_retention_period = 1
  apply_immediately        = true
}

resource "aws_db_instance" "replica" {
  identifier = "mydbsreplica"
  instance_class = "db.t3.micro"
  engine = "mysql"
  storage_type = "gp2"
  replicate_source_db = aws_db_instance.mydb.arn
  vpc_security_group_ids = [aws_security_group.sg.id]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  backup_retention_period = 1
  apply_immediately = true
}

resource "aws_db_parameter_group" "mydb_parameter_group" {
  name        = "mydb-parameter-group"
  family      = "mysql8.0"
  description = "Custom parameter group for MySQL 8.0"

  parameter {
    name  = "max_connections"
    value = "200"
  }

  parameter {
    name  = "wait_timeout"
    value = "600"
  }
}

resource "aws_elasticache_parameter_group" "redis_parameter_group" {
  name        = "redis-parameter-group"
  family      = "redis6.x"
  description = "Custom parameter group for Redis 6.x"

  parameter {
    name  = "maxmemory-policy"
    value = "allkeys-lru"
  }

  parameter {
    name  = "timeout"
    value = "300"
  }
}

resource "aws_elasticache_subnet_group" "redis-cache-subnet-group" {
  name       = "redis-cache-subnet-group"
  subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_elasticache_cluster" "redis-cache" {
  cluster_id = "redis-cache"
  node_type = "cache.t3.micro"
  engine = "redis"
  engine_version = "6.x"
  port = 6379
  num_cache_nodes = 1
  parameter_group_name = aws_elasticache_parameter_group.redis_parameter_group.name
  security_group_ids = [aws_security_group.sg.id]
  subnet_group_name = aws_elasticache_subnet_group.redis-cache-subnet-group.name

  
}