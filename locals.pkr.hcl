#locals {
#  proxmox_host      = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/proxmox", var.proxmox_url) : var.proxmox_url
#  proxmox_username = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/proxmox", var.proxmox_username) : var.proxmox_username
#  proxmox_password = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/proxmox", var.proxmox_password) : var.proxmox_password
#  root_password    = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/ssh", "root_password") : var.root_password
#  ssh_username     = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/ssh", "ssh_username") : var.ssh_username
#  ssh_password     = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/ssh", "ssh_password") : var.ssh_password
#  winrm_username   = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/ssh", "winrm_username") : var.winrm_username
#  winrm_password   = var.secrets_method == "vault" ? vault("${var.vault_kv_path}/ssh", "winrm_password") : var.winrm_password
#}

locals {
  ### Secrets
  proxmox_host     = var.secrets_method == "plain" ? var.proxmox_host : vault("${var.vault_kv_path}/proxmox", var.proxmox_host)
  proxmox_username = var.secrets_method == "plain" ? var.proxmox_username : vault("${var.vault_kv_path}/proxmox", var.proxmox_username)
  proxmox_password = var.secrets_method == "plain" ? var.proxmox_password : vault("${var.vault_kv_path}/proxmox", var.proxmox_password)
  root_password    = var.secrets_method == "plain" ? var.root_password : vault("${var.vault_kv_path}/ssh", var.root_password)
  ssh_username     = var.secrets_method == "plain" ? var.ssh_username : vault("${var.vault_kv_path}/ssh", var.ssh_username)
  ssh_password     = var.secrets_method == "plain" ? var.ssh_password : vault("${var.vault_kv_path}/ssh", var.ssh_password)
  winrm_username   = var.secrets_method == "plain" ? var.winrm_username : vault("${var.vault_kv_path}/ssh", var.winrm_username)
  winrm_password   = var.secrets_method == "plain" ? var.winrm_password : vault("${var.vault_kv_path}/ssh", var.winrm_password)

  ### Unattended variables
  unattended_content = {
    for key, value in var.unattended_content : key => templatefile(value.template, merge(value.vars, {
      winrm_username = var.winrm_username
      winrm_password = var.winrm_password
    }))
  }
  unattended_as_cd = length(var.unattended_content) > 0 ? [{
    type    = "sata"
    index   = 3 + length(var.unattended_content)
    content = local.unattended_content
    label   = "Windows Unattended CD"
  }] : []
  additional_cd_files = concat(var.additional_cd_files, local.unattended_as_cd)

  http_content = {
    for key, value in var.http_content : key => templatefile(value.template, merge(value.vars, {
      vm_name          = var.vm_name
      internet_install = var.internet_install
      filesystem_type  = var.filesystem_type
      root_password    = local.root_password
      ssh_username     = local.ssh_username
      ssh_password     = local.ssh_password
      net_ip           = var.net_ip
      net_gateway      = var.net_gateway
      net_netmask      = var.net_netmask
      net_dns          = var.net_dns
      timezone         = var.timezone
      locales          = var.locales
      keyboard_layout  = var.keyboard_layout
      disk_swap_size   = var.disk_swap_size
      disk_boot_size   = var.disk_boot_size
      disk_name        = var.disk_name
      http_proxy       = var.http_proxy
      major_version    = var.major_version
    }))
  }
}
