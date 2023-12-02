variable "public_key_path" {
  description = "Path to public key file"
}

variable "private_key_path" {
  description = "Path to private key file"
}

variable "token" {
  description = "token ID"
}

variable "cloud_id" {
  description = "cloud ID"
}

variable "folder_id" {
  description = "folder ID"
}

variable "image_id" {
  description = "image ID"
}

variable "service_account_id" {
  description = "service_account ID"
}

variable "zones" {
  description = "ru-central1-a, ru-central1-b"
}

variable "nginx" {
  description = "metadata path to nginx install"
}

variable "ip_web1" {
  description = "local web1 ipv4"
}

variable "ip_web2" {
  description = "local web2 ipv4"
}

variable "ip_zabbix" {
  description = "local zabbix ipv4"
}

variable "ip_elasticsearch" {
  description = "local elasticsearch ipv4"
}

variable "ip_kibana" {
  description = "local kibana ipv4"
}

variable "ip_bastion-host" {
  description = "local bastion-host ipv4"
}

variable "subnet-private-a" {
  description = "subnet-private-a"
}

variable "subnet-private-b" {
  description = "subnet-private-b"
}

variable "subnet-public-a" {
  description = "subnet-public-a"
}

variable "subnet-public-b" {
  description = "subnet-public-b"
}

