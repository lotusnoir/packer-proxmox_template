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
  http_content = {
    "/${var.boot_autoinstall_file_name}" = templatefile(var.boot_autoinstall_file_path, {
      internet_install = var.internet_install
      vm_name          = var.vm_name
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
  efi_config {
    efi_storage_pool  = var.disk_efi_storage_pool
    pre_enrolled_keys = var.disk_efi_pre_enrolled_keys
    efi_format        = var.disk_efi_format
    efi_type          = var.disk_efi_type
  }
  network_adapters {
    bridge   = var.network_adapters_bridge
    model    = var.network_adapters_model
    firewall = var.network_adapters_firewall
    #vlan_tag = ""
  }

  cloud_init              = var.cloud_init
  cloud_init_storage_pool = var.cloud_init_storage_pool

  ### Connection config
  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  ssh_timeout  = "15m"
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
