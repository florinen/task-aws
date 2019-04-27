terraform {
 backend "s3" {
   bucket = "task-florin"
   key = "test"
   region = "eu-west-1"
 }
}