output "app_external_ip" {
  value = "${module.app.app_external_ip}"
}

output "db_internal_ip" {
  value = "${module.db.private_ip}"
}
