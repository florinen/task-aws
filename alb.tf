# this will create ELB
resource "aws_lb" "lb_web" {
  name  = "lb-web"
  internal = false
  load_balancer_type = "application" 
  security_groups = ["${aws_security_group.lb_SG.id}"]
  subnets = ["${aws_subnet.pub_1_subnet_eu_west_1a.id}","${aws_subnet.pub_2_subnet_eu_west_1b.id}"]
  #access_logs {
   # bucket   = "task-florin"
   # enabled  = true 
  #}
  tags = {
    Environment = "test"
   }
 
 }
 resource "aws_lb_target_group" "web_target" {
  name     = "tf-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.vpc_test.id}"
}
