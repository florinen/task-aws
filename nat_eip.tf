resource "aws_eip" "nat-eip" {
    subnet_id = "${var.public_subnet_cidr.id}"
    depends_on = ["aws_internet_gateway.test-IGW"]
    tags = {
        Name = "nat-eip"
    }
  
}
