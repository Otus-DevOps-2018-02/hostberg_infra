output "private_ip" {
  value = "${google_compute_instance.db.network_interface.0.address}"
}
