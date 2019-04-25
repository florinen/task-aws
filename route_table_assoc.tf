# Associate subnet pub_2_subnet_eu_west_1a to public route table
resource "aws_route_tale_association" "pub_1_subnet_eu_west_1a_assoc" {
    subnet_id = "${aws_subnet.pub_1_subnet_eu_west_1a.id}"
    route_table_id = "${aws_vpc.vpc_test.main_route_table_id}"
  
}
# Associate subnet priv_1_subnet_eu_west_1a to private route table
resource "aws_route_table_association" "priv_1_subnet_eu_west_1a_assoc" {
    subnet_id = "${aws_subnet.priv_1_subnet_eu_west_1a.id}"
    route_table_id = "${aws_route_table.priv_route_table.id}"
  
}
