provider "google" {
  project     = "devops-practice-sm"
  region      = "us-central1"
}

resource "google_storage_bucket" "my_bucket" {
  name     = "my-terraform-bucket-abc"
  location = "US"
}
