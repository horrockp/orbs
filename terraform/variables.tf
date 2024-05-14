variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
  type        = string
 }

variable "public_subnet_cidr_1" {
  description = "The CIDR block for the public subnet"
  default     = "10.0.1.0/24"
  type        = string
}

variable "public_subnet_cidr_2" {
  description = "The CIDR block for the public subnet"
  default     = "10.0.2.0/24"
  type        = string
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  default     = "10.0.3.0/24"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy in"
  default     = "eu-west-2"
  type        = string
}

variable "availability_zone_names" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}