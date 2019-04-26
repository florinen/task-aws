resource "aws_launch_configuration" "web_launch-config" {
    name = "web_launch_config"
    image_id = "${var.amis}"
    instance_type = "${var.instance_type}"
    associate_public_ip_address = true
}

# This will create the autoscaling group
resource "aws_autoscaling_group" "web_asg" {
  name = "web_asg"
  launch_configuration = "${aws_launch_configuration.web_launch-config.name}"
  min_size = "2"
  max_size = "4"
  availability_zones = ["eu-west-1a"]
  vpc_zone_identifier = ["${aws_subnet.priv_1_subnet_eu_west_1a.id}"]#, "${aws_subnet.dev2.id}"]
  
}