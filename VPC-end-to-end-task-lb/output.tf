output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "vpc_cidr" {
  description = "VPC CIDR Block"
  value       = aws_vpc.vpc.cidr_block
}

output "public_subnet_1_id" {
  description = "Public Subnet 1 ID"
  value       = aws_subnet.public-subnet-1.id
}

output "public_subnet_2_id" {
  description = "Public Subnet 2 ID"
  value       = aws_subnet.public-subnet-2.id
}

output "private_subnet_1_id" {
  description = "Private Subnet 1 ID"
  value       = aws_subnet.private-subnet-1.id
}

output "private_subnet_2_id" {
  description = "Private Subnet 2 ID"
  value       = aws_subnet.private-subnet-2.id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.IGW.id
}

output "public_route_table_id" {
  description = "Public Route Table ID"
  value       = aws_route_table.RT.id
}

output "private_route_table_id" {
  description = "Private Route Table ID"
  value       = aws_route_table.pvtrt.id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.NAT.id
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.sg.id
}

output "alb_dns_name" {
  description = "DNS Name of ALB"
  value       = aws_lb.LB.dns_name
}

output "alb_arn" {
  description = "ARN of ALB"
  value       = aws_lb.LB.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.tg.arn
}

output "listener_arn" {
  value = aws_lb_listener.listener.arn
}