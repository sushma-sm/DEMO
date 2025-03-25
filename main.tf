provider "google" {
  project = "devops-practice-sm"
  region  = "us-central1"
}

resource "google_storage_bucket" "terraform_state" {
  name          = "my-terraform-bucket-sm1"
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}
