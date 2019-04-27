terraform {
 backend "s3" {
   bucket = "task-florin"
   key = "test"
   acl    = "log-delivery-write"
   region = "eu-west-1"
 
  }
resource "aws_s3_bucket" "versioning_bucket" {
  bucket = "task-florin"
  acl    = "private"

  versioning {
    enabled = true
  }
 
 }

}