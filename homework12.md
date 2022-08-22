# Задача 1.
Какой тип инфраструктуры будем использовать для этого проекта: изменяемый или не изменяемый?
Выбрал бы не изменяемый тип инфраструктуры, в качестве стандарта использовал docker и кубернетис.

Будет ли центральный сервер для управления инфраструктурой?
Использовал бы ансибл, который не предполагает центрального сервера

Будут ли агенты на серверах?
Ансибл не использует агенты на серверах

Будут ли использованы средства для управления конфигурацией или инициализации ресурсов?
Т.к. в компании уже начал использоваться терраформ, продолжил бы использовать его для инициализации ресурсов.

Хотите ли рассмотреть возможность внедрения новых инструментов для этого проекта?
Текущих инструментов достаточно

# Задача 2.
nonstop@umbrella:~$ terraform --version
Terraform v1.2.4
on linux_amd64

Your version of Terraform is out of date! The latest version
is 1.2.7. You can update by downloading from https://www.terraform.io/downloads.html

# Задача 3.
Можно использовать tfswitch.
И можно просто скачать еще один бинарник.
nonstop@umbrella:~$ terraform012 -v

Terraform v0.12.31

Your version of Terraform is out of date! The latest version
is 1.1.7. You can update by downloading from https://www.terraform.io/downloads.html
