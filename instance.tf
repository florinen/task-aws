resource "aws_instance" "web" {
    ami = "${lookup(var.amis, var.aws_region)}"
    count = "${var.count}"
    key_name = "${var.key_name}"
    vpc_security_group_ids = "${aws_security_group.web.id}"
    instance_type = "${var.instance_type}"
    associate_public_ip_address = "true" # It will asign a public ip if set true

   tags = {
       environments = "${var.enviroment}${var.count.index +1}"
       created_by = "${var.created_by}"
   }    
 }
  

