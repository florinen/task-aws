resource "aws_subnet" "pub_1_subnet_eu_west_1a" {
    vpc_id = "${aws_vpc.vpc_test.id}"
    cidr_block = "${var.pub_1_subnet_cidr}"
    map_public_ip_on_launch = true  #any instance created in this subnet will have a public IP
    availability_zone = "eu-west-1a"
    tags = {
        Name = "pub_test_1"    
    }
resource "aws_subnet" "pub_2_subnet_eu_west_1b" {
    vpc_id = "${aws_vpc.vpc_test.id}"
    cidr_block = "${var.pub_2_subnet_cidr}"
    map_public_ip_on_launch = true  #any instance created in this subnet will have a public IP
    availability_zone = "eu-west-1b"
    tags = {
        Name = "pub_test_2"    
    }
}
resource "aws_subnet" "priv_1_subnet_eu_west_1a" {
    vpc_id = "${aws_vpc.vpc_test.id}"
    cidr_block = "${var.priv_1_subnet_cidr}"
    availability_zone = "eu-west-1a"
    tags = {
        Name = "priv_test_1"    
    }
resource "aws_subnet" "priv_2_subnet_eu_west_1b" {
    vpc_id = "${aws_vpc.vpc_test.id}"
    cidr_block = "${var.priv_2_subnet_cidr}"
    availability_zone = "eu-west-1a"
    tags = {
        Name = "priv_test_2"    
    }
   }
  }
}