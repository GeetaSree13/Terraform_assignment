terraform {
  backend "s3" {
    bucket  = "bucket-from-terraform-sa"
    profile = "default"
  }
}

resource "google_compute_instance" "vm_instance" {
    name ="terraform-practice"
    machine_type = "e2-medium"
    zone = "asia-southeast1-a"

boot_disk {
  initialize_params {
    image = "projects/rocky-linux-cloud/global/images/family/rocky-linux-9"
    size = 20
  }
}

network_interface {
  network = "default"
  access_config {
  }
}
tags = ["http-server", "https-server"]

}

resource "google_compute_firewall" "allow-http" {
    name    = "allow-http"
    network = "default"

    allow {
        protocol = "tcp"
        ports    = ["80"]
    }
    direction     = "INGRESS"
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["http-server"]

}

resource "google_compute_firewall" "allow-https" {
    name = "allow-https"
    network = "default"

    allow {
      protocol = "udp"
      ports = ["443"]
    }
  
    direction     = "INGRESS"
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["https-server"]

}