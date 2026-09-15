output "vpc" {
  description = "The unique AWS Resource ID of the Virtual Private Cloud (VPC) created by the myvpc module."
  value       = module.myvpc.vpc_id
}

output "public_subnet" {
  description = "List of IDs for the public subnets that have routes to an Internet Gateway."
  value       = module.myvpc.public_subnet
}

output "private_subnet" {
  description = "List of IDs for the isolated private subnets reserved for internal resources."
  value       = module.myvpc.private_subnet
}
