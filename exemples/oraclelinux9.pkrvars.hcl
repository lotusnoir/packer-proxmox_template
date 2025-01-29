#----------------------------------------------------------------------------------
# Variable definition file to build the OracleLinux 9 image
#----------------------------------------------------------------------------------
#https://yum.oracle.com/oracle-linux-isos.html
#https://linux.oracle.com/security/gpg/checksum/

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
#Bug on proxmox, it doesnt check the existing iso file, if iso not present you use iso_url + iso_checksum + iso_storage_pool
# is iso is present on storage you just use it with iso_file
#iso_url = "https://yum.oracle.com/ISOS/OracleLinux/OL9/u2/x86_64/OracleLinux-R9-U2-x86_64-dvd.iso"
#iso_checksum = "cac3c41cc2d3467ba8902a5d74575bcf460f129634d5a0d1d67d87094dd70b09"
#iso_storage_pool = "local"
iso_file = "local:iso/OracleLinux-R9-U2-x86_64-dvd.iso"
#iso_target_path  = "isos_cache"


### VM variables
vm_name   = "oraclelinux-9"
vm_memory = 4096
vm_cores  = 2
#vm_id                 = "100"
#vm_ballooning_minimum = 0
#Produce kernel panic if not in host mode
vm_cpu_type = "host"
#vm_sockets            = 1
#vm_numa               = false
#vm_os                 = "other"
#vm_bios               = "seabios"
#vm_efi_config         = ""
#vm_machine_type       = ""
#qemu_agent                = true

disk_size         = "8G"
disk_storage_pool = "local-lvm"
#disk_format       = "raw"
#disk_io_thread    = false
#rhel install just support virtio type
disk_type       = "virtio"
scsi_controller = "virtio-scsi-pci"


### Install variables
#boot_key_interval = "5ms"
#boot_wait = "10s"
boot_filename = "ks.cfg"
boot_command  = ["<tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg <enter><wait>"]
#http_port_min = 8080
#http_port_max = 8080
autoinstall_file_path = "packer-unattended_distrib_files/linux/oraclelinux/ks.pkrtpl"

### System variables
template_name        = "template-linux-oraclelinux-9"
template_description = "oraclelinux-9.2.0"
root_password        = "test"
ssh_username         = "white"
ssh_password         = "test"
#http_proxy            = ""
net_ip          = "192.168.49.34"
net_gateway     = "192.168.48.1"
net_netmask     = "255.255.240.0"
net_dns         = "1.1.1.1"
timezone        = "Europe/Paris"
locales         = "en_US.UTF-8"
keyboard_layout = "us"
disk_swap_size  = "1024"
disk_boot_size  = "640"


### Provisionning Ansible
ansible_path   = "/tmp/ansible"
ansible_groups = ["site_home", "os_oraclelinux9", "groups_templates"]
