variable "db_identifier" {
  description = "name of db identifier"
  type = string
  default = ""
}

variable "db_name" {
  description = "name od the db"
  type = string
  default = ""
}

variable "username" {
  description = "db user name to login"
  type = string
  default = ""
}

variable "password" {
    description = "password of db must be private"
    type = string
    default = ""
    sensitive = true
}

variable "instance_class" {
    description = "bd type"
    type = string
    default = ""
}

variable "allocated_storage" {
    description = "storage aloccation"
    type = string
    default = ""
}