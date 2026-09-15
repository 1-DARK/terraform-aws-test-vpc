This is complete config to work with this module.

USAGE

```
provider "aws" {
  region = "ap-south-1"
}
module "myvpc" {
  source = "./module/vpc"
  vpc = {
    cidr_block = "10.0.0.0/16"
    name       = "your_vpc_name"
  }
  subnet_config = {
    public_subnet = {
      cidr_block = "10.0.1.0/24"
      az         = "ap-south-1a"
      #To set the subnet as public, default is private
      public     = true
    }
    private_subnet = {
      cidr_block = "10.0.2.0/24"
      az         = "ap-south-1b"
    }
  }
}
```
