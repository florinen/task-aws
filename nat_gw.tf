resource "aws_nat_gateway" "nat" {
  depends_on = ["aws_internet_gateway.igw"]
  allocation_id = "${aws_eip.test_eip.id}"
  subnet_id     = "${aws_subnet.pub_1_subnet_eu_west_1a.id}"

  tags = {
    Name = "NAT-gw"
  }
}