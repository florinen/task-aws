resource "aws_launch_configuration" "l-config" {
    name = "lc-web"
    image_id = "${var.amis}"
    instance_type = "${var.instance_type}"
    associate_public_ip_address = true
    security_groups = ["${aws_security_group.webserver.id}"]
    key_name = "Laptop"
    lifecycle {
      create_before_destroy = true
    }
    
    

}