terraform {
 backend "s3" {
   bucket = "task-florin"
   key = "test"
   region = "us-east-1"
 }
}