#terraform
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

#provider
provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}

#network
resource "yandex_vpc_network" "vpc" {
  name = "vpc"
}

#subnets
resource "yandex_vpc_subnet" "subnet-private-a" {
  name           = "subnet-private-a"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["192.168.1.0/24"]
  network_id     = yandex_vpc_network.vpc.id
}

resource "yandex_vpc_subnet" "subnet-private-b" {
  name           = "subnet-private-b"
  zone           = "ru-central1-b"
  v4_cidr_blocks = ["192.168.2.0/24"]
  network_id     = yandex_vpc_network.vpc.id
}

resource "yandex_vpc_subnet" "subnet-public-a" {
  name           = "subnet-public-a"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["192.168.3.0/24"]
  network_id     = yandex_vpc_network.vpc.id
}

resource "yandex_vpc_subnet" "subnet-public-b" {
  name           = "subnet-public-b"
  zone           = "ru-central1-b"
  v4_cidr_blocks = ["192.168.4.0/24"]
  network_id     = yandex_vpc_network.vpc.id
}

#web1
resource "yandex_compute_instance" "web1" {
  name                      = "web1"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = var.image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-private-a.id
    nat        = true
    ipv4       = true
    ip_address = "192.168.1.10"
    security_group_ids = [
      yandex_vpc_security_group.bastion-host-internal-sg.id,
      yandex_vpc_security_group.webs-sg.id
    ]
  }

  metadata = {
    ssh-keys  = "ubuntu:${file(var.public_key_path)}"
    user-data = "${file(var.nginx)}"
  }

  scheduling_policy {
    preemptible = false
  }
}

#web2
resource "yandex_compute_instance" "web2" {
  name                      = "web2"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-b"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = var.image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-private-b.id
    nat        = true
    ipv4       = true
    ip_address = "192.168.2.10"
    security_group_ids = [
      yandex_vpc_security_group.bastion-host-internal-sg.id,
      yandex_vpc_security_group.webs-sg.id
    ]
  }

  metadata = {
    ssh-keys  = "ubuntu:${file(var.public_key_path)}"
    user-data = "${file(var.nginx)}"
  }

  scheduling_policy {
    preemptible = false
  }
}

#zabbix
resource "yandex_compute_instance" "zabbix" {
  name                      = "zabbix"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = var.image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-public-a.id
    nat        = true
    ipv4       = true
    ip_address = "192.168.3.10"
    security_group_ids = [
      yandex_vpc_security_group.bastion-host-internal-sg.id,
      yandex_vpc_security_group.zabbix-sg.id
    ]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  scheduling_policy {
    preemptible = false
  }
}

#elasticsearch
resource "yandex_compute_instance" "elasticsearch" {
  name                      = "elasticsearch"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-b"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = var.image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-private-b.id
    nat        = true
    ipv4       = true
    ip_address = "192.168.2.20"
    security_group_ids = [
      yandex_vpc_security_group.bastion-host-internal-sg.id,
      yandex_vpc_security_group.elasticsearch-sg.id
    ]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  scheduling_policy {
    preemptible = false
  }
}

#kibana
resource "yandex_compute_instance" "kibana" {
  name                      = "kibana"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-b"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = var.image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-public-b.id
    nat        = true
    ipv4       = true
    ip_address = "192.168.4.10"
    security_group_ids = [
      yandex_vpc_security_group.bastion-host-internal-sg.id,
      yandex_vpc_security_group.kibana-sg.id
    ]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  scheduling_policy {
    preemptible = false
  }
}

#bastion-host
resource "yandex_compute_instance" "bastion-host" {
  name                      = "bastion-host"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = var.image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-public-a.id
    nat        = true
    ipv4       = true
    ip_address = "192.168.3.30"
    security_group_ids = [
      yandex_vpc_security_group.bastion-host-internal-sg.id,
      yandex_vpc_security_group.bastion-host-external-sg.id
    ]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  scheduling_policy {
    preemptible = false
  }
}

#target-group
resource "yandex_alb_target_group" "target-group" {
  name = "target-group"

  target {
    subnet_id  = yandex_vpc_subnet.subnet-private-a.id
    ip_address = yandex_compute_instance.web1.network_interface.0.ip_address
  }

  target {
    subnet_id  = yandex_vpc_subnet.subnet-private-b.id
    ip_address = yandex_compute_instance.web2.network_interface.0.ip_address
  }
}

#backend_group
resource "yandex_alb_backend_group" "backend-group" {
  name = "backend-group"

  http_backend {
    name             = "http-backend"
    weight           = 1
    port             = 80
    target_group_ids = ["${yandex_alb_target_group.target-group.id}"]
    load_balancing_config {
      panic_threshold = 90
    }
    healthcheck {
      timeout             = "10s"
      interval            = "2s"
      healthy_threshold   = 10
      unhealthy_threshold = 15
      http_healthcheck {
        path = "/"
      }
    }
  }
}

#http_router
resource "yandex_alb_http_router" "http-router" {
  name = "http-router"
  labels = {
    tf-label    = "tf-label-value"
    empty-label = ""
  }
}

resource "yandex_alb_virtual_host" "virtual-host" {
  name           = "virtual-host"
  http_router_id = yandex_alb_http_router.http-router.id
  route {
    name = "route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.backend-group.id
        timeout          = "60s"
      }
    }
  }
}

#balancer
resource "yandex_alb_load_balancer" "balancer" {
  name = "balancer"

  network_id = yandex_vpc_network.vpc.id

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.subnet-public-a.id
    }
  }

  listener {
    name = "alb"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.http-router.id
      }
    }
  }

  log_options {
    discard_rule {
      http_code_intervals = ["HTTP_2XX"]
      discard_percent     = 75
    }
  }
}

resource "yandex_compute_snapshot" "web1" {
  name           = "web1-snapshot"
  source_disk_id = yandex_compute_instance.web1.boot_disk[0].disk_id
}

resource "yandex_compute_snapshot" "web2" {
  name           = "web2-snapshot"
  source_disk_id = yandex_compute_instance.web2.boot_disk[0].disk_id
}

resource "yandex_compute_snapshot" "zabbix" {
  name           = "zabbix-snapshot"
  source_disk_id = yandex_compute_instance.zabbix.boot_disk[0].disk_id
}

resource "yandex_compute_snapshot" "elasticsearch" {
  name           = "elasticsearch-snapshot"
  source_disk_id = yandex_compute_instance.elasticsearch.boot_disk[0].disk_id
}

resource "yandex_compute_snapshot" "kibana" {
  name           = "kibana-snapshot"
  source_disk_id = yandex_compute_instance.kibana.boot_disk[0].disk_id
}

resource "yandex_compute_snapshot" "bastion-host" {
  name           = "bastion-host-snapshot"
  source_disk_id = yandex_compute_instance.bastion-host.boot_disk[0].disk_id
}


resource "yandex_compute_snapshot_schedule" "schedule" {
  name = "schedule"

  schedule_policy {
    expression = "30 5 * * *"
  }

  snapshot_count = 1

  retention_period = "168h"

  snapshot_spec {
    description = "for all VMs"
  }

  disk_ids = ["${yandex_compute_instance.web1.boot_disk[0].disk_id}", "${yandex_compute_instance.web2.boot_disk[0].disk_id}", "${yandex_compute_instance.zabbix.boot_disk[0].disk_id}", "${yandex_compute_instance.elasticsearch.boot_disk[0].disk_id}", "${yandex_compute_instance.kibana.boot_disk[0].disk_id}", "${yandex_compute_instance.bastion-host.boot_disk[0].disk_id}"]
}

