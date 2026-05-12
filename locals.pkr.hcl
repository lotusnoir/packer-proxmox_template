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
      winrm_username         = var.winrm_username
      winrm_password         = var.winrm_password
      windows_edition        = var.windows_edition == "" ? value.vars.image_name : var.windows_edition
      windows_language       = var.windows_language
      windows_input_language = var.windows_input_language
    }))
  }
  unattended_as_cd = length(var.unattended_content) > 0 ? [{
    type    = "sata"
    index   = 3 + length(var.unattended_content)
    content = local.unattended_content
    label   = "Windows Unattended CD"
  }] : []
  additional_cd_files = concat(var.additional_cd_files, local.unattended_as_cd)

}
