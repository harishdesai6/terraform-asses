output "vpc_id" {
  value       = module.vpc.vpc_id
}

output "private_subnet_id" {
  value       = module.vpc.private_subnet_id
}

output "public_subnet_id" {
  value       = module.vpc.public_subnet_id
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.igw.id
}

