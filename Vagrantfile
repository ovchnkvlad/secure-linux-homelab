# frozen_string_literal: true

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
      ansible.galaxy_role_file = "requirements.yml"
    end
  end
end

