# variable "folder_id" {
#   type = string
# }

variable "vpc_name" {
  type = string
  description = "VPC name"
}

variable "zone" {
  type = string
  default = "ru-central1-a"
  description = "zone"
}

variable "subnet_name" {
  type = string
  description = "subnet name"
}

variable "subnet_cidrs" {
  type = list(string)
  description = "CIDRs"
}

## ## ##    Параметры VM    ## ## ##
variable "vm_name" {
  description = "Имя VM"
  type        = string
}

variable "cpu" {
  description = "Количество процессоров виртуальной машины"
  default     = 2
  type        = number
}

variable "memory" {
  description = "Размер оперативной памяти виртуальной машины (ГБ)"
  default     = 2
  type        = number
}

variable "core_fraction" {
  description = "Доля ядра, по умолчанию 100%"
  default     = 100
  type        = number
}

variable "disk" {
  description = "Размер диска виртуальной машины"
  default     = 5
  type        = number
}

variable "image_id" {
  description = "Default image ID Ubuntu 20"
  default     = "fd879gb88170to70d38a" # ubuntu-20-04-lts-v20220404
  type        = string
}

variable "nat" {
  type    = bool
  default = true
}

variable "platform_id" {
  type    = string
  default = "standard-v3"
}

variable "internal_ip_address" {
  type    = string
  default = null
}

variable "nat_ip_address" {
  type    = string
  default = null
}

variable "disk_type" {
  description = "Тип Диска"
  type        = string
  default     = "network-ssd"
}

variable "type_remote_exec" {
  description = "Тип подключения для remote-exec"
  type        = string
  default     = "ssh"
}

variable "user" {
  description = "Создаёт пользователя на удаленной машине"
  type        = string
  default     = "ubuntu"
}

variable "private_key" {
  description = "Закрытый ключ SSH для доступа к VM (remote-exec)"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "timeout" {
  description = "Параметр таймаута для remote-exec"
  type        = string
  default     = ""
}

variable "playbook_path" {
  description = "Путь к ansible playbook, который будет выполняться с созданным хостом в качестве инвентаря."
  type        = string
  default     = "~/lession/ansible/nginx.yml"
}
