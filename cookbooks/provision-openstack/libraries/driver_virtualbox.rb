require 'chef/provisioning/vagrant_driver'

include Fragments::Drivers

# Contains the driver setup code for Chef Provisioning
class VirtualBoxDriver < Driver
  include VagrantMixin

  def name
    'VirtualBox'
  end

  def configure
    @chef_provisioning.with_driver(
      "vagrant:#{chef_root('vms')}"
    )

    fetch_box

    @ip_addresses = {}
  end

  def fetch_box
    box = ::Chef::Resource::VagrantBox.new(
      'centos7',
      ::Chef.node.run_context
    )
    box.url 'http://opscode-vm-bento.s3.amazonaws.com' \
            '/vagrant/virtualbox/opscode_centos-7.2_chef-provisionerless.box'
    box.run_action(:create)
  end

  def extra_machine_options(_machine)
    {
      vagrant_options: {
        'vm.box' => 'centos7'
      },
      convergence_options: {
        chef_version: '12.4.1',
        chef_config: ["log_location '/var/log/chef/client.log'",
                      'log_level :info'].join("\n")
      }
    }
  end
end

Driver.register('virtualbox', VirtualBoxDriver)
