resource "aws_vpc" "vpc_test" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    enable_dns_hostnames = true
    tags = {
        Name = "Test VPC" 
            
    }
  }
