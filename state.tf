terraform {
  backend "s3" {
    bucket = "rtdevopspract"
    key    = "roboshop/state"
    region = "us-east-1"
  }
}