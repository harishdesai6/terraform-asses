resource "aws_launch_configuration" "webserver" {
  name                        = var.launch_configuration_name
  image_id               = var.image_id
  key_name               = var.key_name
  instance_type          = var.instance_type
  #user_data              = filebase64("install_script.sh")
  security_groups = [var.security_group_id]
  associate_public_ip_address = true
 
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
  }

  ebs_block_device {
    device_name           = "/dev/xvdf"
    volume_size           = 20
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  } 
}

resource "aws_autoscaling_group" "asg" {
  name                      = "asg"
  launch_configuration      = aws_launch_configuration.webserver.name
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = "ELB"
  vpc_zone_identifier       = var.subnet_ids
     tag {
    key                 = "Name"
    value               = var.autoscaling_group_name
    propagate_at_launch = true
  }
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name          = var.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
  
  alarm_actions     = [var.notification_arn]
}
 
