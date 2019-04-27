# This is the public subnet and all traffic destined for internet will be 
# directed to IGW
resource "aws_route" "pub_route" {
    route_table_id = "${aws_vpc.vpc_test.pub_route_table.id}"
    destination_cidr_block = "${var.to_anywhere}"
    gateway_id = "${aws_internet_gateway.igw.id}"
  
}
resource "aws_route_table" "pub_route_table" {
    vpc_id = "${aws_vpc.vpc_test.id}"
    route {
        cidr_block = "${var.to_anywhere}"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }
    #route {
     #   cidr_block = "${var.pub_2_subnet_cidr}"
     #   gateway_id = "${aws_internet_gateway.igw.id}"
    #}
    tags = {
        Name = "pub_route_table"
        enviroment = "${var.enviroment},${count.index +1}"
    }
}  


# This will create a route table for the private network
resource "aws_route_table" "priv_route_table" {
    vpc_id = "${aws_vpc.vpc_test.id}"
    route {
        cidr_block = "${var.to_anywhere}"
        nat_gateway_id = "${aws_nat_gateway.nat.id}"
    }
    #route {
     #   cidr_block = "${var.priv_2_subnet_cidr}"
     #   nat_gateway_id = "${aws_nat_gateway.nat.id}"
    #}
    tags = {
        Name = "priv_route_table"
        environment = "${var.enviroment},${count.index +1 }"
    }
}
# This will route traffic for the internet to the NG  

resource "aws_route" "priv_route" {
    route_table_id = "${aws_route_table.priv_route_table.id}"
    destination_cidr_block = "${var.to_anywhere}"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
  
}

