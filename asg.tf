
# This will create the autoscaling group
resource "aws_autoscaling_group" "web_asg" {
  name = "web_asg"
  launch_configuration = "${aws_launch_configuration.l-config.id}"
  load_balancers = ["${aws_lb.lb_web.id}"]
  min_size = "2"
  max_size = "4"
  vpc_zone_identifier = ["${aws_subnet.pub_1_subnet_eu_west_1a.id}","${aws_subnet.pub_2_subnet_eu_west_1b.id}"]

  #availability_zones = ["eu-west-1a","eu-west-1b"]
  
  tag {
    key = "Name"
    value = "autoscale"
    propagate_at_launch = true
  }
  
  
}



  

