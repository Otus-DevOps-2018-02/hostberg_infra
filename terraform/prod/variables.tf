variable project {
  description = "Project ID"
}

variable region {
  description = "Region for the project"
  default     = "europe-west4"
}

variable zone {
  description = "Zone for the project"
  default     = "europe-west4-a"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
  default     = "~/.ssh/appuser.pub"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
  default     = "~/.ssh/appuser"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable app_deploy {
  description = "Reddit app deploy"
  default     = true
}
