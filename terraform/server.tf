# Creds to Luiz Eduardo Kowalski, this is based on https://github.com/luizkowalski/terraform-hetzner

terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.50"
    }
  }
}

provider "hcloud" {
  token = var.hetzner_api_key
}

resource "hcloud_ssh_key" "ssh_key_for_hetzner" {
  name       = "ssh-key-for-hetzner"
  public_key = file("~/.ssh/server.pub")
}


resource "hcloud_server" "nixos-server" {
  name              = "nixos-server"
  server_type      = var.server_type
  image            = var.operating_system
  location         = var.region

  ssh_keys = [
    hcloud_ssh_key.ssh_key_for_hetzner.id
  ]
  labels = {
    "ssh"  = "yes",
    "http" = "yes"
  }

  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

resource "hcloud_firewall" "allow_http_https" {
  name = "allow-http-https"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  apply_to {
    label_selector = "http=yes"
  }
}

resource "hcloud_firewall" "allow_ssh" {
  name = "allow-ssh"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  apply_to {
    label_selector = "ssh=yes"
  }
}

output "server_ip" {
  value = hcloud_server.nixos-server.ipv4_address
}