output "publicip" {
  value = aws_instance.public.public_ip
  description = "Public IP of the instance"
}

output "privateip" {
  value = aws_instance.private.private_ip
  description = "Private IP of the private instance"
}

output "instanceid" {
  value = aws_instance.public.id
  description = "ID of the instance"
}

output "subnet1id" {
  value = aws_subnet.subnet1.id
  description = "ID of the subnet-1"
}

output "AZ" {
  value = aws_instance.public.availability_zone
  description = "Availability Zone of the instance"
}

output "vpcid" {
  value = aws_vpc.name.id
  description = "ID of the VPC"
}

output "subnet2id" {
  value = aws_subnet.subnet2.id
  description = "ID of the subnet-2"
}


