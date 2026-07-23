variable "aws_region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "ap-southeast-1"
}

variable "tags" {
    type = list(string)
    default = [ "dev", "test", "prod" ]
  
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-00692a4a7597dc5fd"
}