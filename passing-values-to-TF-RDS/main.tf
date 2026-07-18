module "RDS" {
  source = "../terraform-rds-task"
  db_identifier = var.db_identifier
  db_name = var.db_name
  username = var.username
  password = var.password
  instance_class = var.instance_class
  allocated_storage = var.allocated_storage
}