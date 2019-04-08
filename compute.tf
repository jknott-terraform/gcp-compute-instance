# Create a new instance
resource "google_compute_instance" "ubuntu-xenial" {
   name = "ubuntu-xenial"
   machine_type = "f1-micro"
   zone = "us-central1-a"
   boot_disk {
      initialize_params {
      image = "ubuntu-1604-lts"
   }
}
network_interface {
   subnetwork = "development-subnet" # To drop the instance in a specific subnet
   # network = "default" - Default VPC
   access_config {}
}
service_account {
   scopes = ["userinfo-email", "compute-ro", "storage-ro"]
   }
}
