packer {
  required_plugins {
    proxmox = {
      source  = "github.com/hashicorp/proxmox"
      version = ">= 1.2.3"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.1.4"
    }
    windows-update = {
      source  = "github.com/rgl/windows-update"
      version = ">= 0.17.1"
    }
  }
}
