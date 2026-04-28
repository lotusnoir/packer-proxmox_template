##########################################################
## CLONE PARAMS
##########################################################
source "proxmox-iso" "this" {
  ### Iso config
  boot_iso {
    type             = var.iso_type
    iso_url          = var.iso_url
    iso_urls         = var.iso_urls
    iso_checksum     = var.iso_checksum
    iso_storage_pool = var.iso_storage_pool
    iso_target_path  = var.iso_target_path
    iso_file         = var.iso_file
    unmount          = var.iso_unmount
  }

  dynamic "additional_iso_files" {
    for_each = var.additional_iso_mounts
    content {
      iso_storage_pool = additional_iso_files.value.iso_storage_pool
      device           = additional_iso_files.value.device
      iso_file         = additional_iso_files.value.iso_file
      unmount          = additional_iso_files.value.unmount
    }
  }

  dynamic "additional_iso_files" {
    for_each = var.additional_cd_files

    content {
      iso_storage_pool = additional_iso_files.value.iso_storage_pool
      device           = additional_iso_files.value.device
      unmount          = additional_iso_files.value.unmount
      cd_files         = additional_iso_files.value.cd_files
      cd_label         = additional_iso_files.value.cd_label

      cd_content = (
        additional_iso_files.value.cd_content_file_name != "" ?
        {
          "/${additional_iso_files.value.cd_content_file_name}" = templatefile(
            additional_iso_files.value.cd_content_file_path,
            {
              vm_name          = var.vm_name
              internet_install = var.internet_install
              filesystem_type  = var.filesystem_type
              root_password    = local.root_password
              ssh_username     = local.ssh_username
              ssh_password     = additional_iso_files.value.cd_content_file_name == "user-data" ? bcrypt(local.ssh_password) : local.ssh_password
              net_ip           = var.net_ip
              net_gateway      = var.net_gateway
              net_netmask      = var.net_netmask
              net_dns          = var.net_dns
              timezone         = var.timezone
              locales          = var.locales
              keyboard_layout  = var.keyboard_layout
              disk_name        = var.disk_name
              disk_swap_size   = var.disk_swap_size
              disk_boot_size   = var.disk_boot_size
              http_proxy       = var.http_proxy
              major_version    = var.major_version
              winrm_username   = local.winrm_username
              winrm_password   = local.winrm_password
            }
          )
        }
        : {}
      )
    }
  }

  #  dynamic "additional_iso_files" {
  #    for_each = var.additional_iso_files != null ? [var.additional_iso_files] : []
  #    content {
  #      iso_storage_pool = additional_iso_files.value.iso_storage_pool
  #      device           = additional_iso_files.value.device
  #      iso_file         = (
  #  try(additional_iso_files.value.iso_file, "") != ""
  #) ? additional_iso_files.value.iso_file : null
  #      unmount          = additional_iso_files.value.unmount
  #      cd_files         = additional_iso_files.value.cd_files
  #      cd_label         = additional_iso_files.value.cd_label
  #      cd_content = additional_iso_files.value.cd_content_file_name == "" ? {} : {
  #        "/${additional_iso_files.value.cd_content_file_name}" = templatefile(additional_iso_files.value.cd_content_file_path, {
  #          vm_name          = var.vm_name
  #          internet_install = var.internet_install
  #          filesystem_type  = var.filesystem_type
  #          root_password    = local.root_password
  #          ssh_username     = local.ssh_username
  #          ssh_password     = var.additional_iso_cd_content_file_name == "user-data" ? bcrypt("${local.ssh_password}") : local.ssh_password
  #          net_ip           = var.net_ip
  #          net_gateway      = var.net_gateway
  #          net_netmask      = var.net_netmask
  #          net_dns          = var.net_dns
  #          timezone         = var.timezone
  #          locales          = var.locales
  #          keyboard_layout  = var.keyboard_layout
  #          disk_name        = var.disk_name
  #          disk_swap_size   = var.disk_swap_size
  #          disk_boot_size   = var.disk_boot_size
  #          http_proxy       = var.http_proxy
  #          major_version    = var.major_version
  #          winrm_username   = local.winrm_username
  #          winrm_password   = local.winrm_password
  #        })
  #      }
  #    }
  #  }

  ### Boot config
  boot_key_interval = var.boot_key_interval
  boot              = var.boot_order
  boot_wait         = var.boot_wait
  boot_command      = var.boot_command

  http_interface = var.http_interface
  #http_bind_address = var.http_bind_address
  #http_network_protocol = var.http_network_protocol
  http_port_min = var.http_port_min
  http_port_max = var.http_port_max
  http_content = var.http_content_file_name == "" ? {} : {
    "/${var.http_content_file_name}" = templatefile(var.http_content_file_path, {
      vm_name          = var.vm_name
      internet_install = var.internet_install
      filesystem_type  = var.filesystem_type
      root_password    = local.root_password
      ssh_username     = local.ssh_username
      ssh_password     = local.ssh_password
      ssh_password     = var.http_content_file_name == "user-data" ? bcrypt("${local.ssh_password}") : local.ssh_password
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
      winrm_username   = local.winrm_username
      winrm_password   = local.winrm_password
    })
  }

  ### hypervisor config
  proxmox_url              = var.proxmox_url
  insecure_skip_tls_verify = var.proxmox_skip_tls
  node                     = var.proxmox_node
  pool                     = var.proxmox_pool
  username                 = var.proxmox_username
  password                 = var.proxmox_password
  token                    = var.proxmox_token



  ### Misc config
  task_timeout = var.task_timeout
  qemu_agent   = var.qemu_agent

  ### VM config
  vm_name              = var.vm_name
  vm_id                = var.vm_id
  memory               = var.vm_memory
  ballooning_minimum   = var.vm_ballooning_minimum
  cores                = var.vm_cores
  cpu_type             = var.vm_cpu_type
  sockets              = var.vm_sockets
  numa                 = var.vm_numa
  os                   = var.vm_os
  bios                 = var.vm_bios
  machine              = var.vm_machine_type
  template_name        = var.template_name
  template_description = var.template_description
  scsi_controller      = var.scsi_controller

  disks {
    disk_size    = var.disk_size
    format       = var.disk_format
    io_thread    = var.disk_io_thread
    storage_pool = var.disk_storage_pool
    type         = var.disk_type
  }

  dynamic "efi_config" {
    for_each = var.efi_config
    content {
      efi_storage_pool  = efi_config.value.efi_storage_pool
      pre_enrolled_keys = efi_config.value.efi_pre_enrolled_keys
      efi_format        = efi_config.value.efi_format
      efi_type          = efi_config.value.efi_type
    }
  }

  network_adapters {
    bridge   = var.network_adapters_bridge
    model    = var.network_adapters_model
    firewall = var.network_adapters_firewall
    vlan_tag = var.network_adapters_vlan_tag
  }

  cloud_init              = var.cloud_init
  cloud_init_storage_pool = var.cloud_init_storage_pool

  ### Communicator configuration
  communicator                 = var.communicator
  pause_before_connecting      = var.pause_before_connecting
  ssh_host                     = var.ssh_host
  ssh_port                     = var.ssh_port
  ssh_username                 = local.ssh_username
  ssh_password                 = local.ssh_password
  ssh_ciphers                  = var.ssh_ciphers
  ssh_clear_authorized_keys    = var.ssh_clear_authorized_keys
  ssh_key_exchange_algorithms  = var.ssh_key_exchange_algorithms
  ssh_certificate_file         = var.ssh_certificate_file
  ssh_pty                      = var.ssh_pty
  ssh_timeout                  = var.ssh_timeout
  ssh_disable_agent_forwarding = var.ssh_disable_agent_forwarding
  ssh_handshake_attempts       = var.ssh_handshake_attempts
  ssh_bastion_host             = var.ssh_bastion_host
  ssh_bastion_port             = var.ssh_bastion_port
  ssh_bastion_agent_auth       = var.ssh_bastion_agent_auth
  ssh_bastion_username         = var.ssh_bastion_username
  ssh_bastion_password         = var.ssh_bastion_password
  ssh_bastion_interactive      = var.ssh_bastion_interactive

  winrm_username = local.winrm_username
  winrm_password = local.winrm_password
  winrm_host     = var.winrm_host
  winrm_no_proxy = var.winrm_no_proxy
  winrm_port     = var.winrm_port
  winrm_timeout  = var.winrm_timeout
  winrm_use_ssl  = var.winrm_use_ssl
  winrm_insecure = var.winrm_insecure
  winrm_use_ntlm = var.winrm_use_ntlm
}

build {
  sources = ["source.proxmox-iso.this"]

  provisioner "ansible" {
    playbook_file       = "${var.ansible_path}/playbooks/${var.ansible_playbook}"
    roles_path          = "${var.ansible_path}/roles/base"
    inventory_directory = "${var.ansible_path}/inventory"
    user                = var.communicator == "ssh" ? "${local.ssh_username}" : "${local.winrm_username}"
    groups              = "${var.ansible_groups}"
    host_alias          = "${var.vm_name}"
    use_proxy           = false
    extra_arguments     = var.communicator == "ssh" ? ["--extra-vars", "ansible_ssh_pass=${local.ssh_password}"] : ["-e", "ansible_winrm_server_cert_validation=ignore"]
    ansible_env_vars = [
      "ANSIBLE_HOST_KEY_CHECKING=False",
      "ANSIBLE_CONFIG=${var.ansible_path}/ansible.cfg",
      "ANSIBLE_FORCE_COLOR=1",
      "PACKER_BUILD_NAME=${var.vm_name}"
    ]
  }
}
