output "instance_id" {
  value = ["${aws_instance.*.ip}"]
}
output "elb_dns_name" {
  value = "${aws_elb.elb_web.dns_name}"
}

