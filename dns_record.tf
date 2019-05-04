
## Adding ALB dns name as an Alias record in Route53
resource "aws_route53_zone" "devopnet" {
  
  name = "${var.parent_zone_name}"
  
}
data "aws_elb_hosted_zone_id" "current" {}

resource "aws_route53_record" "nextcloud" {
  zone_id = "${aws_route53_zone.devopnet.zone_id}"
  name    = "nextcloud.${var.parent_zone_name}"
  type    = "A"
  #ttl     = "300"
  #records = ["10.0.0.1"]
  alias {
      name = "${aws_lb.lb_web.dns_name}"
      zone_id = "${data.aws_elb_hosted_zone_id.current.id}"
      evaluate_target_health = false
      
  }
}
resource "aws_route53_record" "test" {
  zone_id = "Z2YAJVYQEOF2ZN"
  name = "nextcloud"
  type = "A"
  ttl = "300"
  records = ["${}"]
  
}  
  #alias {
    #  name = "${aws_lb.lb_web.dns_name}"
   #   zone_id = "${aws_route53_zone.devopnet.id}"
  #    evaluate_target_health = true
 # }
#}
