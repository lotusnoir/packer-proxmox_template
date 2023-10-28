#----------------------------------------------------------------------------------
# Variable definition file to build the Debian 12 image 
#----------------------------------------------------------------------------------
# https://www.debian.org/download
# https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA512SUMS
# https://cdimage.debian.org/mirror/cdimage/archive/

### proxmox hypervisor variables
proxmox_host     = "192.168.51.1:8006"
proxmox_skip_tls = true
proxmox_node     = "geekom"
proxmox_username = "packer@pve"
proxmox_password = "packer"
#proxmox_pool     = ""
#proxmox_token    = "xxxxxxxxx"


### Misc variables
task_timeout = "5m"
unmount_iso  = true


### Image variables
iso_url          = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.2.0-amd64-netinst.iso"
iso_checksum     = "11d733d626d1c7d3b20cfcccc516caff2cbc57c81769d56434aab958d4d9b3af59106bc0796252aeefede8353e2582378e08c65e35a36769d5cf673c5444f80e"
iso_storage_pool = "local"
#iso_target_path  = "isos_cache"


### VM variables
vm_name   = "debian-12"
vm_memory = 2048
vm_cores  = 1
#vm_id                 = "100"
#vm_ballooning_minimum = 0
#vm_cpu_type           = "host"
#vm_sockets            = 1
#vm_numa               = false
#vm_os                 = "other"
#vm_bios               = "seabios"
#vm_efi_config         = ""
#vm_machine_type       = ""

disk_size         = "6G"
disk_storage_pool = "local-lvm"
#disk_format       = "raw"
#disk_io_thread    = false
#disk_type         = "scsi"


### Install variables
#boot_key_interval = "5ms"
#boot_wait = "10s"
boot_command = [
  "<esc><wait>",
  "auto <wait>",
  "netcfg/disable_autoconfig=true ",
  "netcfg/use_autoconfig=false ",
  "netcfg/get_ipaddress=192.168.49.33 ",
  "netcfg/get_netmask=255.255.252.0 ",
  "netcfg/get_gateway=192.168.48.1 ",
  "netcfg/get_nameservers=1.1.1.1 ",
  "netcfg/confirm_static=true <wait>",
  "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
  "<enter><wait>"
]
#http_port_min = 8080
#http_port_max = 8080
autoinstall_file_path = "packer-unattended_distrib_files/linux/debian/preseed.pkrtpl"


### System variables
template_name        = "template-linux-debian-12-test"
template_description = "debian-12.2.0"
root_password = "test"
ssh_username  = "white"
ssh_password  = "test"
#http_proxy            = ""


### Provisionning Ansible
ansible_path   = "/opt/ansible_core"
ansible_groups = ["site_home", "os_debian12", "groups_templates"]
