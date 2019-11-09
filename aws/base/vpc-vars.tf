provider "aws" {
  	version = "~> 2.7"
  	region = "us-east-1"
	profile = "default-owlmtn"
}

variable "vpc_cidr" {
	default = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
	type = "list"
	default = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = ["10.20.10.0/24", "10.20.11.0/24"]
}

variable "azs" {
	type = "list"
	default = ["us-east-1a", "us-east-1b"]
}

variable "ingressCIDRblock" {
        type = "list"
        default = [ "0.0.0.0/0" ]
}

variable "destinationCIDRblock" {
        default = "0.0.0.0/0"
}