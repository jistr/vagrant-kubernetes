require 'yaml'

VAGRANTFILE_API_VERSION = "2"
CONFIG_FILE_NAME = ENV["VAGRANT_CONFIG"] || File.dirname(__FILE__) + '/vagrant-config.yml'
CFG = YAML.load(File.read(CONFIG_FILE_NAME))

Vagrant.require_version ">= 1.6.2"


def master_vm(master_num, config)
  hostname = "master#{master_num}"
  ip = "#{CFG['common']['ip_address_net_24']}.#{CFG['master']['ip_address_start'] + master_num}"

  config.vm.define hostname do |vm_config|
    vm_config.vm.hostname = hostname
    vm_config.vm.network "private_network", ip: ip, libvirt__dhcp_enabled: false, libvirt__network_name: CFG["libvirt"]["private_net_name"]

    vm_config.vm.provider :libvirt do |libvirt|
      libvirt.memory = 1536
      libvirt.cpus = 2
    end

    # vm_config.vm.provision "shell", inline: "/vagrant-sync/preconfigure.sh"
  end
end

def node_vm(node_num, config)
  hostname = "node#{node_num}"
  ip = "#{CFG['common']['ip_address_net_24']}.#{CFG['node']['ip_address_start'] + node_num}"

  config.vm.define hostname do |vm_config|
    vm_config.vm.hostname = hostname
    vm_config.vm.network "private_network", ip: ip, libvirt__dhcp_enabled: false, libvirt__network_name: CFG["libvirt"]["private_net_name"]

    vm_config.vm.provider :libvirt do |libvirt|
      libvirt.memory = 2048
      libvirt.cpus = 2
    end

    # vm_config.vm.provision "shell", inline: "/vagrant-sync/preconfigure.sh"
  end
end

# === Vagrant config ===

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.ssh.username = 'root'

  config.vm.synced_folder ".", "/vagrant", disabled: true
  # config.vm.synced_folder './vagrant-sync', '/vagrant-sync', type: 'rsync'

  config.vm.provider :libvirt do |libvirt, override|
    libvirt.driver = 'kvm'
    libvirt.connect_via_ssh = false
    libvirt.username = 'root'
    libvirt.default_prefix = CFG["libvirt"]["default_prefix"]
    libvirt.storage_pool_name = CFG["libvirt"]["storage_pool_name"]
    # libvirt.uri = CFG["libvirt"]["uri"]

    override.vm.box = CFG["libvirt"]["box"]
    override.vm.provider :libvirt do |vm_libvirt|
      libvirt.suspend_mode = CFG["libvirt"]["suspend_mode"]
    end
  end

  (0...CFG["master"]["count"]).each do |master_num|
    master_vm(master_num, config)
  end

  (0...CFG["node"]["count"]).each do |node_num|
    node_vm(node_num, config)
  end
end
