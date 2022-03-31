terraform {
  required_providers {
    sakuracloud = {
      source  = "sacloud/sakuracloud"
      version = "~> 2"
    }
  }
}

variable "server_root_password" {
  default = "p@33w0Rd_n0T_F0und"
}

data "sakuracloud_archive" "debian" {
  os_type = "debian"
}

resource "sakuracloud_disk" "production_official_site" {
  name              = "test"
  source_archive_id = data.sakuracloud_archive.debian.id
}

resource "sakuracloud_server" "production_official_site" {
  name = "web server for histudy official site"
  tags = ["production"]
  disks = [sakuracloud_disk.production_official_site.id]

  network_interface {
    upstream         = "shared"
    packet_filter_id = sakuracloud_packet_filter.web_server.id
  }

  disk_edit_parameter {
    hostname = "histudy.jp"
    password = var.server_root_password
    disable_pw_auth = true
    ssh_key_ids = [
      sakuracloud_ssh_key.akiya.id
    ]
  }
}

output "ip_address" {
  value = sakuracloud_server.production_official_site.ip_address
}
