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
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable count {
  description = "Number of instances"
  default     = "1"
}
