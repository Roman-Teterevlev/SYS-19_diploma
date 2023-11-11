### Roman Teterevlev

### Дипломная работа по профессии «Системный администратор»

Принципиальная схема создаваемой инфраструктуры:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_scheme.png)

Развертывание инфраструктуры производится посредством terraform со стороннего VPS (macloud.host). Манифест прилагается.

Созданы требуемые сервисы yandex-cloud:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_services.png)

Созданы необходимые виртуальные машины:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_vms.png)

Создана сеть vps и четыре подсети:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_vpc.png)

Созданы security groups:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_sgs.png)

Создан балансировщик нагрузки приложений (alb):
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_balancer_healthy.png)
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_balancer_1.png)
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_balancer_2.png)

Созданы снимкм дисков витруальных машин:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_snapshots.png)

Создано расписание создания и удаления снимков дисков:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_schedule.png)


Создание и запуск сервисов осуществляется посредством ansible с бастион-хоста.

Структура дерева ansible playbook:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_ansible_tree.png)

Информационные панели параметров zabbix-server и web-servers:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_dboard_srv.png)
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_dboard_webs.png)

Ответ elasticsearch:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_elasticsearch.png)

Интерфейс kibana:
![alt text](https://github.com/Roman-Teterevlev/SYS-19_diploma/blob/main/ptsc/ptsc_kibana.png)
