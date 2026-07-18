resource "aws_db_instance" "RDS" {
    identifier = var.db_identifier
    instance_class = var.instance_class
    allocated_storage = var.allocated_storage
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "8.0"

    db_name = var.db_name
    username = var.username
    password = var.password

    publicly_accessible = true
    skip_final_snapshot = true


}