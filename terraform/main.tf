provider "google" {
  credentials = file("/home/gurajasushmamounika/DEMO/terraform/devops-practice-sm-42887ecbb300.json")
  project     = "devops-practice-sm"
  region      = "us-central1"
}

resource "google_storage_bucket" "my_bucket" {
  name     = "my-terraform-bucket-sp"
  location = "US"
}
