terraform {
 backend "s3" {
  key = "test"
  acl    = "log-delivery-write"
  region = "eu-west-1"
 versioning {
    enabled = true
  }
 logging {
    target_bucket = "task-florin"
    target_prefix = "log/"
  }
 
 }
}


  



