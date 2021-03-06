# This is the public subnet and all traffic destined for internet will be 
# directed to IGW
#resource "aws_route" "main_route" {
 #  route_table_id = "${aws_vpc.vpc_test.main_route_table_id}"
 #  destination_cidr_block = "${var.to_anywhere}"
 #  gateway_id = "${aws_internet_gateway.igw.id}"
     
#}

# Define the public route table
resource "aws_route_table" "pub_route_table" {
    vpc_id = "${aws_vpc.vpc_test.id}"
    route {
        cidr_block = "${var.to_anywhere}"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }
    route {
        cidr_block = "10.10.0.0/16"
        vpc_peering_connection_id = "${aws_vpc_peering_connection.test_web.id}"

    }
    
    tags = {
        Name = "pub_route_table"
        
    }
}  

# Define the private route table
resource "aws_route_table" "priv_route_table" {
    vpc_id = "${aws_vpc.vpc_test.id}"
    
    route {
        cidr_block = "${var.to_anywhere}"
        nat_gateway_id = "${aws_nat_gateway.nat.id}"
    }
    #route {
     #   cidr_block = "10.10.0.0/16"
     #   vpc_peering_connection_id = "${aws_vpc_peering_connection.test_web.id}"

    #}
    
    tags = {
        Name = "priv_route_table"
        
    }
}
# This will route traffic for the internet to the NG  

#resource "aws_route" "test_to_web" {
 #   route_table_id = "${aws_vpc.vpc_test.main_route_table_id}"
 #   destination_cidr_block = "10.10.0.0./16"
 #   vpc_peering_connection_id = "${aws_vpc_peering_connection.test_web.id}"
  
#}

#resource "aws_route" "web_to_test" {
  #  route_table_id = "${aws_vpc.vpc_test.main_route_table_id}"
  #  destination_cidr_block = "192.168.0.0/16"
 #   vpc_peering_connection_id = "${aws_vpc_peering_connection.test_web.id}"
  
#} 