variable "organization" {
  description = "The ID of the organization in the Top level"
  type        = string
}


variable "billing_account" {
  description = "Billing account id used as default for new projects."
  type        = string
}

variable "project" {
  description = "The ID of the project"
  type        = string
}


variable "location" {
  description = "The location for a GCS bucket to create"
  type        = string
  default     = "EU"
}


variable "region" {
  description = "The GCP region to retrieve a short name for (ex. `us-central1)."
  type        = string
  default     = null
}


variable "image_dir" {
  description = "The directory containing images"
  type        = string
}