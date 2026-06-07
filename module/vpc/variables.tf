variable "subnets" {
  type = map(object({
    cidr_block = string
    tier = string
    az = string
  }))
}

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/24"
}

variable "vpc_tag" {
  type = map(string)
  default = {
    Enviroment = "testing"
    Project = "Lab"
  }
}
