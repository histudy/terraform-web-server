variable "ntp_source_network" {
  default = null
}

resource "sakuracloud_packet_filter" "web_server" {
  name = "web_server"

  expression {
    description      = "HTTP"
    protocol         = "tcp"
    destination_port = "80"
  }
  expression {
    description      = "HTTPS"
    protocol         = "tcp"
    destination_port = "443"
  }
  expression {
    description      = "SSH"
    protocol         = "tcp"
    destination_port = "22"
  }
  expression {
    description    = "NTP"
    protocol       = "udp"
    source_port    = "123"
    allow          = true
  }
  expression {
    description      = "DHCP"
    protocol         = "udp"
    destination_port = "68"
    allow            = true
  }
  expression {
    description = "icmp"
    protocol    = "icmp"
    allow       = true
  }
  expression {
    description = "fragment"
    protocol    = "fragment"
    allow       = true
  }
  expression {
    description = "Deny all"
    protocol    = "ip"
    allow       = false
  }
}
