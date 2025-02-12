provider "google" {
  project = "devops-practice-sm"
  region  = "us-central1"
}

# Generate a random ID to append to the bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "google_storage_bucket" "my_bucket" {
  name     = "my-terraform-bucket-${random_id.bucket_suffix.hex}"
  location = "US"
}
