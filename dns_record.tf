resource "aws_route53_zone" "devopnet" {
  name = "${var.parent_zone_name}"
  zone_id = "${var.parent_zone_id}"
}

resource "aws_route53_record" "nextcloud" {
  zone_id = "${aws_route53_zone.devopnet.id}"
  name    = "devopnet.com"
  type    = "A"

  alias {
    name                   = "${aws_lb.lb_web.lb_web_dns.name}"
    zone_id                = "${var.parent_zone_id}"
    evaluate_target_health = true
  }
}











#data "aws_elb_hosted_zone_id" "lb_web_dns" {}


#resource "aws_route53_record" "nextcloud" {
 # zone_id = "IDZ2YAJVYQEOF2ZN"
 # name    = "nextcloud.devopnet.com"
 # type    = "A"

 # alias {
  #  name                   = "${aws_elb.lb_web.lb_web_dns}"
  #  zone_id                = "${aws_elb.devopnet.zone_id}"
  #  evaluate_target_health = true
  #}
#}