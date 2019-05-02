# Web Servers
resource "aws_security_group" "webserver" {
    name = "webserver"
    description = "Allow incoming connections "
    vpc_id   = "${aws_vpc.vpc_test.id}"

     tags = {
    Name = "${var.name}-server"
  }
}

#resource "aws_security_group_rule" "webserver_self" {
 # type = "ingress"
 # from_port = 0
 # to_port = 0
 # protocol = "-1"
 # self = true
 # security_group_id = "${aws_security_group.webserver.id}"
#}
resource "aws_security_group_rule" "webserver_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${var.from_anywhere}"]
  security_group_id = "${aws_security_group.app_server.id}"
}
resource "aws_security_group_rule" "webserver_http" {
  type = "ingress"
  from_port = 3000
  to_port = 3000
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.lb_SG.id}"
  security_group_id = "${aws_security_group.webserver.id}"
}

resource "aws_security_group_rule" "webserver_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["${var.to_anywhere}"]
  security_group_id = "${aws_security_group.webserver.id}"
}







   # ingress = {
    #    from_port    = "3306"
    #    to_port      = "3306"
    #    protocol     = "tcp"
    #    cidr_blocks  = ["${var.vpc-10_cidr_block}"]
    #}
    
    #ingress = {
     #   from_port    = "0"
     #   to_port      = "65535"
     #   protocol     = "-1"
     #   se
    
    #}
    #ingress = {
     #   from_port    = "22"
     #   to_port      = "22"
     #   protocol     = "tcp"
     #   cidr_blocks  = ["${var.from_anywhere}"]
    #}
    
    
    
  
}
# Database Servers
#resource "aws_security_group" "db" {
    #name = "db_sg"
    #description = "Allow incoming db connections"

    #ingress = { # MySQL 
     #   from_port    = "3306"
      #  to_port      = "3306"
       # protocol     = "tcp"
      #  cidr_blocks  = ["${var.from_anywhere}"]
      #  security_groups = ["${aws_security_group.web.id}"] 
    #}
    #egress = {
    #    from_port    = "80"
     #   to_port      = "80"
     #   protocol     = "tcp"
      #  cidr_blocks  = ["${var.to_anywhere}"]
    #}
    #egress = {
     #   from_port    = "80"
     #   to_port      = "80"
     #   protocol     = "tcp"
     #   cidr_blocks  = ["${var.to_anywhere}"]
    #}
    #vpc_id = "${aws_vpc.vpc_test.id}"

    #tags  = {
    #    Name = "DBServersSG"
    #}


#}

resource "aws_security_group" "lb_SG" {
    name = "lb_SG"
    description = "Allow incoming connections on http"
    name_prefix = "${var.name}-alb-"
    vpc_id = "${aws_vpc.vpc_test.id}"
  
  tags = {
    Name = "${var.name}-lb"
  }

}
resource "aws_security_group_rule" "alb_http" {
  type = "ingress"
  from_port   = "80"
  to_port     = "80"
  protocol    = "tcp"
  cidr_blocks = ["${var.from_anywhere}"]
  security_group_id = "${aws_security_group.lb_SG.id}"
}
resource "aws_security_group_rule" "alb_webserver" {
  type = "egress"
  from_port = 3000
  to_port = 3000
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.webserver.id}"
  security_group_id = "${aws_security_group.lb_SG.id}"
}
resource "aws_security_group_rule" "alb_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["${var.to_anywhere}"]
  security_group_id = "${aws_security_group.lb_SG.id}"
}
    
    
    
    
    
    #ingress = {
     #   from_port = "80"
     #   to_port   = "80"
     #   protocol  = "tcp"
     #   cidr_blocks = ["${var.from_anywhere}"]
    #}
    #ingress = {
     #   from_port    = "0"
     #   to_port      = "65535"
     #   protocol     = "-1"
     #   security_groups = ["${aws_security_group.webserver.id}"]
    #}
    
    #tags = {
     #   Name = "lb-SG"
    #}
  
}

