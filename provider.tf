locals {
  cloud_id           = "b1g03noj206e3icqnots"
  folder_id          = "b1gi4fphiuhcqgm7gik7"
  zone               = "ru-central1-a"
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}


provider "yandex" {
  cloud_id  = local.cloud_id
  folder_id = local.folder_id
}
