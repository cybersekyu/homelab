# Proxmox Full-Clone
# ---
# Create a new VM from a clone

resource "proxmox_vm_qemu" "media-server-test" {
    
    # VM General Settings
    target_node = "pve"
    vmid = "107"
    name = "media-server-test"
    desc = "This is a testing server to serve plex,radarr, etc."

    # VM Advanced General Settings
    onboot = true 

    # VM OS Settings
    clone = "ubuntu-jammy-docker"

    # VM System Settings
    agent = 1
    
    # VM CPU Settings
    cores = 2
    sockets = 1
    cpu = "host"    
    
    # VM Memory Settings
    memory = 2048

    # VM Network Settings
    network {
        bridge = "vmbr0"
        model  = "virtio"
    }

    
    scsihw = "virtio-scsi-single"  # default virtio-scsi-pci

    disks {
        virtio {
            virtio1 {
                disk {
                    storage = "VM_Storage"
                    size = 40
                    iothread = true
                }
            }
        }
     }

    # VM Cloud-Init Settings
    os_type = "cloud-init"

    # (Optional) IP Address and Gateway
    ipconfig0 = "ip=192.168.1.65/24,gw=192.168.1.1"
    nameserver = "192.168.1.115"
    # (Optional) Default User
    # ciuser = "your-username"
    
    # (Optional) Add your SSH KEY
    # sshkeys = <<EOF
    # #YOUR-PUBLIC-SSH-KEY
    # EOF

    # # -- lifecycle
    lifecycle {
       ignore_changes = [ 
           disk,
           vm_state         
        ]
     }


}