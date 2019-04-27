output "ip" {
  value = ["${aws_eip.*.public_ip}"]
}
output "elb_dns_name" {
  value = "${aws_elb.elb_web.dns_name}"
}

