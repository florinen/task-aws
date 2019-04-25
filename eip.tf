resource "aws_eip" "test_eip" {
    vpc = "true"
    depends_on = ["${aws_internet_gateway.igw}"]

    tags = {
        Name = "test_eip"
    }
  
}
