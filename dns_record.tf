resource "aws_route53_zone" "devopnet" {
  name = "devopnet.com"
}
data "aws_elb_hosted_zone_id" "lb_web_dns" {}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.devopnet.id}"
  name    = "devopnet.com"
  type    = "A"

  alias {
    name                   = "${aws_elb.aws_elb.lb_web_dns}"
    zone_id                = "${data.aws_elb_hosted_zone_id.lb_web_dns.id}"
    evaluate_target_health = true
  }
}
resource "aws_route53_record" "nextcloud" {
  zone_id = "ID:Z2YAJVYQEOF2ZN"
  name    = "nextcloud.devopnet.com"
  type    = "A"

  alias {
    name                   = "${aws_elb.lb_web_dns.dns_name}"
    zone_id                = "${aws_elb.devopnet.zone_id}"
    evaluate_target_health = true
  }
}