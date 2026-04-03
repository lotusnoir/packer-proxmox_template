locals {
  proxmox_url      = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/proxmox", var.proxmox_url) : var.proxmox_url
  proxmox_username = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/proxmox", var.proxmox_username) : var.proxmox_username
  proxmox_password = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/proxmox", var.proxmox_password) : var.proxmox_password
  root_password    = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/ssh", "root_password") : var.root_password
  ssh_username     = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/ssh", "ssh_username") : var.ssh_username
  ssh_password     = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/ssh", "ssh_password") : var.ssh_password
  winrm_username   = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/ssh", "winrm_username") : var.winrm_username
  winrm_password   = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/ssh", "winrm_password") : var.winrm_password
}
