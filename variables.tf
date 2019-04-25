variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "eu-west-1"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        eu-west-1 = "ami-0ff760d16d9497662" # Centos 7 x64
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "192.168.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "192.168.1.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "192.168.10..0/24"
}