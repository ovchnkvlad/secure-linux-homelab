# frozen_string_literal: true

ENV["ANSIBLE_COLLECTIONS_PATH"] = File.expand_path(".ansible/collections", __dir__)

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.hostname = "secure-linux-homelab"

  config.vm.define "homelab" do |node|
    node.vm.provider "virtualbox" do |provider|
      provider.name = "secure-linux-homelab"
      provider.memory = 1024
      provider.cpus = 1
    end

    node.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/site.yml"
      ansible.groups = {
        "homelab" => ["homelab"]
      }
      ansible.compatibility_mode = "2.0"
    end
  end
end

