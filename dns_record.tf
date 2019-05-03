resource "aws_route53_zone" "devopnet" {
  name = "${var.parent_zone_name}"
  
}

#resource "aws_route53_record" "nextcloud" {
 # zone_id = "${aws_route53_zone.devopnet.id}"
 # name    = "devopnet.com"
  #type    = "A"

  #alias {
  #  name                   = "${aws_elb.lb_web_dns.name}"
  #  zone_id                = "${data.aws_route53_zone.devopnet.id}"
  #  evaluate_target_health = true
 # }
#}


resource "aws_route53_record" "my-elb-alias" {
  zone_id = "${aws_route53_zone.devopnet.id}"
  name = "nextcloud"
  type = "A"
  ttl = "300"
  records = ["${aws_lb.lb_web_dns.name}"]
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