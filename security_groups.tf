# Web Servers
resource "aws_security_group" "web" {
    name = "vpc-webserver"
    description = "Allow incoming connections "

    ingress = {
        from_port    = "80"
        to_port      = "80"
        protocol     = "tcp"
        cidr_blocks  = ["${var.from_anywhere}"]
    }
    
    #ingress = {
     #   from_port    = "443"
     #   to_port      = "443"
     #   protocol     = "tcp"
     #   cidr_blocks  = ["${var.from_anywhere}"]
    
    #}
    ingress = {
        from_port    = "22"
        to_port      = "22"
        protocol     = "tcp"
        cidr_blocks  = ["${var.from_anywhere}"]
    }
    
    egress = { # MySQL
        from_port    = "3306"
        to_port      = "3306"
        protocol     = "tcp"
        cidr_blocks  = ["${var.priv_1_subnet_cidr}","${var.priv_2_subnet_cidr}"]
    }
    vpc_id   = "${aws_vpc.vpc_test.id}"

    tags {
        Name = "WebServerSG"
    }
  
}
# Database Servers
resource "aws_security_group" "db" {
    name = "db_sg"
    description = "Allow incoming db connections"

    ingress = { # MySQL 
        from_port    = "3306"
        to_port      = "3306"
        protocol     = "tcp"
        cidr_blocks  = ["${var.from_anywhere}"]
        #security_groups = ["${aws_security_group.web.id}"] 
    }
    egress = {
        from_port    = "80"
        to_port      = "80"
        protocol     = "tcp"
        cidr_blocks  = ["${var.to_anywhere}"]
    }
    egress = {
        from_port    = "80"
        to_port      = "80"
        protocol     = "tcp"
        cidr_blocks  = ["${var.to_anywhere}"]
    }
    vpc_id = "${aws_vpc.vpc_test.id}"

    tags  = {
        Name = "DBServersSG"
    }


}
resource "aws_security_group" "lb_SG" {
    name = "lb_SG"
    description = "Allow incoming connections on http"
    ingress = {
        from_port = "80"
        to_port   = "80"
        protocol  = "tcp"
        cidr_blocks = ["${var.from_anywhere}"]
    }
    ingress = {
        from_port    = "22"
        to_port      = "22"
        protocol     = "tcp"
        cidr_blocks  = ["${var.from_anywhere}"]
    }
    vpc_id = "${aws_vpc.vpc_test.id}"
    tags = {
        Name = "lb-SG"
    }
  
}

