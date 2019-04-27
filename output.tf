output "instance_id" {
  value = ["${aws_launch_configuration.web_launch-config.*.ip}"]
}
output "elb_dns_name" {
  value = "${aws_elb.elb_web.elb_dns_name}"
}

