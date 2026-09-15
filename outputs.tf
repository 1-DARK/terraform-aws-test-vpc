#vpc
output "vpc_id" {
  value = aws_vpc.main.id
}

locals {
  #To format the subnet ids which may be multiples in format of subnet_name={id=,az=}
  public_subnet_output = {
    for key, config in local.public_subnets : key => {
      subnet_id = aws_subnet.main1[key].id
      az        = aws_subnet.main1[key].availability_zone
    }
  }
  private_subnet_output = {
    for key, config in local.private_subnets : key => {
      subnet_id = aws_subnet.main1[key].id
      az        = aws_subnet.main1[key].availability_zone
    }
  }
}

#subnet_details
output "public_subnet" {
  value = local.public_subnet_output
}

output "private_subnet" {
  value = local.private_subnet_output
}
