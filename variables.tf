variable "vpc" {
  description = "To get the cidr and name of vpc from user"
  type = object({
    cidr_block = string
    name       = string
  })
  validation {
    condition     = can(cidrnetmask(var.vpc.cidr_block))
    error_message = "Invalid cidr format -${var.vpc.cidr_block}"
  }
}

variable "subnet_config" {
  description = "Get the cidr and az for subnets"
  type = map(object({
    cidr_block = string
    az         = string
    public     = optional(bool, false)
  }))
  validation {
    condition     = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid cidr format"
  }
}
