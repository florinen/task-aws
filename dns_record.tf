#resource "aws_route53_zone" "devopnet" {
#  name = "${var.parent_zone_name}"
  
#}

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
data "aws_route53_zone" "devopnet" {
  name         = "devopnet.com."
  private_zone = false
  vpc_id = "${aws_vpc.vpc_test.id}"
}
data "aws_elb_hosted_zone_id" "current" {}

resource "aws_route53_record" "nextcloud" {
  zone_id = "${data.aws_route53_zone.devopnet.zone_id}"
  name    = "nextcloud"
  type    = "A"
  #ttl     = "300"
  #records = ["10.0.0.1"]
  alias {
      name = "${data.aws_elb_hosted_zone_id.current.id}"
      zone_id = "${data.aws_route53_zone.devopnet.zone_id}"
      evaluate_target_health = true
      
  }
}

#resource "aws_elb_hosted_zone_id" "lb_web" { ... }

# pull in the dns zone
#data "aws_route53_zone" "devopnet_dns" {
 # name         = "devopnet.com."
#}
# create dns record of type "A"
#resource "aws_route53_record" "nextcloud" {
 # zone_id = "${data.aws_route53_zone.devopnet_dns.zone_id}"
 # name    = "${data.aws_route53_zone.devopnet_dns.name}"
 # type    = "A"
# create alias (required: name, zone_id)
#alias {
 #  name = "${aws_elb_hosted_zone_id.lb_web.domain_name}"
 #  zone_id = "${aws_elb_hosted_zone_id.lb_web.hosted_zone_id}"
 # }
#}









#resource "aws_route53_record" "nextcloud" {
  #zone_id = "Z2YAJVYQEOF2ZN"
  #name = "nextcloud"
  #type = "A"
  #ttl = "300"
  #records = ["${aws_lb.lb_web_dns.name}"]
  #alias {
    #  name = "${aws_lb.lb_web.dns_name}"
   #   zone_id = "${aws_route53_zone.devopnet.id}"
  #    evaluate_target_health = true
 # }
#}








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