Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"

  vm_disk_path = "vboxhd"
  public_key = File.read(File.expand_path("~/.ssh/id_ed25519.pub"))

  def setup_node(node, name, ip, memory, storage_size, disk_path, public_key)
    node.vm.hostname = name
    node.vm.network :private_network, ip: ip

    node.vm.provider :virtualbox do |vb|
      vb.memory = memory
      vb.cpus = 1

      vb.customize ["createhd", "--filename", "#{disk_path}/#{name}_disk.vdi", "--size", storage_size * 1024]
      vb.customize ["storageattach", :id, "--storagectl", "SATA Controller",
                    "--port", 1, "--device", 0, "--type", "hdd",
                    "--medium", "#{disk_path}/#{name}_disk.vdi"]
    end

    node.vm.provision "shell", inline: <<-SHELL
      mkdir -p /home/vagrant/.ssh
      echo "#{public_key.strip}" > /home/vagrant/.ssh/authorized_keys
      chown -R vagrant:vagrant /home/vagrant/.ssh
      chmod 700 /home/vagrant/.ssh
      chmod 600 /home/vagrant/.ssh/authorized_keys
    SHELL
  end

  {
    "haproxy-01" => "192.168.60.100",
    "haproxy-02" => "192.168.60.101",
    "haproxy-03" => "192.168.60.102"
  }.each do |name, ip|
    config.vm.define name do |node|
      setup_node(node, name, ip, 1024, 15, vm_disk_path, public_key)
    end
  end

  {
    "postgres-01" => "192.168.60.103",
    "postgres-02" => "192.168.60.104",
    "postgres-03" => "192.168.60.105"
  }.each do |name, ip|
    config.vm.define name do |node|
      setup_node(node, name, ip, 2048, 25, vm_disk_path, public_key)
    end
  end

  config.vm.synced_folder ".", "/vagrant", disabled: true
end

