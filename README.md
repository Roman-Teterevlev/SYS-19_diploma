#### Роман Тетеревлев (Roman Teterevlev)

#### Дипломная работа. Квалификация "Системный администратор информационно-коммуникационных систем" (Thesis. Qualification "System administrator of information and communication systems")

#### Тема "Разработка отказоустойчивой инфраструктуры сайта" (Theme "Development of the fault-tolerant infrastructure")

#### Задание: создать инфраструктуру: 2 веб-сервера, сервер для мониторинга (zabbix), сервера для сбора и обработки логов (ELK), реализовать концепцию "bastion-host". Используемые инструменты - сервисы yandex-cloud, terraform, ansible (Task: create 2 web-servers, server for monitoring (zabbix), servers for logging (ELK), realize the "bastion-host" concept. Tools - yandex-cloud services, terraform, ansible)

Принципиальная схема создаваемой инфраструктуры (Scheme of the created infrastructure):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_scheme.png)

Развертывание инфраструктуры производится посредством terraform с прокси-сервера. Манифест прилагается (The infrastructure is deployed using terraform from a proxy server. The manifesto is attached)

Созданы требуемые сервисы yandex-cloud (The required yandex-cloud services have been created):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_services.png)

Созданы необходимые виртуальные машины (The necessary virtual machines have been created):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_vms.png)

Создана сеть vps и четыре подсети (The vps network and four subnets have been created):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_vpc.png)

Созданы security groups (Security groups have been created):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_sgs.png)

Создан балансировщик нагрузки приложений (alb) (Application load balancer has been created):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_balancer_healthy.png)
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_balancer_1.png)
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_balancer_2.png)

Созданы снимки дисков витруальных машин (Snapshots have been created):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_snapshots.png)

Создано расписание создания и удаления снимков дисков (The schedule for snapshots has been created):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_schedule.png)

Структура дерева ansible playbook (Ansible playbook tree):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_ansible_tree.png)

Успешное завершение развертывания инфраструктуры (Apply complete):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_local-exec.png)

Информационные панели параметров zabbix-server и web-servers (Zabbix dashboards):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_dboard_srv.png)
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_dboard_webs.png)

Ответ elasticsearch (Elasticsearch output):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_elasticsearch.png)

Интерфейс kibana (Kibana logs outputs):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_kibana.png)

