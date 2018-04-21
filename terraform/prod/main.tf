provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source           = "../modules/app"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone             = "${var.zone}"
  app_disk_image   = "${var.app_disk_image}"
  app_deploy       = "${var.app_deploy}"
  mongodb_ip       = "${module.db.private_ip}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "terraform-shell-resource" {
  source  = "github.com/matti/terraform-shell-resource"
  command = "curl https://ipinfo.io/ip 2>/dev/null | tr -d '\n'"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["${module.terraform-shell-resource.stdout}/32"]
}
