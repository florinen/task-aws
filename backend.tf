#terraform {
 #backend "s3" {
  ##key = "test"
   #acl    = "log-delivery-write"
  # region = "eu-west-1"
 
  #}
resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-lb-web-log-bucket"
  acl    = "log-delivery-write"
  region = "eu-west-1"

 }

resource "aws_s3_bucket" "tf_bucker" {
  bucket = "my-tf-test-bucket"
  acl    = "private"
  region = "eu-west-1"
  
  logging {
    target_bucket = "${aws_s3_bucket.log_bucket.id}"
    target_prefix = "log/"
  }

  }

}