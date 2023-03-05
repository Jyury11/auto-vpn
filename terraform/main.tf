# -------------------------------------------------------
#                       network
# -------------------------------------------------------

resource "google_compute_firewall" "allow_vpn" {
  name          = "default-allow-vpn"
  network       = "default"
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["vpn"]
  allow {
    protocol = "tcp"
    ports    = ["5555"]
  }

  allow {
    protocol = "udp"
    ports    = ["500"]
  }

  allow {
    protocol = "udp"
    ports    = ["4500"]
  }

  allow {
    protocol = "udp"
    ports    = ["1701"]
  }

  allow {
    protocol = "udp"
    ports    = ["1194"]
  }
}

resource "google_compute_firewall" "allow_ssh" {
  name          = "default-allow-ssh"
  network       = "default"
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

# -------------------------------------------------------
#                       oslogin
# -------------------------------------------------------

data "google_client_openid_userinfo" "me" {}

resource "google_os_login_ssh_public_key" "cache" {
    user = data.google_client_openid_userinfo.me.email
    key = file("../ansible/cloud/.ssh/id_rsa.pub")
    project = var.project
}

resource "google_project_iam_binding" "os-login" {
  project = var.project
  role    = "roles/compute.osAdminLogin"

  members = [
    "user:${var.account}",
  ]
}

# -------------------------------------------------------
#                       compute
# -------------------------------------------------------

resource "google_compute_instance" "vpn_server" {
  project = var.project
  machine_type = "e2-micro"
  name         = var.compute_name
  can_ip_forward = true
  tags = ["https-server", "ssh", "vpn"]
  zone = "us-west1-b"

  boot_disk {
    auto_delete = true
    device_name = var.compute_name
    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20230302"
      size  = 30
      type  = "pd-standard"
    }
    mode   = "READ_WRITE"
  }


  confidential_instance_config {
    enable_confidential_compute = false
  }

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/${var.project}/global/networks/default"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/${var.project}/regions/us-west1/subnetworks/default"
    subnetwork_project = var.project
    access_config {
      // Ephemeral public IP
    }
  }

  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  service_account {
    email  = "${var.project_number}-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = true
    enable_vtpm                 = true
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}
