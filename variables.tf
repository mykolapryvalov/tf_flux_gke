variable "GOOGLE_PROJECT" {
  type        = string
  default     = ""
  description = "GCP project to use"
}

variable "GOOGLE_REGION" {
  description = "The Google Cloud region to deploy resources"
  type        = string
  # You can optionally set a default value here
  # default     = "us-central1"
}