output "instance_ids" {
  value       = { for k, v in aws_instance.server : k => v.id }
  description = "EC2 instance IDs"
}

output "instance_ips" {
  value       = { for k, v in aws_instance.server : k => v.public_ip }
  description = "Public IP addresses of instances"
}
