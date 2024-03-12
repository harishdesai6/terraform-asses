resource "aws_route53_zone" "private" {
  vpc {
    vpc_id     = var.vpc_id
    vpc_region = var.region
  }

  name = var.zone_name

  tags = {
    Name = var.zone_name
  }
}
