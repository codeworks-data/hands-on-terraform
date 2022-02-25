# Top-level folder under an organization.
resource "google_folder" "DevOps" {
  display_name = "DevOps"
  parent       = var.organization
}

# Folder nested under another folder.
resource "google_folder" "Labs" {
  display_name = "Labs"
  parent       = google_folder.DevOps.name
}

# creation and management of a GCP project
resource "google_project" "hands-on-tf2" {
  project_id      = var.project
  name            = var.project
  billing_account = var.billing_account
  folder_id       = google_folder.Labs.name
}

# creation and management of a GCS bucket

resource "google_storage_bucket" "iac-dev" {
  project       = google_project.hands-on-tf.project_id
  name          = "iac-dev-tf"
  location      = var.location
  storage_class = "STANDARD"
 force_destroy = true
}


resource "google_storage_bucket" "iac-prod" {
  project       = google_project.hands-on-tf.project_id
  name          = "iac-prod-tf"
  location      = "${var.location}"
  force_destroy = true
}


resource "google_storage_bucket_object" "picture" {
  source   = "${var.image_dir}/horse.jpg"
  name     = "horse01"
  bucket   = resource.google_storage_bucket.iac-dev.name
}