variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "public-subnet-1_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "public-subnet-2_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "private-subnet-1_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "private-subnet-2_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "vpc_name" {
  description = "tags for the VPC"
  type        = string
  default     = ""
}



variable "public-subnet-2_name" {
  description = "tags for the public subnet-2"
  type        = string
  default     = ""
}

variable "sg_ingress_ports" {
    description = "List of ingress ports for the security group"
    type = list(number)
    default = []
}

variable "private-subnet-2_name" {
  description = "tags for the priavate subnet-2"
  type        = string
  default     = ""
}

variable "private-subnet-1_name" {
  description = "tags for the private subnet-2"
  type        = string
  default     = ""
}

variable "public-subnet-1_name" {
  description = "tags for the public subnet-1"
  type        = string
  default     = ""
}

variable "ami_id" {
  description = "ami of ec2"
  type = string
  default = ""
  }

variable "instance_type" {
  description = "instance type"
  type = string
  default = ""
}

variable "public_ec2_ami_id" {
  description = "ami of ec2"
  type = string
  default = ""
  }

  variable "public_instance_type" {
  description = "instance type"
  type = string
  default = ""
}