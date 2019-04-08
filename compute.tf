# Create a new instance
resource "google_compute_instance" "ubuntu-xenial" {
   name = "ubuntu-xenial"
   machine_type = "f1-micro"
   zone = "us-central1-a"
     tags = [
    "${var.subnet}-firewall-ssh",
    "${var.subnet}-firewall-http",
    "${var.subnet}-firewall-https",
    "${var.subnet}-firewall-icmp",
  ]
  metadata {
        startup-script = <<SCRIPT
        apt-get -y update
        apt-get -y upgrade
        export HOSTNAME=$(hostname | tr -d '\n')
        export PRIVATE_IP=$(curl -sf -H 'Metadata-Flavor:Google' http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip | tr -d '\n')
        echo $HOSTNAME
        echo $PRIVATE_IP
        SCRIPT
    }
   boot_disk {
      initialize_params {
      image = "ubuntu-1604-lts"
   }





}
network_interface {
   subnetwork = "development-subnet"
   # network = "default"
   access_config {}
}
service_account {
   scopes = ["userinfo-email", "compute-ro", "storage-ro"]
   }
}
