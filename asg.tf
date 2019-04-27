resource "aws_launch_configuration" "web_launch-config" {
    name = "web_launch_config"
    image_id = "${var.amis}"
    instance_type = "${var.instance_type}"
    associate_public_ip_address = true
    security_groups = ["${aws_security_group.web.id}"]
    lifecycle {
      create_before_destroy = true
    }
    name = "${format("web-", count.index +1)}" 
    
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
  name  = "lb-web"
  internal = false
  load_balancer_type = "application" 
  security_groups = ["${aws_security_group.lb_SG.id}"]
  subnets = ["${aws_subnet.pub_1_subnet_eu_west_1a.id}","${aws_subnet.pub_2_subnet_eu_west_1b.id}"]
  access_logs {
    bucket   = "task-florin"
    enabled  = true 
  }
  tags = {
    Environment = "test"
   }
 
 }
  

