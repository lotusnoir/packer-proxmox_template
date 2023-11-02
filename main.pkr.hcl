#################################################
variable "proxmox_host" {
  description = "URL to the Proxmox API, fqdn or ip:port."
  type        = string
}

variable "proxmox_skip_tls" {
  description = "Skip validating the certificate."
  type        = bool
  default     = false
}

variable "proxmox_node" {
  description = "Which node in the Proxmox cluster to start the virtual machine on during creation."
  type        = string
}

variable "proxmox_pool" {
  description = "Name of resource pool to create virtual machine in."
  type        = string
  default     = null
}

variable "proxmox_username" {
  description = "Username when authenticating to Proxmox, including the realm"
  type        = string
}

variable "proxmox_password" {
  description = "Password for the user."
  type        = string
  sensitive   = true
  default     = null
}

variable "proxmox_token" {
  description = "Token for authenticating API calls. This allows the API client to work with API tokens instead of user passwords. "
  type        = string
  default     = null
}


#################################################
variable "task_timeout" {
  description = "The timeout for Promox API operations, e.g. clones."
  type        = string
  default     = "1m"
}


#################################################
variable "iso_url" {
  description = "Multiple URLs for the ISO to download. Packer will try these in order. If anything goes wrong attempting to download or while downloading a single URL, it will move on to the next. All URLs must point to the same file (same checksum). By default this is empty and iso_url is used. Only one of iso_url or iso_urls can be specified."
  type        = string
  default     = ""
}

variable "iso_checksum" {
  description = "The checksum for the ISO file or virtual hard drive file. The type of the checksum is specified within the checksum field as a prefix. The type of the checksum can also be omitted and Packer will try to infer it based on string length."
  type        = string
  default     = ""
}

variable "iso_target_path" {
  description = "The path where the iso should be saved after download. By default will go in the packer cache, with a hash of the original filename and checksum as its name."
  type        = string
  default     = null
}

variable "iso_storage_pool" {
  description = "Proxmox storage pool onto which to upload the ISO file."
  type        = string
  default     = null
}

variable "iso_file" {
  type    = string
  default = null
}



#################################################
variable "boot_key_interval" {
  description = "Boot Key Interval."
  type        = string
  default     = "5ms"
}

variable "vm_name" {
  description = "Name of the virtual machine during creation. If not given, a random uuid will be used."
  type        = string
}

variable "vm_id" {
  description = "The ID used to reference the virtual machine. This will also be the ID of the final template. Proxmox VMIDs are unique cluster-wide and are limited to the range 100-999999999. If not given, the next free ID on the cluster will be used."
  type        = number
  default     = 0
}

variable "vm_memory" {
  description = "How much memory (in megabytes) to give the virtual machine. If ballooning_minimum is also set, memory defines the maximum amount of memory the VM will be able to use."
  type        = number
  default     = 512
}

variable "vm_ballooning_minimum" {
  description = "Setting this option enables KVM memory ballooning and defines the minimum amount of memory (in megabytes) the VM will have."
  type        = number
  default     = 0
}

variable "vm_cores" {
  description = "How many CPU cores to give the virtual machine."
  type        = number
  default     = 1
}

variable "vm_cpu_type" {
  description = "How many CPU sockets to give the virtual machine."
  type        = string
  default     = "host"
}

variable "vm_sockets" {
  description = "How many CPU sockets to give the virtual machine."
  type        = number
  default     = 1
}

variable "vm_numa" {
  description = "support for non-uniform memory access (NUMA) is enabled."
  type        = bool
  default     = false
}

variable "vm_os" {
  description = "The operating system. Can be wxp, w2k, w2k3, w2k8, wvista, win7, win8, win10, l24 (Linux 2.4), l26 (Linux 2.6+), solaris or other."
  type        = string
  default     = "l26"
}

variable "boot_order" {
  description = "Override default boot order. Format example order=virtio0;ide2;net0. Prior to Proxmox 6.2-15 the format was cdn (c:CDROM -> d:Disk -> n:Network)"
  type        = string
  default     = "cdn"
}

variable "vm_bios" {
  type    = string
  default = "seabios"
}

variable "vm_efi_config" {
  type    = map(string)
  default = null
}

variable "vm_machine_type" {
  type    = string
  default = ""
}

variable "template_name" {
  type = string
}

variable "template_description" {
  type = string
}


variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "boot_command" {
  type        = list(string)
  description = "boot command instructions"
}

variable "root_password" {
  type      = string
  sensitive = true
}

variable "ssh_password" {
  type      = string
  sensitive = true
}

variable "ssh_username" {
  type    = string
  default = "admin"
}

