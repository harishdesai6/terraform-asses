variable "public_subnets" {
    # type  = list(String)
}

variable "ami_id" {}

variable "instance_type" {}

variable "key_name" {}

variable "webserver_sg_id" {
    type  = string
}

variable "target_group_arn" {} 
