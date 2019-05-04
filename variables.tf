variable "aws_region" {
    description = "Region for the VPC"
    default = "eu-west-1"
}

variable "amis" {
    description = "AMIs by region"
    default = "ami-0b98979bd494eba08" # Custom Centos 7 x64
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "192.168.0.0/16"
}

variable "pub_1_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "192.168.1.0/24"
}
variable "pub_2_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "192.168.2.0/24"
}

variable "priv_1_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "192.168.10.0/24"
}
variable "priv_2_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "192.168.11.0/24"
}
variable "from_anywhere" {
    default = "0.0.0.0/0"
  
}
variable "to_anywhere" {
    default = "0.0.0.0/0"
  
}
variable "vpc-10_cidr_block" {
    default ="10.10.0.0/16"
  
}
variable "name" {
    default = "web"
  
}


variable "count" {
    description = "Total the number of EC2"
    default = 1
}
variable "key_name" {
    description = "Key pair to SSH in"
    default = "Laptop"
}
variable "instance_type" {
    default = "t2.micro"
    description = "Select an EC2 type"  
}
variable "enviroment" {
    default = "test"
    description = "Select work enviroment Dev, Qa, Prod etc.."
}
variable "created_by" {
  default = "Florin Nenciu"
  description = "who created the resources"
}
variable "min_zise" {
    default = "2"
  
}
variable "max_zise" {
    default = "4"
  
}
variable "s3_bucket" {
    default = "task-florin"
  
}
variable "priority" {
    description = "Listiner priority value"
    default = "100"
  
}
variable "vpc_peer_id" {
    default = "vpc-0ef7225c27938e12e"
}
variable "parent_zone_id" {
  default     = ""
  description = "ID of the hosted zone to contain this record  (or specify `parent_zone_name`)"
}
variable "parent_zone_name" {
  default     = "devopnet.com"
  description = "Name of the hosted zone to contain this record (or specify `parent_zone_id`)"
}


variable "ip_add" {}






