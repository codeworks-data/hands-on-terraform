# Top-level folder under an organization.
resource "google_folder" "CodeLabTf" {
  display_name = "CodeLab tf"
  parent       = var.organization
}

# Folder nested under another folder.
resource "google_folder" "DemosTf" {
  display_name = "Demos tf"
  parent       = google_folder.CodeLabTf.name
}

# Folder nested under another folder.
resource "google_folder" "DevOps" {
  display_name = "DEVOPS"
  parent       = google_folder.DemosTf.name
}

# creation and management of a GCP project
resource "google_project" "hands-on-tf" {
  project_id      = var.project
  name            = var.project
  billing_account = var.billing_account
  folder_id       = google_folder.DevOps.name
}

# creation and management of a GCS bucket

resource "google_storage_bucket" "iac-dev" {
  project       = google_project.hands-on-tf.project_id
  name          = "iac-dev-tf"
  location      = var.location
  storage_class = "STANDARD"
  force_destroy = true
}

# creation and management of a GCE VM

resource "google_compute_instance" "default-gce" {
  project      = google_project.hands-on-tf.project_id
  name         = "terraform-vm"
  machine_type = "n1-standard-1"
  zone         = var.region

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}

/*

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
*/
