terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version =  ">= 0.13"
}

provider yandex {
  token     = " "
  cloud_id  = "b1go25qu14ai0gmnuah1"
  folder_id = "b1gtok8tlhffaunrl10r"
  zone      = "default-ru-central1-a"
}

data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2004-lts"
}
 
resource "yandex_compute_instance" "vm-test1" {
  name = "test1"
 
  resources {
    cores  = 2
    memory = 2
  }
 
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }
 
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }
 
 

 
}
 
resource "yandex_vpc_network" "network_terraform" {
  name = "net_terraform"
}
 
resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = "sub_terraform"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["192.168.15.0/24"]
}
