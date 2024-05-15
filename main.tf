module "gke_cluster" {
  source         = "git::https://github.com/mykolapryvalov/tf-google-gke-cluster"
  GOOGLE_REGION  = var.GOOGLE_REGION
  GOOGLE_PROJECT = var.GOOGLE_PROJECT
  GKE_NUM_NODES  = 2
}

terraform {
  backend "gcs" {
    bucket = "my-secret"
    prefix = "terraform/state"
  }
}