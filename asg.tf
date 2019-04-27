resource "aws_launch_configuration" "web_launch-config" {
    name = "web_launch_config"
    image_id = "${var.amis}"
    instance_type = "${var.instance_type}"
    associate_public_ip_address = true
    security_groups = ["${aws_security_group.web.id}"]
    lifecycle {
      create_before_destroy = true
    }
}

# This will create the autoscaling group
resource "aws_autoscaling_group" "web_asg" {
  name = "web_asg"
  launch_configuration = "${aws_launch_configuration.web_launch-config.name}"
  min_size = "2"
  max_size = "4"
  availability_zones = ["eu-west-1a","eu-west-1b"]
  vpc_zone_identifier = ["${aws_subnet.pub_1_subnet_eu_west_1a.id}","${aws_subnet.pub_2_subnet_eu_west_1b.id}"]
  
}
# this will create ELB
resource "aws_lb" "lb_web" {
  name  = "lb_web"
  internal = false
  load_balancer_type = "aplication" 
  security_groups = "${aws_security_group.lb_SG}"
  subnets = ["${var.pub_1_subnet_cidr}","${var.pub_2_subnet_cidr}"]
  access_logs {
    bucket   = "task-florin"
    interval = "60"
    enabled  = true 
  }
  tags = {
    Environment = "test"
  }
  listener {
    instance_port     = "80"
    instance_protocol  = "http"
    lb_port            = "80"
    lb_protocol        = "http"
  }
  health_check {
    healthy_threshold    = "3"
    unhealthy_threshold  = "3"
    timeout              = "4"
    target               = "http:80/"
    interval             = "10"
  }
  instances  = ["${aws_launch_configuration.web_launch-config.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = "400"
  connection_draining         = true
  connection_draining_timeout = "400"
  tags = {
    name = "elb_web"
  }
  
}
