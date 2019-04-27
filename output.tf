output "ip" {
  value = ["${aws_eip.test_eip.*.public_ip}"]
}
output "lb_dns_name" {
  value = "${aws_lb.lb_web.dns_name}"
}

