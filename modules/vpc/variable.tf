variable "cidr_block" {}
variable "private_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.5.0/24", "10.0.7.0/24"]
}

variable "vpc_name" {}
variable "availability_zone" {
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}


