resource "yandex_vpc_network" "vpc" {
  # folder_id = var.folder_id
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "subnet" {
  # folder_id = var.folder_id
  v4_cidr_blocks = var.subnet_cidrs
  zone           = var.zone
  name           = var.subnet_name
  network_id = yandex_vpc_network.vpc.id
}

resource "yandex_compute_instance" "VM-NGINX" {
  name        = var.vm_name
  hostname    = var.vm_name
  platform_id = var.platform_id
  zone        = var.zone
  # folder_id   = var.folder_id
  resources {
    cores         = var.cpu
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.disk
      type     = var.disk_type
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet.id
    nat                = var.nat
    ip_address         = var.internal_ip_address
    nat_ip_address     = var.nat_ip_address
  }

  metadata = {
    ssh-keys           = "${var.user}:${file("~/.ssh/id_rsa.pub")}"
  }


 provisioner "remote-exec" {
    connection {
      type        = var.type_remote_exec
      user        = var.user
      host        = self.network_interface.0.nat_ip_address
      private_key = file("${var.private_key}")
    }

    inline = [
      "sudo apt-get -y update",
    ]
 }

provisioner "local-exec" {
        command = "ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -u ${var.user} -i '${yandex_compute_instance.VM-NGINX.network_interface.0.nat_ip_address},' --private-key '${var.private_key}' ${var.playbook_path}"
    }
}
output "instance_external_ip" {
  value = "${yandex_compute_instance.VM-NGINX.network_interface.0.nat_ip_address}"
}
resource "local_file" "ansible_inventory" {
  count = 1
  content = templatefile("${path.cwd}/inventory.tpl",
    {
      host = yandex_compute_instance.VM-NGINX.name,
      address = yandex_compute_instance.VM-NGINX.network_interface.0.nat_ip_address,
      user = "${var.user}",
      private_key = "${var.private_key}",
    }
  )
  filename = "${path.module}/ansible/inventory.ini"
}
