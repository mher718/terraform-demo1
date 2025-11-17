# =================== #
# Deploying VMware VM #
# =================== #

# Connect to VMware vSphere vCenter
provider "vsphere" {
  user           = var.vsphere-user
  password       = var.vsphere-password
  vsphere_server = var.vsphere-vcenter

  # If you have a self-signed cert
  allow_unverified_ssl = var.vsphere-unverified-ssl
}


# Create VMs
resource "vsphere_virtual_machine" "vm" {

  for_each         = var.vm
  name             = each.key
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = each.value.cpu
  memory   = each.value.ram

  cpu_hot_add_enabled    = var.cpu_hot_add_enabled
  cpu_hot_remove_enabled = var.cpu_hot_remove_enabled
  memory_hot_add_enabled = var.memory_hot_add_enabled

  guest_id = var.vm-guest-id

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = each.key
    size  = each.value.disk
  }

  connection {
    type     = "ssh"
    host     = each.value.ip4
    user     = var.ssh-user
    password = var.ssh-password
  }

  // Provisioning
  provisioner "file" {
    source      = "scripts/setup.sh"
    destination = "setup.sh"
  }

  //provisioner "file" {
  //  source      = "scripts/resize.sh"
  //  destination = "resize.sh"
  //}
  provisioner "remote-exec" {
    inline = [
      "sudo bash setup.sh"
    ]
  }
  //provisioner_user        = "administrator"
  //provisioner_password    = "supersecret-passwd"
  //provisioner_source_file = "scripts/setup.sh"

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      timeout = 0

      linux_options {
        host_name = each.key
        domain    = var.vm-domain
      }

      network_interface {
        ipv4_address = each.value.ip4
        ipv4_netmask = each.value.mask
      }
      ipv4_gateway    = "192.168.0.1"
      dns_server_list = ["192.168.0.1"]
      // dns_suffix_list = "smctr.net"
    }
  }
}
