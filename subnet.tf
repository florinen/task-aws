resource "aws_subnet" "test_1" {
    vpc_id = "${aws_vpc.test.id}"
    cidr_block = "192.168.1.0/24"

    tags = {
        Name = "test_1"    
    }
  
}
