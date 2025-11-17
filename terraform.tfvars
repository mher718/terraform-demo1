# ============================ #
# VMware vSphere configuration #
# ============================ #

# VMware vCenter IP/FQDN
vsphere-vcenter = "192.168.0.95"

# VMware vSphere username used to deploy the infrastructure
vsphere-user = var.vsphere-user

# VMware vSphere password used to deploy the infrastructure
vsphere-password = var.vsphere-password

# Skip the verification of the vCenter SSL certificate (true/false)
vsphere-unverified-ssl = "true"

# vSphere datacenter name where the infrastructure will be deployed
vsphere-datacenter = "DC Infra Office"

# vSphere cluster name where the infrastructure will be deployed
vsphere-cluster = "DC Infra Cluster"

# vSphere Datastore used to deploy VMs 
vm-datastore = "VMware1-6TB-Raid1"

# vSphere Network used to deploy VMs 
vm-network = "VM Network"

# Linux virtual machine domain name
vm-domain = "smctr.net"

# ======================== #
# VMware VMs configuration #
# ======================== #

vm-template-name = "elmerami-ubnttpl22"
vm-guest-id      = "ubuntu64Guest"

cpu_hot_add_enabled    = "true"
cpu_hot_remove_enabled = "true"
memory_hot_add_enabled = "true"

# Deploy multiple VMs with different hostnames and IPs 
vm = {
  "elmerami-smph02" = {
    ip4  = "192.168.0.117"
    mask = 24
    cpu  = 2
    ram  = 4096
    disk = 50
  }
  "elmerami-smph03" = {
    ip4  = "192.168.0.118"
    mask = 24
    cpu  = 2
    ram  = 4096
    disk = 50
  }
}
## DEMO
#vm = {
#  "hostname1" = {
#    ip4  = "192.168.0.11"
#    mask = 24
#    cpu  = 8
#    ram  = 8192
#    disk = 25 
#    }
#  "hostname22" = {
#    ip4  = "192.168.0.12"
#    mask = 24
#    cpu  = 8
#    ram  = 8192
#    disk = 25 
#    }
#}