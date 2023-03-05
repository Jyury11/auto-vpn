terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.22.0"
    }
  }

  backend "gcs" {
    bucket  = "develop-360015-terraform-state"
  }
}

