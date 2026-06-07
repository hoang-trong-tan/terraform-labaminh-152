variable "subnets" {
  type = map(object({
    cidr_block = string
    tier       = string
    az         = string
  }))
  default = {
    "public_subnet_1" = {
      cidr_block = "10.0.1.0/24"
      tier       = "public"
      az         = "ap-southeast-1a"
    }
    "private_subnet_1" = {
      cidr_block = "10.0.2.0/24"
      tier       = "private"
      az         = "ap-southeast-1b"
    }
  }
}


variable "username_db" {
  type = string
}

variable "password_db" {
  type = string
}

variable "vpc_tag" {
  type = map(string)
  default = {
    Enviroment = "testing"
    Project    = "Lab"
  }
}

variable "s3_tag" {
  type = map(string)
}


variable "dynamodb_table_name" {
  type    = string
  default = "terraform-state-locks"
}
