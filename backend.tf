terraform {
 backend "s3" {
   bucket = "task-florin"
   key = "test"
   acl    = "log-delivery-write"
   region = "eu-west-1"
 versioning {
    enabled = true
  }

 }

}