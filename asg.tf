
# This will create the autoscaling group
resource "aws_autoscaling_group" "web_asg" {
  name                      = "web_asg_test"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.l-config.name}"
  vpc_zone_identifier       = ["${aws_subnet.pub_1_subnet_eu_west_1a.id}", "${aws_subnet.pub_2_subnet_eu_west_1b.id}"]

  tag {
    key = "Name"
    value = "ec2-web"
    propagate_at_launch = true
  }
}
 
# scale up alarm
resource "aws_autoscaling_policy" "cpu_policy_up" {
  name = "cpu-policy_up"
  autoscaling_group_name = "${aws_autoscaling_group.web_asg.name}"
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "cpu-alarm" {
  alarm_name = "cpu-alarm"
  alarm_description = "cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "50" # % cpu utilization
  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.web_asg.name}"
 }
  actions_enabled = true
  alarm_actions = ["${aws_autoscaling_policy.cpu_policy_up.arn}"]
}
# scale down alarm
resource "aws_autoscaling_policy" "cpu-policy-scaledown" {
  name = "cpu-policy-scaledown"
  autoscaling_group_name = "${aws_autoscaling_group.web_asg.name}"
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "-1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "cpu-alarm-scaledown" {
  alarm_name = "cpu-alarm-scaledown"
  alarm_description = "cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "25" # % cpu utilization
  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.web_asg.name}"
 }
  actions_enabled = true
  alarm_actions = ["${aws_autoscaling_policy.cpu-policy-scaledown.arn}"]
}
  

