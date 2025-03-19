provider "google" {
  project = "devops-practice-sm"
  region  = "us-central1"
}
terraform {
  backend "gcs" {
    bucket = "my-terraform-bucket-c22600d02c44fc"
    prefix = "terraform/state"
  }
}
