output "web1-public-ip" {
  value = yandex_compute_instance.web1.network_interface.0.nat_ip_address
}

output "web2-public-ip" {
  value = yandex_compute_instance.web2.network_interface.0.nat_ip_address
}

output "zabbix-public-ip" {
  value = yandex_compute_instance.zabbix.network_interface.0.nat_ip_address
}

output "elasticsearch-public-ip" {
  value = yandex_compute_instance.elasticsearch.network_interface.0.nat_ip_address
}

output "kibana-public-ip" {
  value = yandex_compute_instance.kibana.network_interface.0.nat_ip_address
}

output "bastion-host-public-ip" {
  value = yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address
}

