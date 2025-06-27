resource "google_compute_instance" "vm_instance" {
    name ="terraform-instance"
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

resource "google_compute_firewall" "allowing-http" {
    name    = "allowing-http"
    network = "default"

    allow {
        protocol = "tcp"
        ports    = ["80"]
    }
    direction     = "INGRESS"
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["http-server"]

}

resource "google_compute_firewall" "allowing-https" {
    name = "allowing-https"
    network = "default"

    allow {
      protocol = "tcp"
      ports = ["443"]
    }

    direction     = "INGRESS"
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["https-server"]

}