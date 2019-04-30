resource "aws_vpc" "vpc_test" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    enable_dns_hostnames = true
    tags = {
        Name = "Test VPC" 
            
    }
  }
  #VPC peering 
  resource "aws_vpc_peering_connection" "test_web" {
  #peer_owner_id = "${var.peer_owner_id}"
  peer_vpc_id   = "${var.vpc_peer_id}"
  vpc_id        = "${aws_vpc.vpc_test.id}"
  auto_accept   = true

  tags = {
    Name = "VPC Peering between vpc_test and vpc_10"
  }
}





