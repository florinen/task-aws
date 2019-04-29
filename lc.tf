resource "aws_launch_configuration" "l-config" {
    name = "web_launch_config"
    image_id = "${var.amis}"
    instance_type = "${var.instance_type}"
    associate_public_ip_address = true
    security_groups = ["${aws_security_group.web.id}"]
    key_name = "Laptop"
    lifecycle {
      create_before_destroy = true
    }
   # name = "${format("web",count.index +1)}" 
    
}