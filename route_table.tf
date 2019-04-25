# This is the public subnet and all traffic destined for internet will be 
# directed to IGW
resource "aws_route" "internet_access" {
    route_table_id = "${aws_vpc.vpc_test.main_route_table_id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  
}
# This will create a route table for the private network
resource "aws_route_table" "priv_route_table" {
    vpc_id = "${aws_vpc.vpc_test.id}"

    tags = {
        Name = "priv_route_table"
    }
# This will route traffic for the internet to the NG  
}
resource "aws_route" "priv_route" {
    route_table_id = "${aws_route_table.priv_route_table.id}"
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
  
}
