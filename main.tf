terraform {
  backend "gcs" {
    bucket  = "mp-secret"
    prefix  = "terraform/state"
  }
}

module "github_repository" {
  source                   = "github.com/mykolapryvalov/tf-github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux"
}

module "tls_private_key" {
  source    = "github.com/mykolapryvalov/tf-hashicorp-tls-keys"
  algorithm = "RSA"
}

module "gke_cluster" {
  source         = "github.com/mykolapryvalov/tf-google-gke-cluster"
  GOOGLE_REGION  = var.GOOGLE_REGION
  GOOGLE_PROJECT = var.GOOGLE_PROJECT
  GKE_NUM_NODES  = 2
}

module "flux_bootstrap" {
  source            = "./modules/flux_bootstrap/"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key       = module.tls_private_key.private_key_pem
  config_path       = module.gke_cluster.kubeconfig
}

