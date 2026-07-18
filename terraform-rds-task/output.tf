output "endpoint" {
  value = aws_db_instance.RDS.endpoint
}

output "db_identifier" {
  value = aws_db_instance.RDS.identifier
}