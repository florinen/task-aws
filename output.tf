output "ip" {
  value = ["${aws_eip.test_eip.*.public_ip}"]
}
output "lb_dns_name" {
  value = "${aws_lb.lb_web.dns_name}"
}

output "VPC" {
  value = "${aws_vpc.vpc_test.id}"
}
output "SUBNET" {
  value = "${aws_subnet.priv_1_subnet_eu_west_1a.id}"
}
