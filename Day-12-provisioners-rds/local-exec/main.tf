resource "aws_db_instance" "rds_instance" {
  identifier              = "mydb"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp3"
  username                = var.db_username
  password                = var.db_password
  db_name                 = "mydb"
  publicly_accessible     = true
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 1
  apply_immediately       = true

}

resource "null_resource" "local-exec" {
  depends_on = [ aws_db_instance.rds_instance ]

  provisioner "local-exec" {
    command = "mysql -h ${aws_db_instance.rds_instance.address} -u admin -pP@ssw0rd1234! dev < init.sql"

  }

  triggers = {
    always_run = timestamp()
  }
}
