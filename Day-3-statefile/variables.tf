variable "cidr_block" {
  description = "cidr for vpc"
  type = string
  default = ""
}

variable "subnet_cidr_block_1" {
  description = "cidr for subnet 1"
  type = string
  default = ""
}

variable "subnet_cidr_block_2" {
  description = "cidr for subnet 2"
  type = string
  default = ""
}

variable "security_group_name" {
  description = "security group name"
  type = string
  default = ""
}

variable "security_group_description" {
  description = "security group description"
  type = string
  default = ""
}

variable "ingress_from_port" {
  description = "ingress from port"
  type = number
  default = 0
}

variable "egress_to_port" {
  description = "egress to port"
  type = number
  default = 0
}

variable "instance_ami_id" {
  description = "ami to launch instance"
  type = string
  default = ""
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = ""
}
