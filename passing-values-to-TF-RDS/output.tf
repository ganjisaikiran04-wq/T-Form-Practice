output "rds_endpoint" {
  value = module.RDS.endpoint
}

output "rds_identifier" {
  value = module.RDS.db_identifier
}