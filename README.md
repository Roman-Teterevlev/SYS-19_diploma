### Roman Teterevlev

### Дипломная работа по профессии «Системный администратор»

1. Принципиальная схема создаваемой инфраструктуры:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_scheme.png)

2. Развертывание инфраструктуры производится посредством terraform со стороннего VPS (macloud.host). Манифест прилагается.

2.1. Созданы требуемые сервисы yandex-cloud:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_services.png)

2.2. Созданы необходимые виртуальные машины:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_vms.png)

2.3. Создана сеть vps и четыре подсети:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_vpc.png)

2.4. Созданы security groups:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_sgs.png)

2.5. Создан балансировщик нагрузки приложений (alb):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_balancer_healthy.png)
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_balancer_1.png)
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_balancer_2.png)

2.6. Созданы снимкм дисков витруальных машин:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_snapshots.png)

2.7. Создано расписание создания и удаления снимков дисков:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_schedule.png)

3. Создание создание и запуск сервисов осуществляется посредством ansible с бастион-хоста.

3.1. Структура дерева ansible playbook:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_ansible_tree.png)

3.2. Информационные панели параметров zabbix-server и web-servers:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_dboard_srv.png)
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_dboard_webs.png)

3.3. Ответ elasticsearch:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_elasticsearch.png)

3.4. Интерфейс kibana:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc_kibana.png)

Для доступа и проверки работоспособности инфорструктуры предоставлен доступ на bastion-host: "62.84.118.39", "id_ed25519".

 
