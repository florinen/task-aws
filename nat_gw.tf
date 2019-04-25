resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.test_2.id}"

  tags = {
    Name = "gw NAT"
  }
}