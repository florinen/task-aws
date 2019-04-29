# this will create ELB
resource "aws_lb" "lb_web" {
  name  = "lb-web"
  internal = false
  load_balancer_type = "application" 
  security_groups = ["${aws_security_group.lb_SG.id}"]
  subnets = ["${aws_subnet.pub_1_subnet_eu_west_1a.id}","${aws_subnet.pub_2_subnet_eu_west_1b.id}"]
  
  tags = {
    Environment = "test"
   }
   access_logs {    
    bucket = "${var.s3_bucket}"    
    prefix = "ELB-logs"  
  }
 
 }
 resource "aws_lb_target_group" "web_tg" {
  name     = "web-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.vpc_test.id}"
  
  tags {
    name = "web_tg"
  }

health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 10    
    timeout             = 5    
    interval            = 10    
    path                = "/"    
    port                = "80"  
  }
 }

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.lb_web.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.web_tg.arn}"
  }
}
resource "aws_lb_listener_rule" "listener_rule" {
 # depends_on   = ["${aws_lb_target_group.web_tg.arn}"]  
  listener_arn = "${aws_lb_listener.front_end.arn}"  
  priority     = "${var.priority}"   
  action {    
    type             = "forward"    
    target_group_arn = "${aws_lb_target_group.web_tg.id}"  
  }   
  condition {    
    field  = "path-pattern"    
    values = ["/"]  
  }
}
 resource "aws_autoscaling_attachment" "alb_autoscale" {
  alb_target_group_arn   = "${aws_lb_target_group.web_tg.arn}"
  autoscaling_group_name = "${aws_autoscaling_group.web_asg.id}"
}