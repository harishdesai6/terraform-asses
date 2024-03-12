module "vpc" {
  source = "./modules/vpc"

  cidr_block             = var.vpc_cidr_block
  vpc_name               = var.vpc_name
  private_subnet_cidr    = var.private_subnet_cidr
  public_subnet_cidr     = var.public_subnet_cidr
  availability_zone      = var.availability_zone
}

module "load_balancer" {
  source             = "./modules/load_balancer"
  load_balancer_name = var.load_balancer_name
  subnet_ids         = module.vpc.public_subnet_id
  target_group_name  = var.target_group_name
  target_group_port  = var.target_group_port
  vpc_id             = module.vpc.vpc_id
  acm_certificate_arn = var.acm_certificate_arn
  route53_zone_id    = module.route53.private_zone_id
}

#module "ec2" {
    #source      = "./modules/ec2"
    #public_subnets      = module.vpc.public_subnet
    #ami_id      = var.ami_id
    #instance_type       = var.instance_type
    #key_name        = var.key_name
    #webserver_sg_id         = module.lb.lb_sg_id
    #target_group_arn        = module.lb.target_group_arn
#}

module "autoscaling" {
  source = "./modules/auto_scaling"

  launch_configuration_name = var.launch_configuration_name
   image_id  = var.ami_id
   instance_type  = var.instance_type
   security_group_id         = module.security_group.security_group_id
   key_name                  = var.key_name
   root_volume_size          = var.root_volume_size
   root_volume_type          = var.root_volume_type
   autoscaling_group_name    = var.autoscaling_group_name
   min_size                  = var.min_size
   max_size                  = var.max_size
   desired_capacity          = var.desired_capacity
   health_check_grace_period = 150
   #health_check_type         = "ELB"
   vpc_zone_identifier       = ["subnet-02d105e9a0888a940", "subnet-00caa7dcdf42be86c"]
   subnet_ids                = module.vpc.private_subnet_id
   alarm_name                = var.alarm_name
   notification_arn          = module.sns_notification.topic_arn
  }

  module "route53" {
  source             = "./modules/route53"
  vpc_id             = module.vpc.vpc_id
  region             = "ap-south-1"
  zone_name          = var.zone_name
}

module "sns_notification" {
  source = "./modules/sns"

  notification_topic_name = var.notification_topic_name
}

module "security_group" {
  source = "./modules/security_group"

  vpc_id = module.vpc.vpc_id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id
}

