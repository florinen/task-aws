
output "VPC" {
  description = "VPC created"
  value = "${aws_vpc.vpc_test.id}"
}
output "SUBNET_10" {
  description = "Private subnet 10"
  value = "${aws_subnet.priv_1_subnet_eu_west_1a.id}"
}
output "SUBNET_11" {
  description = "Private subnet 11"
  value = "${aws_subnet.priv_2_subnet_eu_west_1b.id}"
}
output "SUBNET_1" {
  description = "Public subnet 1"
  value = "${aws_subnet.pub_1_subnet_eu_west_1a.id}"
}
output "SUBNET_2" {
  description = "Public subnet 2"
  value = "${aws_subnet.pub_2_subnet_eu_west_1b.id}"
}
output "lb_dns_name" {
  description = "ALB DNS record"
  value = "${aws_lb.lb_web.dns_name}"
}