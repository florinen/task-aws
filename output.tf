output "ip" {
  value = ["${aws_eip.ip.public_ip}"]
}
output "elb_dns_name" {
  value = "${aws_elb.elb_web.dns_name}"
}

