variable "load_balancer_name" {}
variable "subnet_ids" {
  type        = list(string)
}
variable "target_group_name" {}
variable "target_group_port" {}
variable "vpc_id" {}
variable "acm_certificate_arn" {}
variable "route53_zone_id" {
  type        = string
}


