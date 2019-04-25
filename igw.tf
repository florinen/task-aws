resource "aws_internet_gateway" "test-IGW" {
    vpc_id = "${aws_vpc.test.id}"
  
}
