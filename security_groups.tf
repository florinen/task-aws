# Web Servers
resource "aws_security_group" "web" {
    name = "aws_vpc"
    description = "Allow incoming HTTP connections "

    ingress = {
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["${var.from_anywhere}"]
    }
    ingress = {
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
        cidr_blocks = ["${var.from_anywhere}"]
    }
    egress = {
        from_port = "1433"
        to_port   = "1433"
        protocol  = "tcp"
        cidr_blocks = ["${var.priv_1_subnet_cidr}"]
    }
    egress = {
        from_port = "3306"
        to_port   = "3306"
        protocol  = "tcp"
        cidr_blocks = ["${var.priv_1_subnet_cidr}"]
    }
    vpc_id = "${aws_vpc.vpc_test.id}"

    tags {
        name = "WebServerSG"
    }
  
}
