resource "aws_lb" "lb" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = var.load_balancer_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "lbtargetgroup" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "lblistener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lbtargetgroup.arn
  }
}

resource "aws_lb_listener_certificate" "cert" {
  listener_arn    = aws_lb_listener.lblistener.arn
  certificate_arn = var.acm_certificate_arn
}

resource "aws_route53_record" "load_balancer_dns" {
  zone_id = var.route53_zone_id
  name    = "test.example.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.lb.dns_name]
}
