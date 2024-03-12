variable "launch_configuration_name" {
description = "launch configuration Name"
}
variable "image_id" {}
variable "instance_type" {}
variable "security_group_id" {}
variable "key_name" {}
variable "root_volume_size" {}
variable "root_volume_type" {}
variable "autoscaling_group_name" {}
variable "min_size" {}
variable "max_size" {}
variable "desired_capacity" {}
variable "subnet_ids" {}
variable "alarm_name" {}
variable "notification_arn" {}
variable "health_check_grace_period" {}
variable "vpc_zone_identifier" {}

