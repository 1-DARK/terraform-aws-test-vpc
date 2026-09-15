provider "aws" {
  region = "ap-south-1"
}
module "myvpc" {
  source = "./module/vpc"
  vpc = {
    cidr_block = "10.0.0.0/16"
    name       = "myvpc"
  }
  subnet_config = {
    public_subnet = {
      cidr_block = "10.0.1.0/24"
      az         = "ap-south-1a"
      public     = true
    }
    private_subnet = {
      cidr_block = "10.0.2.0/24"
      az         = "ap-south-1b"
    }
  }
}

