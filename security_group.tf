#zabbix
resource "yandex_vpc_security_group" "zabbix-sg" {
  name        = "zabbix-sg"
  description = "sg for zabbix"
  network_id  = yandex_vpc_network.vpc.id

  ingress {
    protocol       = "TCP"
    description    = "allow HTTP protocol"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "allow 10050 and 10051"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 10050
    to_port        = 10051
  }

  ingress {
    protocol       = "TCP"
    description    = "allow 5432 psql"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 5432
  }

  egress {
    protocol       = "ANY"
    description    = "permit ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#kibana
resource "yandex_vpc_security_group" "kibana-sg" {
  name        = "kibana-sg"
  description = "sg for kibana"
  network_id  = yandex_vpc_network.vpc.id

  ingress {
    protocol       = "TCP"
    description    = "allow 5601"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 5601
  }

  egress {
    protocol       = "ANY"
    description    = "permit ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#elasticsearch
resource "yandex_vpc_security_group" "elasticsearch-sg" {
  name        = "elasticsearch-sg"
  description = "sg for elasticsearch"
  network_id  = yandex_vpc_network.vpc.id

  ingress {
    protocol       = "TCP"
    description    = "allow 9200"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 9200
  }

  egress {
    protocol       = "ANY"
    description    = "permit ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#bastion-host-external
resource "yandex_vpc_security_group" "bastion-host-external-sg" {
  name        = "bastion-host-external-sg"
  description = "sg for bastion-host-external"
  network_id  = yandex_vpc_network.vpc.id

  ingress {
    protocol       = "TCP"
    description    = "allow 22"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "allow 22"
    v4_cidr_blocks = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24"]
    port           = 22
  }

  egress {
    protocol       = "TCP"
    description    = "allow 22"
    v4_cidr_blocks = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "permit ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#bastion-host-internal
resource "yandex_vpc_security_group" "bastion-host-internal-sg" {
  name        = "bastion-host-internal-sg"
  description = "sg for bastion-host-internal"
  network_id  = yandex_vpc_network.vpc.id

  ingress {
    protocol       = "TCP"
    description    = "allow 22"
    v4_cidr_blocks = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24"]
    port           = 22
  }

  egress {
    protocol       = "TCP"
    description    = "allow 22"
    v4_cidr_blocks = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "permit ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#webs
resource "yandex_vpc_security_group" "webs-sg" {
  name        = "webs-sg"
  description = "sg for webs"
  network_id  = yandex_vpc_network.vpc.id

  ingress {
    description    = "allow HTTP protocol"
    protocol       = "TCP"
    port           = "80"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "allow HTTPS protocol"
    protocol       = "TCP"
    port           = "443"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description       = "Health checks from NLB"
    protocol          = "TCP"
    predefined_target = "loadbalancer_healthchecks" #[198.18.235.0/24, 198.18.248.0/24]
  }

  ingress {
    protocol       = "TCP"
    description    = "allow 10050 and 10051 for zabbix-agent" #["192.168.3.0/24"]
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 10050
    to_port        = 10051
  }

  ingress {
    protocol       = "TCP"
    description    = "allow >5000 random for filebeat" #["192.168.2.0/24"]
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 5000
    to_port        = 65535
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

