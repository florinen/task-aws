resource "aws_subnet" "pub_1_subnet_eu_west_1a" {
    vpc_id = "${aws_vpc.vpc_test.id}"
    cidr_block = "192.168.1.0/24"
    map_public_ip_on_launch = true  #any instance created in this subnet will have a public IP
    availability_zone = "eu-west-1a"
    tags = {
        Name = "pub_test_1"    
    }
  
}
resource "aws_subnet" "priv_1_subnet_eu_west_1a" {
    vpc_id = "${aws_vpc.vpc_test.id}"
    cidr_block = "192.168.2.0/24"
    availability_zone = "eu-west-1a"
    tags = {
        Name = "priv_test_1"    
    }
  
}