variable "http_proxy" {
  type    = string
  default = ""
}

variable "boot_filename" {
  type = string
}

variable "net_ip" {
  type    = string
  default = ""
}
variable "net_gateway" {
  type    = string
  default = ""
}

variable "net_netmask" {
  type    = string
  default = "255.255.255.0"
}

variable "net_dns" {
  type    = string
  default = "8.8.8.8"
}

variable "timezone" {
  type    = string
  default = "Europe/Paris"
}

variable "locales" {
  type    = string
  default = "en_US.UTF-8"
}

variable "keyboard_layout" {
  type    = string
  default = "us"
}

variable "disk_boot_size" {
  type    = number
  default = "640"
}

variable "disk_swap_size" {
  type    = number
  default = "1024"
}

variable "http_port_min" {
  type    = number
  default = 8000
}

variable "http_port_max" {
  type    = number
  default = 9000
}

variable "unmount_iso" {
  description = "Remove the mounted ISO from the template after finishing."
  type        = bool
  default     = true
}

variable "autoinstall_file_path" {
  type = string
}

variable "disk_size" {
  type = string
}

variable "disk_format" {
  type    = string
  default = "raw"
}

variable "disk_io_thread" {
  type    = bool
  default = false
}

variable "disk_storage_pool" {
  type = string
}

variable "disk_type" {
  type    = string
  default = "scsi"
}

variable "scsi_controller" {
  type    = string
  default = "virtio-scsi-pci"
}
variable "qemu_agent" {
  type    = bool
  default = true
}
###########################################
### Ansible vars
variable "ansible_path" {
  type = string
}

variable "ansible_playbook" {
  type    = string
  default = "packer.yml"
}

variable "ansible_groups" {
  type    = list(string)
  default = []
}


##########################################################
## CLONE PARAMS
##########################################################
source "proxmox-iso" "this" {
  ### proxmox hypervisor config
  proxmox_url              = "https://${var.proxmox_host}/api2/json"
  insecure_skip_tls_verify = var.proxmox_skip_tls
  node                     = var.proxmox_node
  pool                     = var.proxmox_pool
  username                 = var.proxmox_username
  password                 = var.proxmox_password
  token                    = var.proxmox_token

  ### Misc config
  task_timeout = var.task_timeout
  qemu_agent   = var.qemu_agent

  ### Image config
  iso_url          = var.iso_url
  iso_checksum     = var.iso_checksum
  iso_storage_pool = var.iso_storage_pool
  iso_target_path  = var.iso_target_path
  iso_file         = var.iso_file

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
    efi_storage_pool  = "local-lvm"
    efi_type          = "4m"
    pre_enrolled_keys = true
  }
  network_adapters {
    bridge   = "vmbr0"
    model    = "virtio"
    firewall = false
    #vlan_tag = ""
  }

  ### Install config
  boot_key_interval = var.boot_key_interval
  #boot              = var.boot_order
  boot_command  = var.boot_command
  boot_wait     = var.boot_wait
  http_port_min = var.http_port_min
  http_port_max = var.http_port_max
  http_content = {
    "/${var.boot_filename}" = templatefile(var.autoinstall_file_path, {
      root_password        = var.root_password,
      ssh_username         = var.ssh_username,
      ssh_password         = var.ssh_password,
      net_ip               = var.net_ip,
      net_gateway          = var.net_gateway,
      net_netmask          = var.net_netmask,
      net_dns              = var.net_dns,
      timezone             = var.timezone,
      locales              = var.locales,
      keyboard_layout      = var.keyboard_layout,
      disk_swap_size       = var.disk_swap_size,
      disk_boot_size       = var.disk_boot_size,
      http_proxy           = var.http_proxy

    })
  }

  ### Connection config
  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  ssh_timeout  = "15m"

  ### Closure config
  unmount_iso = var.unmount_iso
}

build {
  sources = ["source.proxmox-iso.this"]

  provisioner "ansible" {
    playbook_file    	= "${var.ansible_path}/playbooks/${var.ansible_playbook}"
    roles_path       	= "${var.ansible_path}/roles/base"
    inventory_directory = "${var.ansible_path}/inventory"
    user             	= "${var.ssh_username}"
    groups           	= "${var.ansible_groups}"
    host_alias          = "${var.vm_name}"
    #extra_arguments     = [ "--limit=!packer_test"]
    ansible_env_vars 	= [
      "ANSIBLE_CONFIG=${var.ansible_path}/ansible.cfg",
      "ANSIBLE_FORCE_COLOR=1",
      "PACKER_BUILD_NAME=${var.vm_name}"
    ]
  }
}
