terraform {
  backend "gcs" {
    bucket = "hostberg-terraform-backend"
    prefix = "terraform/prod"
  }
}
