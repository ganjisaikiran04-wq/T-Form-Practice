resource "aws_security_group" "ec2_sg" {
  name = "ec2-public-sg"

  ingress {
    from_port   = 22
    to_port     = 22
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


resource "aws_security_group" "rds_sg" {
  name = "rds-mysql-sg"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_db_instance" "rds_instance" {
  identifier              = "mydb"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"

  allocated_storage       = 20
  storage_type            = "gp3"

  username                = "admin"
  password                = "password123"
  db_name                 = "dev"

  publicly_accessible     = true

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 1
  apply_immediately       = true
}


resource "aws_key_pair" "key" {
  key_name   = "key-1"
  public_key = file("C:/Users/saiki/.ssh/id_ed25519.pub")
}


resource "aws_instance" "server" {

  ami           = "ami-09c56fed07bc3afe5"
  instance_type = "t3.micro"

  key_name = aws_key_pair.key.id

  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  tags = {
    Name = "public-ec2"
  }
}


resource "null_resource" "script" {

  depends_on = [
    aws_db_instance.rds_instance,
    aws_instance.server
  ]


  connection {
    type        = "ssh"
    host        = aws_instance.server.public_ip
    user        = "ec2-user"
    private_key = file("C:/Users/saiki/.ssh/id_ed25519")
  }


  provisioner "file" {
    source      = "init.sql"
    destination = "/tmp/init.sql"
  }

 provisioner "remote-exec" {
    inline = [
      "sudo dnf update -y",
      "sudo dnf install mariadb105-server -y",

      "mysql -h ${aws_db_instance.rds_instance.address} -u admin -ppassword123 < /tmp/init.sql"
    ]
  }


  triggers = {
    always_run = timestamp()
  }
}


output "rds_endpoint" {
  value = aws_db_instance.rds_instance.address
}


output "ec2_public_ip" {
  value = aws_instance.server.public_ip
}